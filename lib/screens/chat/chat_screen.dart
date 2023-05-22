import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  static const String routeName = '/chat';

  static Route route() {
    return MaterialPageRoute(
      builder: (_) => ChatScreen(),
      settings: RouteSettings(name: routeName),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Chat')),
      body: ElevatedButton(
        child: Text('Login'),
        onPressed: () {
          Navigator.pushNamed(context, '/login');
        },
      ),
    );
  }
}
