import 'dart:convert';
// import 'dart:ui';
import 'package:body_house_app/core/network/api_client.dart';
import 'package:body_house_app/core/theme/colors.dart';
import 'package:body_house_app/data/datasources/user_remote_datasource.dart';
import 'package:body_house_app/layouts/layout.dart';
// import 'package:body_house_app/screens/test.dart';
import 'package:body_house_app/widgets/app_text.dart';
import 'package:body_house_app/widgets/gradient_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_sign_in/google_sign_in.dart';

final FlutterSecureStorage secureStorage = FlutterSecureStorage();

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  String selectedTab = "Sign Up"; // domyślnie Sign Up
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final UserRemoteDataSource _userRemoteDataSource = UserRemoteDataSource(
    ApiClient(),
  );

  bool _isLoading = false;
  String? _error;

  void _login() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final email = _emailController.text.trim();
      final password = _passwordController.text.trim();

      final response = await _userRemoteDataSource.login(email, password);

      final token = response['token'];
      final user = response['user'];

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('auth_token', token);
      await prefs.setString('user', jsonEncode(user));
      if (!mounted) return; // jeśli jesteś w async metodzie w StatefulWidget
      Navigator.pushNamed(context, '/profile');
    } catch (e) {
      setState(() {
        _error = 'Błąd logowania: ${e.toString()}';
      });
      // print(
      //   "###################################### ERROR #####################################",
      // );
      // print(e.toString());
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void onTabChanged(String tab) {
    setState(() {
      selectedTab = tab;
    });
  }

  Future<void> loginWithFacebook() async {
    final result = await FacebookAuth.i.login(
      permissions: ['email', 'public_profile'],
    );

    if (result.status == LoginStatus.success) {
      print("#################################Result: $result");
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

        // Zapis do SharedPreferences
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('auth_token', token);
        await prefs.setString('user', jsonEncode(user));

        print("✅ Zalogowano jako: ${user['email']}");

        // Nawigacja do profilu
        Navigator.pushNamed(context, '/profile');
      } else {
        print("Błąd logowania przez backend: ${response.body}");
      }
    } else {
      print("Błąd logowania Facebook SDK: ${result.message}");
    }
  }

  Future<void> loginWithGoogle() async {
    try {
      final googleSignIn = GoogleSignIn(scopes: ['email']);
      final googleUser = await googleSignIn.signIn();

      if (googleUser == null) {
        print("❌ Anulowano logowanie Google");
        return;
      }

      final googleAuth = await googleUser.authentication;
      final idToken = googleAuth.idToken;

      if (idToken == null) {
        print("❌ Nie udało się pobrać ID Tokena");
        return;
      }

      final response = await http.post(
        Uri.parse('http://10.0.2.2:5000/api/auth/google'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'idToken': idToken}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final token = data['token'];
        final user = data['user'];

        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('auth_token', token);
        await prefs.setString('user', jsonEncode(user));

        print("✅ Zalogowano przez Google: ${user['email']}");
        Navigator.pushNamed(context, '/profile');
      } else {
        print("❌ Błąd backendu: ${response.body}");
      }
    } catch (e) {
      print("❌ Błąd logowania Google: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Layout(
      showBottomNavBar: false,
      type: 4,
      child: Column(
        children: [
          SizedBox(
            height: size.height * 0.20,
            child: Padding(
              padding: EdgeInsets.only(top: 32.0, left: 16.0, right: 16.0),
              child: Column(
                spacing: 8.0,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  GradientText(
                    type: 2,
                    child: AppText('Начни сейчас', align: TextAlign.left),
                  ),
                  AppText(
                    'Создайте аккаунт или войдите, чтобы узнать больше о нашем приложении',
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
                  Tabbing(selectedTab: selectedTab, onTabChanged: onTabChanged),
                  const SizedBox(height: 24),
                  Text(
                    selectedTab == "Sign Up" ? 'Зарегистрироваться' : 'Войти',
                    style: TextStyle(
                      color: Color(0xFF111827),
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Inter',
                      letterSpacing: -0.64,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    selectedTab == "Sign Up"
                        ? 'Введите свой email и пароль, чтобы зарегистрироваться'
                        : 'Введите свою эл. почту и пароль, чтобы войти',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF6C7278),
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Inter',
                      letterSpacing: -0.12,
                    ),
                  ),
                  const SizedBox(height: 24),
                  SignIn(
                    selectedTab: selectedTab,
                    onFacebookLogin: loginWithFacebook,
                    onGoogleLogin: loginWithGoogle,
                    onLogInPressed: _login,
                    emailController: _emailController,
                    passwordController: _passwordController,
                  ),
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
  final String selectedTab;
  final void Function(String)? onTabChanged;

  const Tabbing({super.key, required this.selectedTab, this.onTabChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 327,
      height: 36,
      padding: const EdgeInsets.all(2),
      clipBehavior: Clip.antiAlias,
      decoration: ShapeDecoration(
        color: const Color(0xFFF5F6F9),
        shape: RoundedRectangleBorder(
          side: const BorderSide(width: 1, color: Color(0xFFF5F5F9)),
          borderRadius: BorderRadius.circular(7),
        ),
      ),
      child: Row(
        children: [
          // Log In Button
          Expanded(
            child: GestureDetector(
              onTap: () => onTabChanged?.call("Log In"),
              child: Container(
                height: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 12,
                ),
                clipBehavior: Clip.antiAlias,
                decoration: ShapeDecoration(
                  color:
                      selectedTab == "Log In"
                          ? const Color(0xFF6F619B)
                          : const Color(0xFFF5F6F9),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(7),
                  ),
                  shadows:
                      selectedTab == "Log In"
                          ? [
                            const BoxShadow(
                              color: Color(0x3DE4E5E7),
                              blurRadius: 2,
                              offset: Offset(0, 1),
                              spreadRadius: 0,
                            ),
                          ]
                          : null,
                ),
                child: Center(
                  child: Text(
                    'Войти',
                    style: TextStyle(
                      color:
                          selectedTab == "Log In"
                              ? Colors.white
                              : const Color(0xFF7D7D91),
                      fontSize: 12,
                      fontFamily: 'Inter',
                      height: 0.11,
                      letterSpacing: -0.28,
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 1),
          // Sign Up Button
          Expanded(
            child: GestureDetector(
              onTap: () => onTabChanged?.call("Sign Up"),
              child: Container(
                height: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 12,
                ),
                clipBehavior: Clip.antiAlias,
                decoration: ShapeDecoration(
                  color:
                      selectedTab == "Sign Up"
                          ? const Color(0xFF6F619B)
                          : const Color(0xFFF5F6F9),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(7),
                  ),
                  shadows:
                      selectedTab == "Sign Up"
                          ? [
                            const BoxShadow(
                              color: Color(0x3DE4E5E7),
                              blurRadius: 2,
                              offset: Offset(0, 1),
                              spreadRadius: 0,
                            ),
                          ]
                          : null,
                ),
                child: Center(
                  child: Text(
                    'Зарегистрироваться',
                    style: TextStyle(
                      color:
                          selectedTab == "Sign Up"
                              ? Colors.white
                              : const Color(0xFF7D7D91),
                      fontSize: 12,
                      fontFamily: 'Inter',
                      height: 0.11,
                      letterSpacing: -0.28,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SignIn extends StatelessWidget {
  final String selectedTab;
  final Future<void> Function() onFacebookLogin;
  final Future<void> Function() onGoogleLogin;
  final VoidCallback onLogInPressed;
  final TextEditingController emailController;
  final TextEditingController passwordController;

  const SignIn({
    super.key,
    required this.selectedTab,
    required this.onFacebookLogin,
    required this.onGoogleLogin,
    required this.emailController,
    required this.passwordController,
    required this.onLogInPressed,
  });

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
          child: TextField(
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              hintText: 'Email',
              border: InputBorder.none,
              isCollapsed: true, // <-- pozwala lepiej kontrolować wysokość
            ),
            style: const TextStyle(fontSize: 14, fontFamily: 'Inter'),
          ),
        ),

        const SizedBox(height: 8),

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
          child: TextField(
            controller: passwordController,
            obscureText: true,
            decoration: const InputDecoration(
              hintText: 'Пароль',
              border: InputBorder.none,
              isCollapsed: true,
            ),
            style: const TextStyle(fontSize: 14, fontFamily: 'Inter'),
          ),
        ),
        const SizedBox(height: 32),
        SizedBox(
          height: 46,
          width: double.infinity,
          child: ElevatedButton(
            onPressed: onLogInPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF6F619B), // kolor tła
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8), // taki sam jak input
              ),
              padding: EdgeInsets.zero, // usuwa domyślne paddingi
            ),
            child: Text(
              selectedTab == "Sign Up" ? 'Зарегистрироваться' : 'Войти',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        const SizedBox(height: 14),
        Row(
          children: [
            Expanded(
              child: Container(
                height: 1, // <-- wysokość linii
                color: Colors.white, // <-- kolor linii
              ),
            ),
            const SizedBox(width: 16),
            Text(
              'Или войдите через',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFF6C7278),
                fontSize: 12,
                fontFamily: 'Inter',
                height: 1.4, // poprawiona wysokość tekstu
                letterSpacing: -0.12,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(child: Container(height: 1, color: Colors.white)),
          ],
        ),
        const SizedBox(height: 12),
        Container(
          width: 345,
          height: 48,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: onGoogleLogin,
                  child: Container(
                    height: 48,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 10,
                    ),
                    clipBehavior: Clip.antiAlias,
                    decoration: ShapeDecoration(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(width: 1, color: Color(0xFFEFF0F6)),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 18,
                          height: 18,
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(),
                          child: SvgPicture.asset(
                            'assets/images/auth_google.svg',
                            width: 50,
                            height: 50,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: GestureDetector(
                  onTap: onFacebookLogin,
                  child: Container(
                    height: 48,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 10,
                    ),
                    clipBehavior: Clip.antiAlias,
                    decoration: ShapeDecoration(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(width: 1, color: Color(0xFFEFF0F6)),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 18,
                          height: 18,
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(),
                          child: SvgPicture.asset(
                            'assets/images/auth_fb.svg',
                            width: 50,
                            height: 50,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Container(
                  height: 48,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 10,
                  ),
                  clipBehavior: Clip.antiAlias,
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(width: 1, color: Color(0xFFEFF0F6)),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 18,
                        height: 18,
                        padding: const EdgeInsets.symmetric(horizontal: 1.66),
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Container(
                                height: double.infinity,
                                child: SvgPicture.asset(
                                  'assets/images/auth_apple.svg',
                                  width: 50,
                                  height: 50,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),

        // // Hasło
        // Container(
        //   height: 46,
        //   decoration: BoxDecoration(
        //     color: Colors.white,
        //     borderRadius: BorderRadius.circular(8),
        //     border: Border.all(color: Color(0xFFE5E7EB)),
        //   ),
        //   padding: const EdgeInsets.symmetric(horizontal: 12),
        //   alignment: Alignment.center,
        //   child: const TextField(
        //     obscureText: true,
        //     decoration: InputDecoration(
        //       hintText: 'Повторите пароль',
        //       border: InputBorder.none,
        //       isCollapsed: true,
        //     ),
        //     style: TextStyle(fontSize: 14),
        //   ),
        // ),
      ],
    );
  }
}
