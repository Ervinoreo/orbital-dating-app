import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

import '../../../bloc/onboarding/onboarding_bloc.dart';
import '../widgets/widgets.dart';

class DemographyScreen extends StatelessWidget {
  final TabController tabController;

  const DemographyScreen({
    Key? key,
    required this.tabController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnboardingBloc, OnboardingState>(
      builder: (context, state) {
        if (state is OnboardingLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        if (state is OnboardingLoaded) {
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
                    CustomCheckBox(
                      tabController: tabController,
                      text: 'MALE',
                      value: state.user.gender == 'Male',
                      onChanged: (bool? newValue) {
                        context.read<OnboardingBloc>().add(UpdateUser(
                            user: state.user.copyWith(gender: 'Male')));
                      },
                    ),
                    CustomCheckBox(
                      tabController: tabController,
                      text: 'FEMALE',
                      value: state.user.gender == 'Female',
                      onChanged: (bool? newValue) {
                        context.read<OnboardingBloc>().add(UpdateUser(
                            user: state.user.copyWith(gender: 'Female')));
                      },
                    ),
                    SizedBox(
                      height: 100,
                    ),
                    CustomTextHeader(
                      tabController: tabController,
                      text: 'What\'s Your Age?',
                    ),
                    CustomTextField(
                      tabController: tabController,
                      text: 'ENTER YOUR AGE',
                      onChanged: (value) {
                        context.read<OnboardingBloc>().add(UpdateUser(
                            user: state.user.copyWith(age: int.parse(value))));
                      },
                    ),
                  ],
                ),
                Column(
                  children: [
                    StepProgressIndicator(
                      totalSteps: 4,
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
        } else {
          return Text('Something went wrong!');
        }
      },
    );
  }
}
