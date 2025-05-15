import 'dart:convert';
import 'dart:ui';
import 'package:body_house_app/core/theme/colors.dart';
import 'package:body_house_app/layouts/layout.dart';
import 'package:body_house_app/screens/test.dart';
import 'package:body_house_app/widgets/app_text.dart';
import 'package:body_house_app/widgets/gradient_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_svg/svg.dart';
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
    final size = MediaQuery.of(context).size;
    return Layout(
      type: 4,
      child: Column(
        children: [
          SizedBox(
            height: size.height * 0.17,
            child: Padding(
              padding: EdgeInsets.only(top: 32.0, left: 16.0),
              child: Column(
                spacing: 8.0,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  GradientText(
                    type: 2,
                    child: AppText('Начни сейчас', align: TextAlign.left),
                  ),
                  AppText(
                    'Создайте учетную запись или войдите в систему, чтобы узнать больше о нашем приложении',
                    align: TextAlign.left,
                    size: 12.0,
                    color: AppColors.lightText,
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              width: size.width,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                  colors: [
                    Color(
                      0xFFFFFFFF,
                    ), // koniec: biały z 20% kryciem (alpha = 0x33)
                    Color(0xFFAAA8B0), // start: pełny
                  ],
                  stops: [0.0, 0.8],
                ),
                borderRadius: BorderRadius.vertical(top: Radius.circular(12.0)),
              ),
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Tabbing(),
                  const SizedBox(height: 22),
                  Text(
                    'Sign Up',
                    style: TextStyle(
                      color: Color(0xFF111827),
                      fontSize: 32,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Inter',
                      letterSpacing: -0.64,
                    ),
                  ),
                  const SizedBox(height: 14),
                  Text(
                    'Введите свой адрес электронной почты и пароль для регистрации',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF6C7278),
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Inter',
                      letterSpacing: -0.12,
                    ),
                  ),
                  const SizedBox(height: 14),
                  SignIn(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Tabbing extends StatelessWidget {
  const Tabbing({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 327,
          height: 36,
          padding: const EdgeInsets.all(2),
          clipBehavior: Clip.antiAlias,
          decoration: ShapeDecoration(
            color: Color(0xFFF5F6F9),
            shape: RoundedRectangleBorder(
              side: BorderSide(width: 1, color: Color(0xFFF5F5F9)),
              borderRadius: BorderRadius.circular(7),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Container(
                  height: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 12,
                  ),
                  clipBehavior: Clip.antiAlias,
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(7),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Log In',
                        style: TextStyle(
                          color: Color(0xFF7D7D91),
                          fontSize: 14,
                          fontFamily: 'Inter',
                          height: 0.11,
                          letterSpacing: -0.28,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 1),
              Expanded(
                child: Container(
                  height: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 12,
                  ),
                  clipBehavior: Clip.antiAlias,
                  decoration: ShapeDecoration(
                    color: Color(0xFF6F619B),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(width: 1, color: Color(0x7FEFF0F6)),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    shadows: [
                      BoxShadow(
                        color: Color(0x3DE4E5E7),
                        blurRadius: 2,
                        offset: Offset(0, 1),
                        spreadRadius: 0,
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Sign up',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontFamily: 'Inter',
                          height: 0.11,
                          letterSpacing: -0.28,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class SignIn extends StatelessWidget {
  const SignIn({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Email
        Container(
          height: 46,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Color(0xFFE5E7EB)), // subtelny border
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12),
          alignment: Alignment.center,
          child: const TextField(
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              hintText: 'Email',
              border: InputBorder.none,
              isCollapsed: true, // <-- pozwala lepiej kontrolować wysokość
            ),
            style: TextStyle(fontSize: 14),
          ),
        ),

        const SizedBox(height: 16),

        // Hasło
        Container(
          height: 46,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Color(0xFFE5E7EB)),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12),
          alignment: Alignment.center,
          child: const TextField(
            obscureText: true,
            decoration: InputDecoration(
              hintText: 'Hasło',
              border: InputBorder.none,
              isCollapsed: true,
            ),
            style: TextStyle(fontSize: 14),
          ),
        ),
      ],
    );
  }
}
