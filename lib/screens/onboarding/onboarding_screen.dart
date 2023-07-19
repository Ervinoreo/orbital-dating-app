import 'package:dating_app/screens/onboarding/onboarding_screens/bio_screen.dart';
import 'package:dating_app/screens/onboarding/onboarding_screens/demo_screen.dart';
import 'package:dating_app/screens/onboarding/onboarding_screens/location_screen.dart';
import 'package:dating_app/screens/onboarding/onboarding_screens/pictures_screen.dart';
import 'package:dating_app/screens/onboarding/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

import '../../bloc/onboarding/onboarding_bloc.dart';
import 'onboarding_screens/start_screen.dart';

class OnboardingScreen extends StatelessWidget {
  static const String routeName = '/onboarding';

  static Route route() {
    return MaterialPageRoute(
      builder: (_) => OnboardingScreen(),
      // builder: (context) => MultiBlocProvider(
      //   providers: [
      //     BlocProvider<OnboardingBloc>(
      //       create: (_) => OnboardingBloc(
      //         databaseRepository: DatabaseRepository(),
      //         storageRepository: StorageRepository(),
      //       )..add(StartOnboarding()),
      //     ),
      //   ],
      //   child: OnboardingScreen(),
      // ),
      settings: RouteSettings(name: routeName),
    );
  }

  static const List<Tab> tabs = <Tab>[
    Tab(text: 'Start'),
    Tab(
      text: 'Demo',
    ),
    Tab(text: 'Biography'),
    Tab(
      text: 'Pictures',
    ),
    Tab(
      text: 'Location',
    )
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      child: Builder(builder: (BuildContext context) {
        final TabController tabController = DefaultTabController.of(context);
        tabController.addListener(() {
          if (!tabController.indexIsChanging) {}
        });

        return Scaffold(
          appBar: AppBar(
              backgroundColor: Colors.orange[900], title: Text('WassupNUS')),
          body: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 30.0,
              vertical: 50,
            ),
            child: BlocBuilder<OnboardingBloc, OnboardingState>(
              builder: (context, state) {
                if (state is OnboardingLoading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (state is OnboardingLoaded) {
                  return TabBarView(
                    children: [
                      StartScreen(
                        tabController: tabController,
                        state: state,
                      ),
                      DemographyScreen(
                        tabController: tabController,
                        state: state,
                      ),
                      Biography(
                        tabController: tabController,
                        state: state,
                      ),
                      PictureScreen(
                        tabController: tabController,
                        state: state,
                      ),
                      LocationTab(
                        tabController: tabController,
                        state: state,
                      ),
                    ],
                  );
                } else {
                  return Text('Something went wrong');
                }
              },
            ),
          ),
        );
      }),
    );
  }
}

class OnboardingScreenLayout extends StatelessWidget {
  final List<Widget> children;
  final int currentStep;
  final TabController tabController;

  const OnboardingScreenLayout({
    Key? key,
    required this.children,
    required this.currentStep,
    required this.tabController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minWidth: constraints.maxWidth,
              minHeight: constraints.maxHeight,
            ),
            child: IntrinsicHeight(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ...children,
                  Spacer(),
                  SizedBox(
                    height: 75,
                    child: Column(
                      children: [
                        StepProgressIndicator(
                          totalSteps: 4,
                          currentStep: currentStep,
                        ),
                        SizedBox(height: 10),
                        CustomButton(
                          tabController: tabController,
                          text: 'NEXT STEP',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
