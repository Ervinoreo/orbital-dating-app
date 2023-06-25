import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

import '../../../bloc/onboarding/onboarding_bloc.dart';
import '../widgets/widgets.dart';

class Biography extends StatelessWidget {
  final TabController tabController;

  const Biography({
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
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  CustomTextHeader(
                      tabController: tabController,
                      text: 'Describe Yourself In A Few Words'),
                  CustomTextField(
                    tabController: tabController,
                    text: 'Enter Your Bio',
                    onChanged: (value) {
                      context.read<OnboardingBloc>().add(
                          UpdateUser(user: state.user.copyWith(bio: value)));
                    },
                  ),
                  SizedBox(
                    height: 100,
                  ),
                  CustomTextHeader(
                      tabController: tabController, text: 'What Do You Like?'),
                  Row(
                    children: [
                      CustomTextContainer(
                        tabController: tabController,
                        text: 'Music',
                      ),
                      CustomTextContainer(
                        tabController: tabController,
                        text: 'Economics',
                      ),
                      CustomTextContainer(
                        tabController: tabController,
                        text: 'Mathematics',
                      ),
                      CustomTextContainer(
                        tabController: tabController,
                        text: 'Politics',
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      CustomTextContainer(
                        tabController: tabController,
                        text: 'Art',
                      ),
                      CustomTextContainer(
                        tabController: tabController,
                        text: 'Hiking',
                      ),
                      CustomTextContainer(
                        tabController: tabController,
                        text: 'Drawing',
                      ),
                      CustomTextContainer(
                        tabController: tabController,
                        text: 'Eating',
                      ),
                    ],
                  ),
                ]),
                Column(
                  children: [
                    StepProgressIndicator(
                      totalSteps: 4,
                      currentStep: 2,
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
