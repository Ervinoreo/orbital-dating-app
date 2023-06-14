import 'package:dating_app/screens/onboarding/onboarding_screens/bio_screen.dart';
import 'package:dating_app/screens/onboarding/onboarding_screens/demo_screen.dart';
import 'package:dating_app/screens/onboarding/onboarding_screens/pictures_screen.dart';
import 'package:flutter/material.dart';

import 'onboarding_screens/start_screen.dart';

class OnboardingScreen extends StatelessWidget {
  static const String routeName = '/onboarding';

  static Route route() {
    return MaterialPageRoute(
      builder: (_) => OnboardingScreen(),
      settings: RouteSettings(name: routeName),
    );
  }

  static const List<Tab> tabs = <Tab>[
    Tab(text: 'Start'),
    Tab(
      text: 'Demo',
    ),
    Tab(text: 'Pictures'),
    Tab(
      text: 'Biography',
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
          body: TabBarView(
            children: [
              StartScreen(tabController: tabController),
              DemographyScreen(tabController: tabController),
              PictureScreen(tabController: tabController),
              Biography(tabController: tabController),
            ],
          ),
        );
      }),
    );
  }
}
