import 'package:body_house_app/layouts/layout.dart';
import 'package:flutter/material.dart';

class SessionScreen extends StatelessWidget {
  const SessionScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Layout(type: 1, child: Center(child: Text('SessionScreen')));
  }
}
