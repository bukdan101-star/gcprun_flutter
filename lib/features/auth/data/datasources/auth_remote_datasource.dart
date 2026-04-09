import '../../../../core/network/api_client.dart';
import '../../../../core/network/api_response.dart';
import '../../../../core/constants/api_constants.dart';
import '../models/user_model.dart';

class AuthRemoteDatasource {
  final ApiClient _apiClient;

  AuthRemoteDatasource(this._apiClient);

  Future<ApiResponse<Map<String, dynamic>>> login({
    required String email,
    required String password,
  }) async {
    return _apiClient.post<Map<String, dynamic>>(
      ApiConstants.login,
      data: {
        'email': email,
        'password': password,
      },
      fromJson: (data) => data as Map<String, dynamic>,
    );
  }

  Future<ApiResponse<Map<String, dynamic>>> register({
    required String name,
    required String email,
    required String phone,
    required String password,
  }) async {
    return _apiClient.post<Map<String, dynamic>>(
      ApiConstants.register,
      data: {
        'name': name,
        'email': email,
        'phone': phone,
        'password': password,
      },
      fromJson: (data) => data as Map<String, dynamic>,
    );
  }

  Future<ApiResponse<Map<String, dynamic>>> forgotPassword({
    required String email,
  }) async {
    return _apiClient.post<Map<String, dynamic>>(
      ApiConstants.forgotPassword,
      data: {'email': email},
      fromJson: (data) => data as Map<String, dynamic>,
    );
  }

  Future<ApiResponse<Map<String, dynamic>>> resetPassword({
    required String token,
    required String password,
  }) async {
    return _apiClient.post<Map<String, dynamic>>(
      ApiConstants.resetPassword,
      data: {
        'token': token,
        'password': password,
      },
      fromJson: (data) => data as Map<String, dynamic>,
    );
  }

  Future<ApiResponse<UserModel>> getMe() async {
    return _apiClient.get<UserModel>(
      ApiConstants.getMe,
      fromJson: (data) => UserModel.fromJson(data as Map<String, dynamic>),
    );
  }

  Future<ApiResponse<void>> logout() async {
    return _apiClient.post<void>(
      ApiConstants.logout,
    );
  }
}
