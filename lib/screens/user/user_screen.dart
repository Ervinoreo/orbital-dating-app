import 'package:flutter/material.dart';

class UserScreen extends StatelessWidget {
  static const String routeName = '/user';

  static Route route() {
    return MaterialPageRoute(
      builder: (_) => UserScreen(),
      settings: RouteSettings(name: routeName),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('User')),
      body: ElevatedButton(
        child: Text('Login'),
        onPressed: () {
          Navigator.pushNamed(context, '/login');
        },
      ),
    );
  }
}
