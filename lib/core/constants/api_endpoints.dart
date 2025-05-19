// wszystkie ścieżki do endpointów
class ApiEndpoints {
  // static const String baseUrl = 'http://localhost:5000/api';
  // static const String baseUrl = 'http://10.0.2.2:5000/api';
  static const String baseUrl = 'http://192.168.0.15:5000/api';

  static const String login = '$baseUrl/auth/login';
  static const String register = '$baseUrl/auth/register';
  static const String getUser = '$baseUrl/users';
}
