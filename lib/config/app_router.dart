import 'package:dating_app/screens/chat/chat_screen.dart';
import 'package:dating_app/screens/home/home_screen.dart';
import 'package:dating_app/screens/login/auth_page.dart';
import 'package:dating_app/screens/login/login_screen.dart';
import 'package:dating_app/screens/matches/matches_screen.dart';
import 'package:dating_app/screens/user/user_screen.dart';
import 'package:flutter/material.dart';

class AppRouter {
  static Route onGenerateRoute(RouteSettings settings) {
    print('The Route is: ${settings.name}');

    switch (settings.name) {
      case '/':
        return HomeScreen.route();
      case HomeScreen.routeName:
        return HomeScreen.route();
      case AuthPage.routeName:
        return AuthPage.route();
      case LoginScreen.routeName:
        return LoginScreen.route();
      case ChatScreen.routeName:
        return ChatScreen.route();
      case MatchesScreen.routeName:
        return MatchesScreen.route();
      case UserScreen.routeName:
        return UserScreen.route();
      default:
        return _errorRoute();
    }
  }

  static Route _errorRoute() {
    return MaterialPageRoute(
        builder: (_) => Scaffold(
              appBar: AppBar(
                title: Text('error'),
              ),
            ),
        settings: RouteSettings(name: '/error'));
  }
}
