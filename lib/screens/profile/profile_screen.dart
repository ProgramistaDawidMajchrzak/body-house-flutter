import 'dart:convert';
import 'package:body_house_app/core/theme/colors.dart';
import 'package:body_house_app/layouts/layout.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String? _token;
  Map<String, dynamic>? _user;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');
    final userJson = prefs.getString('user');

    if (token != null && userJson != null) {
      setState(() {
        _token = token;
        _user = jsonDecode(userJson);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Layout(
      type: 1,
      child: Center(
        child:
            _token == null
                ? Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text('Niezalogowany'),
                    const SizedBox(height: 16),
                    IconButton(
                      icon: const Icon(Icons.login),
                      color: AppColors.light,
                      onPressed: () {
                        Navigator.pushNamed(context, '/profile/auth');
                      },
                    ),
                  ],
                )
                : Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text('Zalogowany jako:'),
                    const SizedBox(height: 8),
                    Text('Email: ${_user?['email']}'),
                    Text('Provider: ${_user?['provider']}'),
                    Text('ID: ${_user?['id']}'),
                    const SizedBox(height: 8),
                    Text('Token:'),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        _token!,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: _logout,
                      child: const Text('Wyloguj'),
                    ),
                  ],
                ),
      ),
    );
  }

  Future<void> _logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('auth_token');
    await prefs.remove('user');

    setState(() {
      _token = null;
      _user = null;
    });
  }
}
