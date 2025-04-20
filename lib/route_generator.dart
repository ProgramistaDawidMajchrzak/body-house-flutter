import 'package:body_house_app/screens/calendar/calendar_screen.dart';
import 'package:body_house_app/screens/home/home_screen.dart';
import 'package:body_house_app/screens/profile/profile_screen.dart';
import 'package:body_house_app/screens/profile/auth/auth_screen.dart';
import 'package:body_house_app/screens/session/session_screen.dart';
import 'package:body_house_app/screens/shop/shop_screen.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class RouteGenerator {
  static Route<dynamic>? generateRoute(RouteSettings settings) {
    final dynamic args = settings.arguments;
    switch (settings.name) {
      //ONBOARDING
      case '/home':
        return PageTransition(
          child: const HomeScreen(),
          type: PageTransitionType.fade,
          settings: settings,
        );
      case '/sessions':
        return PageTransition(
          child: const SessionScreen(),
          type: PageTransitionType.fade,
          settings: settings,
        );
      case '/shop':
        return PageTransition(
          child: const ShopScreen(),
          type: PageTransitionType.fade,
          settings: settings,
        );
      case '/calendar':
        return PageTransition(
          child: const CalendarScreen(),
          type: PageTransitionType.fade,
          settings: settings,
        );
      case '/profile':
        return PageTransition(
          child: const ProfileScreen(),
          type: PageTransitionType.fade,
          settings: settings,
        );
      case '/profile/auth':
        return PageTransition(
          child: const AuthScreen(),
          type: PageTransitionType.fade,
          settings: settings,
        );
    }
    return null;
  }
}
