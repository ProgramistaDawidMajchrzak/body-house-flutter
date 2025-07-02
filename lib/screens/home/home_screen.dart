import 'package:body_house_app/layouts/layout.dart';
import 'package:body_house_app/screens/home/live_session_bar.dart';
import 'package:body_house_app/screens/home/my_sessions.dart';
import 'package:body_house_app/screens/home/recommendations.dart';
import 'package:body_house_app/screens/home/session_of_a_day.dart';
import 'package:flutter/material.dart';
import './incoming_session.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Layout(
      type: 1,
      child: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            IncomingSession(),
            SizedBox(height: 12),
            SessionOfADay(),
            LiveSessionBar(),
            SizedBox(height: 8),
            MySessions(),
            SizedBox(height: 8),
            Recommendations(),
          ],
        ),
      ),
    );
  }
}
