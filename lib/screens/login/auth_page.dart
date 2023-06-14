import 'package:dating_app/screens/login/login_or_register_screen.dart';
import 'package:dating_app/screens/screens.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  static const String routeName = '/auth';

  static Route route() {
    return MaterialPageRoute(
      builder: (_) => AuthPage(),
      settings: RouteSettings(name: routeName),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return HomeScreen();
          } else {
            return LoginOrRegisterScreen();
          }
        },
      ),
    );
  }
}
