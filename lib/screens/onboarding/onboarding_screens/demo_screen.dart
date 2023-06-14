import 'package:flutter/material.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

import '../widgets/widgets.dart';

class DemographyScreen extends StatelessWidget {
  final TabController tabController;

  const DemographyScreen({
    Key? key,
    required this.tabController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 50.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextHeader(
                tabController: tabController,
                text: 'What\'s Your Gender?',
              ),
              CustomCheckBox(tabController: tabController, text: 'MALE'),
              CustomCheckBox(tabController: tabController, text: 'FEMALE'),
              SizedBox(
                height: 100,
              ),
              CustomTextHeader(
                tabController: tabController,
                text: 'What\'s Your Age?',
              ),
              CustomTextField(
                  tabController: tabController, text: 'ENTER YOUR AGE'),
            ],
          ),
          Column(
            children: [
              StepProgressIndicator(
                totalSteps: 3,
                currentStep: 1,
                selectedColor: Colors.orange,
              ),
              SizedBox(
                height: 10,
              ),
              CustomButton(
                tabController: tabController,
                text: 'NEXT STEP',
              )
            ],
          ),
        ],
      ),
    );
  }
}
