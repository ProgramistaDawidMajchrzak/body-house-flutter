import 'package:body_house_app/core/theme/colors.dart';
import 'package:body_house_app/layouts/layout.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Layout(
      type: 1,
      child: Center(
        child: Column(
          children: [
            Text('Niezalogowany'),
            IconButton(
              icon: Icon(Icons.login),
              color: AppColors.light,
              onPressed: () {
                Navigator.pushNamed(context, '/profile/auth');
              },
            ),
          ],
        ),
      ),
    );
  }
}
