import 'package:flutter/material.dart';

import '/models/models.dart';
import '/screens/screens.dart';
import '/models/match_model.dart';

import 'package:dating_app/screens/login/auth_page.dart';

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
      case ChatScreen.routeName:
        return ChatScreen.route(userMatch: settings.arguments as Match);
      case OnboardingScreen.routeName:
        return OnboardingScreen.route();
      case MatchesScreen.routeName:
        return MatchesScreen.route();
      case UserScreen.routeName:
        return UserScreen.route(user: settings.arguments as UserUI);
      case MatchesScreen.routeName:
        return MatchesScreen.route();
      case ProfileScreen.routeName:
        return ProfileScreen.route();
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
