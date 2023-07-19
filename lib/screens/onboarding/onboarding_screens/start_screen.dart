import 'package:dating_app/screens/onboarding/widgets/custom_button.dart';
import 'package:flutter/material.dart';

import '../../../bloc/onboarding/onboarding_bloc.dart';

class StartScreen extends StatelessWidget {
  final TabController tabController;
  final OnboardingLoaded state;

  const StartScreen({
    Key? key,
    required this.tabController,
    required this.state,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 50.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Container(
                height: 200,
                width: 200,
                child: Image.asset('assets/wassupnus logo 2.png'),
              ),
              SizedBox(
                height: 50,
              ),
              Text(
                'Welcome to WassupNUS!',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Start your new journey',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 14, fontWeight: FontWeight.normal, height: 1.8),
              ),
            ],
          ),
          CustomButton(tabController: tabController)
        ],
      ),
    );
  }
}
