import 'package:dating_app/bloc/match/match_bloc.dart';
import 'package:dating_app/bloc/profile/profile_bloc.dart';
import 'package:dating_app/config/app_router.dart';
import 'package:dating_app/repositories/database/database_repository.dart';
import 'package:dating_app/repositories/location/location_repository.dart';
import 'package:dating_app/repositories/storage/storage_repository.dart';
import 'package:dating_app/screens/login/auth_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'bloc/onboarding/onboarding_bloc.dart';
import 'bloc/swipe/swipe_bloc.dart';
import 'firebase_options.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => DatabaseRepository(),
        ),
      ],
      child: MultiBlocProvider(
          providers: [
            BlocProvider(
                create: (context) =>
                    SwipeBloc(databaseRepository: DatabaseRepository())),
            BlocProvider<OnboardingBloc>(
              create: (_) => OnboardingBloc(
                databaseRepository: DatabaseRepository(),
                storageRepository: StorageRepository(),
                locationRepository: LocationRepository(),
              )..add(StartOnboarding()),
            ),
            BlocProvider(
                create: (context) => ProfileBloc(
                    databaseRepository: DatabaseRepository(),
                    locationRepository: LocationRepository())
                  ..add(LoadProfile(
                      userId: FirebaseAuth.instance.currentUser!.uid))),
            BlocProvider(
                create: (context) =>
                    MatchBloc(databaseRepository: DatabaseRepository())),
            //BlocProvider(create: (context) => ChatBloc(databaseRepository: DatabaseRepository())..add(LoadChat(match.chat.id))),
          ],
          child: MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(primaryColor: Colors.blue),
            onGenerateRoute: AppRouter.onGenerateRoute,
            initialRoute: AuthPage.routeName,
          )),
    );
  }
}
