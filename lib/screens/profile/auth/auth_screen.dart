import 'dart:convert';
import 'package:body_house_app/layouts/layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final FlutterSecureStorage secureStorage = FlutterSecureStorage();

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  Future<void> loginWithFacebook() async {
    final result = await FacebookAuth.i.login(
      permissions: ['email', 'public_profile'],
    );

    if (result.status == LoginStatus.success) {
      print(
        "#################################AccessToken: ${result.accessToken!.tokenString}",
      );
      final accessToken = result.accessToken!.tokenString;

      final response = await http.post(
        //tutaj error
        // Uri.parse('http://localhost:5000/api/auth/facebook'),
        Uri.parse('http://10.0.2.2:5000/api/auth/facebook'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'accessToken': accessToken}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final token = data['token'];
        final user = data['user'];
        await secureStorage.write(key: 'jwt_token', value: token);

        print("Zalogowano jako: ${user['email']}, token zapisany");
        // Tutaj zapisujesz token i przechodzisz dalej
      } else {
        print("Błąd logowania przez backend: ${response.body}");
      }
    } else {
      print("Błąd logowania Facebook SDK: ${result.message}");
    }
  }

  //wylogowanie
  // Future<void> logout() async {
  //   await secureStorage.delete(key: 'jwt_token');
  //   print("Wylogowano i usunięto token.");
  // }

  @override
  Widget build(BuildContext context) {
    return Layout(
      type: 1,
      child: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                loginWithFacebook();
              },
              child: Text("Zaloguj się przez Facebooka"),
            ),
          ],
        ),
      ),
    );
  }
}
