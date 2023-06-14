import 'package:dating_app/config/app_router.dart';
import 'package:dating_app/screens/home/home_screen.dart';
import 'package:dating_app/screens/login/auth_page.dart';
import 'package:dating_app/screens/profile/profile_screen.dart';
import 'package:dating_app/screens/chat/chat_screen.dart';
import 'package:dating_app/screens/matches/matches_screen.dart';
import 'package:dating_app/screens/user/user_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'bloc/swipe/swipe_bloc.dart';
import 'firebase_options.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'models/models.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (_) =>
                  SwipeBloc()..add(LoadUsersEvent(users: UserUI.users)))
        ],
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(primaryColor: Colors.blue),
          onGenerateRoute: AppRouter.onGenerateRoute,
          initialRoute: MatchesScreen.routeName,
        ));
  }
}
