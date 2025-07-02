import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:body_house_app/route_generator.dart';
import 'package:body_house_app/screens/profile/auth/auth_screen.dart';
import 'package:body_house_app/screens/home/home_screen.dart';
import 'splash/splash_screen.dart';
import 'core/theme/theme.dart';
import 'package:intl/date_symbol_data_local.dart'; // <- wymagane

// 🔧 Uczyń main() asynchronicznym
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('ru_RU', null); // <- lokalizacja rosyjska
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final FlutterSecureStorage secureStorage = FlutterSecureStorage();
  bool _isLoading = true;
  bool _isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    final token = await secureStorage.read(key: 'jwt_token');
    setState(() {
      _isLoggedIn = token != null;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const MaterialApp(
        home: SplashScreen(),
        debugShowCheckedModeBanner: false,
      );
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: RouteGenerator.generateRoute,
      theme: appTheme,
      title: 'Body House',
      home: const HomeScreen(),
    );
  }
}
