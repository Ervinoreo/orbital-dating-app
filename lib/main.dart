import 'package:dating_app/config/app_router.dart';
import 'package:dating_app/repositories/database/database_repository.dart';
import 'package:dating_app/repositories/storage/storage_repository.dart';
import 'package:dating_app/screens/login/auth_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'bloc/onboarding/onboarding_bloc.dart';
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
                  SwipeBloc()..add(LoadUsersEvent(users: UserUI.users))),
          BlocProvider<OnboardingBloc>(
            create: (_) => OnboardingBloc(
              databaseRepository: DatabaseRepository(),
              storageRepository: StorageRepository(),
            )..add(StartOnboarding()),
          )
        ],
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(primaryColor: Colors.blue),
          onGenerateRoute: AppRouter.onGenerateRoute,
          initialRoute: AuthPage.routeName,
        ));
  }
}
