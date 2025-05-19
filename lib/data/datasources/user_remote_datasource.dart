import '../../core/network/api_client.dart';
import '../../core/constants/api_endpoints.dart';

class UserRemoteDataSource {
  final ApiClient _apiClient;

  UserRemoteDataSource(this._apiClient);

  /// Pobiera dane użytkownika
  // Future<dynamic> fetchUser() async {
  //   try {
  //     final response = await _apiClient.get(ApiEndpoints.getUser);
  //     return response;
  //   } catch (e) {
  //     rethrow;
  //   }
  // }

  /// Logowanie użytkownika
  Future<dynamic> login(String email, String password) async {
    try {
      final body = {'email': email, 'password': password};

      final response = await _apiClient.post(ApiEndpoints.login, body);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  /// Rejestracja użytkownika
  Future<dynamic> register(String email, String password, String name) async {
    try {
      final body = {'email': email, 'password': password, 'name': name};

      final response = await _apiClient.post(ApiEndpoints.register, body);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
