import '../entities/user_entity.dart';

abstract class AuthRepository {
  Future<UserEntity?> getCurrentUser();
  Future<bool> login({required String email, required String password});
  Future<bool> register({required String name, required String email, required String phone, required String password});
  Future<bool> forgotPassword({required String email});
  Future<bool> resetPassword({required String token, required String password});
  Future<void> logout();
}
