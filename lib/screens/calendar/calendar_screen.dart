import 'package:body_house_app/layouts/layout.dart';
import 'package:flutter/material.dart';

class CalendarScreen extends StatelessWidget {
  const CalendarScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Layout(type: 1, child: Center(child: Text('CalendarScreen')));
  }
}
