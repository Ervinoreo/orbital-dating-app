import 'package:dating_app/screens/onboarding/widgets/widgets.dart';
import 'package:dating_app/screens/widgets/user_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../bloc/profile/profile_bloc.dart';
import '../../models/location_model.dart';
import '../onboarding/widgets/custom_elevated_button.dart';

class ProfileScreen extends StatelessWidget {
  static const String routeName = '/profile';

  static Route route() {
    return MaterialPageRoute(
      builder: (context) => ProfileScreen(),
      settings: RouteSettings(name: routeName),
    );
  }

  @override
  Widget build(BuildContext context) {
    //final UserUI user = UserUI.users[0];
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.orange[900],
            title: Text('Profile'),
            actions: [
              IconButton(
                  icon: Icon(Icons.message),
                  onPressed: () {
                    Navigator.pushNamed(context, '/matches');
                  }),
              IconButton(
                  icon: Icon(Icons.settings),
                  onPressed: () {
                    Navigator.pushNamed(context, '/settings');
                  }),
            ]),
        body: SingleChildScrollView(
          child: BlocBuilder<ProfileBloc, ProfileState>(
            builder: (context, state) {
              if (state is ProfileLoading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state is ProfileLoaded) {
                return Column(
                  children: [
                    SizedBox(height: 5),
                    UserImage.medium(
                      url: state.user.imageUrls[0],
                      child: Container(
                          height: MediaQuery.of(context).size.height / 4,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            gradient: LinearGradient(
                              colors: [
                                Colors.orange[900]!.withOpacity(0.05),
                                Colors.orange[900]!.withOpacity(0.2),
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                          ),
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 40.0),
                              child: Text(state.user.name,
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 50,
                                    fontWeight: FontWeight.bold,
                                  )),
                            ),
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomElevatedButton(
                            text: 'View',
                            beginColor: state.isEditingOn
                                ? Colors.white
                                : Colors.orange,
                            endColor: state.isEditingOn
                                ? Colors.orange
                                : Colors.white,
                            textColor:
                                state.isEditingOn ? Colors.black : Colors.white,
                            width: MediaQuery.of(context).size.width * 0.45,
                            onPressed: () {
                              context.read<ProfileBloc>().add(
                                    SaveProfile(user: state.user),
                                  );
                            },
                          ),
                          SizedBox(width: 10),
                          CustomElevatedButton(
                            text: 'Edit',
                            beginColor: state.isEditingOn
                                ? Colors.white
                                : Colors.orange,
                            endColor: state.isEditingOn
                                ? Colors.orange
                                : Colors.white,
                            textColor:
                                state.isEditingOn ? Colors.black : Colors.white,
                            width: MediaQuery.of(context).size.width * 0.45,
                            onPressed: () {
                              context.read<ProfileBloc>().add(
                                    EditProfile(isEditingOn: true),
                                  );
                            },
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _TextField(
                            title: 'Biography',
                            value: state.user.bio,
                            onChanged: (value) {
                              context.read<ProfileBloc>().add(
                                    UpdateUserProfile(
                                      user: state.user.copyWith(bio: value),
                                    ),
                                  );
                            },
                          ),
                          _TextField(
                            title: 'Age',
                            value: '${state.user.age}',
                            onChanged: (value) {
                              if (value == null) {
                                return;
                              }
                              if (value == '') {
                                return;
                              }
                              context.read<ProfileBloc>().add(
                                    UpdateUserProfile(
                                      user: state.user.copyWith(
                                        age: int.parse(value),
                                      ),
                                    ),
                                  );
                            },
                          ),
                          _TextField(
                            title: 'Job Title',
                            value: state.user.jobTitle,
                            onChanged: (value) {
                              context.read<ProfileBloc>().add(
                                    UpdateUserProfile(
                                      user:
                                          state.user.copyWith(jobTitle: value),
                                    ),
                                  );
                            },
                          ),
                          _Pictures(),
                          _Interests(),
                          _Location(
                            title: 'Location',
                            value: state.user.location!.name,
                          ),
                        ],
                      ),
                    )
                  ],

                  //   Padding(
                  //     padding: const EdgeInsets.all(20.0),
                  //     child: Column(
                  //       crossAxisAlignment: CrossAxisAlignment.start,
                  //       children: [
                  //         TitleWithIcon(title: 'Biography', icon: Icons.edit),
                  //         Text(
                  //           state.user.bio,
                  //         ),
                  //         TitleWithIcon(title: 'Pictures', icon: Icons.edit),
                  //         SizedBox(
                  //           height: 125,
                  //           child: ListView.builder(
                  //               shrinkWrap: true,
                  //               scrollDirection: Axis.horizontal,
                  //               itemCount: state.user.imageUrls.length,
                  //               itemBuilder: (context, index) {
                  //                 return Padding(
                  //                     padding: const EdgeInsets.only(right: 5.0),
                  //                     child: UserImage.small(
                  //                       width: 100,
                  //                       url: state.user.imageUrls[index],
                  //                       border: Border.all(color: Colors.black),
                  //                     ));
                  //               }),
                  //         ),
                  //         TitleWithIcon(title: 'Location', icon: Icons.edit),
                  //         Text(state.user.location!.name),
                  //         TitleWithIcon(title: 'Interest', icon: Icons.edit),
                  //         Row(
                  //           children: [
                  //             CustomTextContainer(text: state.user.interests[0]),
                  //           ],
                  //         )
                  //       ],
                  //     ),
                  //   ),
                );
              } else {
                return Text('Something went wrong!');
              }
            },
          ),
        ));
  }
}

