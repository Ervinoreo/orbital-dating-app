import 'package:dating_app/screens/onboarding/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

import '../../../bloc/onboarding/onboarding_bloc.dart';
import '../../../models/location_model.dart';

class LocationTab extends StatelessWidget {
  final TabController tabController;

  const LocationTab({
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
                Flexible(
                  fit: FlexFit.loose,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomTextHeader(
                        tabController: tabController,
                        text: 'Where Are You?',
                      ),
                      CustomTextField(
                        tabController: tabController,
                        text: 'Enter Your Location',
                        onChanged: (value) {
                          Location location =
                              state.user.location!.copyWith(name: value);
                          context.read<OnboardingBloc>().add(
                                UpdateUserLocation(location: location),
                              );
                        },
                        onFocusChanged: (hasFocus) {
                          if (hasFocus) {
                            return;
                          } else {
                            context.read<OnboardingBloc>().add(
                                  UpdateUserLocation(
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
                                  UpdateUserLocation(controller: controller),
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
                  ),
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
                    ),
                  ],
                ),
              ],
            ),
          );
        } else {
          return Text('Something Went Wrong!');
        }
      },
    );
  }
}
