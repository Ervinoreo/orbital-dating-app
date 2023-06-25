import 'package:dating_app/screens/onboarding/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

import '../../../bloc/onboarding/onboarding_bloc.dart';

class LocationScreen extends StatelessWidget {
  final TabController tabController;

  const LocationScreen({
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
              mainAxisSize: MainAxisSize.max,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomTextHeader(
                        tabController: tabController, text: 'Where Are You?'),
                    CustomTextField(
                      tabController: tabController,
                      text: 'Enter Your Location',
                      onChanged: (value) {
                        context.read<OnboardingBloc>().add(UpdateUser(
                            user: state.user.copyWith(location: value)));
                      },
                    ),
                  ],
                ),
                Column(
                  children: [
                    StepProgressIndicator(
                      totalSteps: 4,
                      currentStep: 4,
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
                )
              ]),
        );
      } else {
        return Text('Something Went Wrong!');
      }
    });
  }
}
