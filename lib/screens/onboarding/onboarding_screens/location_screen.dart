import 'package:dating_app/screens/onboarding/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

import '../../../bloc/onboarding/onboarding_bloc.dart';
import '../../../models/location_model.dart';
import '../onboarding_screen.dart';

class LocationTab extends StatelessWidget {
  final TabController tabController;
  final OnboardingLoaded state;

  const LocationTab(
      {Key? key, required this.tabController, required this.state})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OnboardingScreenLayout(
      children: [
        CustomTextHeader(
          tabController: tabController,
          text: 'Where Are You?',
        ),
        CustomTextField(
          text: 'Enter Your Location',
          onChanged: (value) {
            Location location = state.user.location!.copyWith(name: value);
            context.read<OnboardingBloc>().add(
                  SetUserLocation(location: location),
                );
          },
          onFocusChanged: (hasFocus) {
            if (hasFocus) {
              return;
            } else {
              context.read<OnboardingBloc>().add(
                    SetUserLocation(
                      isUpdateComplete: true,
                      location: state.user.location,
                    ),
                  );
            }
          },
        ),
        SizedBox(height: 10),
        Expanded(
          child: GoogleMap(
            myLocationEnabled: true,
            myLocationButtonEnabled: false,
            onMapCreated: (GoogleMapController controller) {
              context.read<OnboardingBloc>().add(
                    SetUserLocation(controller: controller),
                  );
            },
            initialCameraPosition: CameraPosition(
              zoom: 10,
              target: LatLng(
                state.user.location!.lat.toDouble(),
                state.user.location!.lon.toDouble(),
              ),
            ),
          ),
        ),
        SizedBox(height: 10),
      ],
      currentStep: 4,
      tabController: tabController,
    );
    // return Padding(
    //   padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 50.0),
    //   child: Column(
    //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //     children: [
    //       Flexible(
    //         fit: FlexFit.loose,
    //         child: Column(
    //           crossAxisAlignment: CrossAxisAlignment.start,
    //           children: [

    //           ],
    //         ),
    //       ),
    //       Column(
    //         children: [
    //           StepProgressIndicator(
    //             totalSteps: 4,
    //             currentStep: 4,
    //             selectedColor: Colors.orange,
    //           ),
    //           SizedBox(
    //             height: 10,
    //           ),
    //           CustomButton(
    //             tabController: tabController,
    //             text: 'NEXT STEP',
    //           ),
    //         ],
    //       ),
    //     ],
    //   ),
    // );
  }
}