class _TextField extends StatelessWidget {
  const _TextField({
    Key? key,
    required this.title,
    required this.value,
    required this.onChanged,
  }) : super(key: key);

  final String title;
  final String value;
  final Function(String?) onChanged;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        state as ProfileLoaded;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
            ),
            SizedBox(height: 10),
            state.isEditingOn
                ? CustomTextField(
                    initialValue: value,
                    onChanged: onChanged,
                  )
                : Text(
                    value,
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(height: 1.5),
                  ),
            SizedBox(height: 10),
          ],
        );
      },
    );
  }
}

class _Pictures extends StatelessWidget {
  const _Pictures({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        state as ProfileLoaded;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Pictures',
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              height: state.user.imageUrls.length > 0 ? 125 : 0,
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: state.user.imageUrls.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 5.0),
                    child: UserImage.small(
                      width: 100,
                      url: state.user.imageUrls[index],
                      border: Border.all(
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}

class _Interests extends StatelessWidget {
  const _Interests({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        state as ProfileLoaded;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Interest',
            ),
            Row(
              children: [
                CustomTextContainer(text: 'MUSIC'),
                CustomTextContainer(text: 'ECONOMICS'),
                CustomTextContainer(text: 'FOOTBALL'),
              ],
            ),
            SizedBox(height: 10),
          ],
        );
      },
    );
  }
}

class _Location extends StatelessWidget {
  const _Location({
    Key? key,
    required this.title,
    required this.value,
  }) : super(key: key);

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        state as ProfileLoaded;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Location',
            ),
            SizedBox(height: 10),
            state.isEditingOn
                ? CustomTextField(
                    initialValue: value,
                    onChanged: (value) {
                      Location location =
                          state.user.location!.copyWith(name: value);
                      context
                          .read<ProfileBloc>()
                          .add(UpdateUserLocation(location: location));
                    },
                    onFocusChanged: (hasFocus) {
                      if (hasFocus) {
                        return;
                      } else {
                        context.read<ProfileBloc>().add(
                              UpdateUserLocation(
                                isUpdateComplete: true,
                                location: state.user.location,
                              ),
                            );
                      }
                    },
                  )
                : Text(
                    value,
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(height: 1.5),
                  ),
            SizedBox(height: 20),
            SizedBox(
              height: 300,
              child: GoogleMap(
                myLocationEnabled: true,
                myLocationButtonEnabled: false,
                onMapCreated: (GoogleMapController controller) {
                  context.read<ProfileBloc>().add(
                        UpdateUserLocation(controller: controller),
                      );
                },
                initialCameraPosition: CameraPosition(
                  target: LatLng(
                    state.user.location!.lat.toDouble(),
                    state.user.location!.lon.toDouble(),
                  ),
                  zoom: 10,
                ),
              ),
            ),
            SizedBox(height: 10),
          ],
        );
      },
    );
  }
}
