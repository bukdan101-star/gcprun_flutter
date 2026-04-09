import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../../core/network/api_client.dart';
import '../../../../core/network/api_response.dart';
import '../data/datasources/auth_remote_datasource.dart';
import '../data/models/user_model.dart';

class AuthState {
  final UserModel? user;
  final bool isLoading;
  final bool isAuthenticated;
  final String? error;

  const AuthState({
    this.user,
    this.isLoading = false,
    this.isAuthenticated = false,
    this.error,
  });

  AuthState copyWith({
    UserModel? user,
    bool? isLoading,
    bool? isAuthenticated,
    String? error,
    bool clearError = false,
  }) {
    return AuthState(
      user: user ?? this.user,
      isLoading: isLoading ?? this.isLoading,
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      error: clearError ? null : (error ?? this.error),
    );
  }
}

class AuthNotifier extends Notifier<AuthState> {
  late final AuthRemoteDatasource _datasource;
  late final ApiClient _apiClient;

  @override
  AuthState build() {
    _apiClient = ApiClient();
    _datasource = AuthRemoteDatasource(_apiClient);
    checkAuth();
    return const AuthState();
  }

  Future<void> checkAuth() async {
    final hasToken = await _apiClient.hasToken();
    if (!hasToken) {
      state = const AuthState(isAuthenticated: false);
      return;
    }

    state = state.copyWith(isLoading: true, clearError: true);

    try {
      final response = await _datasource.getMe();
      if (response.success && response.data != null) {
        state = AuthState(
          user: response.data,
          isAuthenticated: true,
          isLoading: false,
        );
      } else {
        await _apiClient.clearTokens();
        state = const AuthState(isAuthenticated: false, isLoading: false);
      }
    } catch (e) {
      debugPrint('Auth check error: $e');
      await _apiClient.clearTokens();
      state = const AuthState(isAuthenticated: false, isLoading: false);
    }
  }

  Future<bool> login({
    required String email,
    required String password,
  }) async {
    state = state.copyWith(isLoading: true, clearError: true);

    try {
      final response = await _datasource.login(
        email: email,
        password: password,
      );

      if (response.success && response.data != null) {
        final data = response.data!;
        final accessToken = data['accessToken'] as String?;
        final refreshToken = data['refreshToken'] as String?;

        if (accessToken != null && refreshToken != null) {
          await _apiClient.saveTokens(
            accessToken: accessToken,
            refreshToken: refreshToken,
          );
        }

        final userJson = data['user'];
        if (userJson != null) {
          final user = UserModel.fromJson(userJson as Map<String, dynamic>);
          state = AuthState(
            user: user,
            isAuthenticated: true,
            isLoading: false,
          );
        } else {
          await checkAuth();
        }
        return true;
      } else {
        state = state.copyWith(
          isLoading: false,
          error: response.message ?? 'Login gagal',
        );
        return false;
      }
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'Terjadi kesalahan. Silakan coba lagi.',
      );
      return false;
    }
  }

  Future<bool> register({
    required String name,
    required String email,
    required String phone,
    required String password,
  }) async {
    state = state.copyWith(isLoading: true, clearError: true);

    try {
      final response = await _datasource.register(
        name: name,
        email: email,
        phone: phone,
        password: password,
      );

      if (response.success) {
        state = state.copyWith(isLoading: false);
        return true;
      } else {
        state = state.copyWith(
          isLoading: false,
          error: response.message ?? 'Registrasi gagal',
        );
        return false;
      }
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'Terjadi kesalahan. Silakan coba lagi.',
      );
      return false;
    }
  }

  Future<void> logout() async {
    try {
      await _datasource.logout();
    } catch (_) {}

    await _apiClient.clearTokens();
    state = const AuthState(isAuthenticated: false);
  }

  void clearError() {
    state = state.copyWith(clearError: true);
  }
}

final authNotifierProvider = NotifierProvider<AuthNotifier, AuthState>(
  AuthNotifier.new,
);

final apiClientProvider = Provider<ApiClient>((ref) {
  return ApiClient();
});

final authDatasourceProvider = Provider<AuthRemoteDatasource>((ref) {
  final apiClient = ref.watch(apiClientProvider);
  return AuthRemoteDatasource(apiClient);
});
