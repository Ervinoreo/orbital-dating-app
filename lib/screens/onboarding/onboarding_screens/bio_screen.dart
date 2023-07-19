import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

import '../../../bloc/onboarding/onboarding_bloc.dart';
import '../onboarding_screen.dart';
import '../widgets/widgets.dart';

class Biography extends StatelessWidget {
  final TabController tabController;
  final OnboardingLoaded state;

  const Biography({
    Key? key,
    required this.tabController,
    required this.state,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OnboardingScreenLayout(
      children: [
        CustomTextHeader(
            tabController: tabController,
            text: 'Describe Yourself In A Few Words'),
        CustomTextField(
          text: 'Enter Your Bio',
          onChanged: (value) {
            context
                .read<OnboardingBloc>()
                .add(UpdateUser(user: state.user.copyWith(bio: value)));
          },
        ),
        SizedBox(
          height: 50,
        ),
        CustomTextHeader(
            tabController: tabController, text: 'What do you do/study?'),
        CustomTextField(
          text: 'Enter Your Course Or Job',
          onChanged: (value) {
            context
                .read<OnboardingBloc>()
                .add(UpdateUser(user: state.user.copyWith(jobTitle: value)));
          },
        ),
        SizedBox(
          height: 10,
        ),
        CustomTextHeader(
            tabController: tabController, text: 'What Do You Like?'),
        CustomTextField(
          text: 'Enter Your Interests',
          onChanged: (value) {
            context
                .read<OnboardingBloc>()
                .add(UpdateUser(user: state.user.copyWith(interests: value)));
          },
        ),
      ],
      currentStep: 2,
      tabController: tabController,
    );
    // return Padding(
    //   padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 50.0),
    //   child: Column(
    //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //     children: [

    //   // Row(
    //   //   children: [
    //   //     CustomTextContainer(
    //   //       tabController: tabController,
    //   //       text: 'Music',
    //   //     ),
    //   //     CustomTextContainer(
    //   //       tabController: tabController,
    //   //       text: 'Economics',
    //   //     ),
    //   //     CustomTextContainer(
    //   //       tabController: tabController,
    //   //       text: 'Mathematics',
    //   //     ),
    //   //     CustomTextContainer(
    //   //       tabController: tabController,
    //   //       text: 'Politics',
    //   //     ),
    //   //   ],
    //   // ),
    //   // Row(
    //   //   children: [
    //   //     CustomTextContainer(
    //   //       tabController: tabController,
    //   //       text: 'Art',
    //   //     ),
    //   //     CustomTextContainer(
    //   //       tabController: tabController,
    //   //       text: 'Hiking',
    //   //     ),
    //   //     CustomTextContainer(
    //   //       tabController: tabController,
    //   //       text: 'Drawing',
    //   //     ),
    //   //     CustomTextContainer(
    //   //       tabController: tabController,
    //   //       text: 'Eating',
    //   //     ),
    //         //   ],
    //         //),
    //       ]),
    //       Column(
    //         children: [
    //           StepProgressIndicator(
    //             totalSteps: 4,
    //             currentStep: 2,
    //             selectedColor: Colors.orange,
    //           ),
    //           SizedBox(
    //             height: 10,
    //           ),
    //           CustomButton(
    //             tabController: tabController,
    //             text: 'NEXT STEP',
    //           )
    //         ],
    //       ),
    //     ],
    //   ),
    // );
  }
}
