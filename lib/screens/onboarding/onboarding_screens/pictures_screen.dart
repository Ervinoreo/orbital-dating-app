import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

import '../../../bloc/onboarding/onboarding_bloc.dart';
import '../onboarding_screen.dart';
import '../widgets/custom_image_container.dart';
import '../widgets/widgets.dart';

class PictureScreen extends StatelessWidget {
  final TabController tabController;
  final OnboardingLoaded state;

  const PictureScreen({
    Key? key,
    required this.tabController,
    required this.state,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var images = state.user.imageUrls;
    var imagesCount = images.length;
    return OnboardingScreenLayout(
      children: [
        CustomTextHeader(
            tabController: tabController, text: 'Add 2 or More Pictures'),
        SizedBox(
          height: 10,
        ),
        SizedBox(
          height: 350,
          child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, childAspectRatio: 0.66),
              itemCount: 6,
              itemBuilder: (BuildContext context, int index) {
                return (imagesCount > index)
                    ? CustomImageContainer(
                        tabController: tabController, imageUrl: images[index])
                    : CustomImageContainer(tabController: tabController);
              }),
        )
      ],
      currentStep: 3,
      tabController: tabController,
    );
    // Padding(
    //   padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 30.0),
    //   child: Column(
    //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //     children: [
    //       Column(
    //         crossAxisAlignment: CrossAxisAlignment.start,
    //         children: [

    //         ],
    //       ),
    //       Column(
    //         children: [
    //           StepProgressIndicator(
    //             totalSteps: 4,
    //             currentStep: 3,
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
