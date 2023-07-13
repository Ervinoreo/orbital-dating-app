import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/profile/profile_bloc.dart';

class SettingsScreen extends StatelessWidget {
  static const String routeName = '/settings';

  static Route route() {
    return MaterialPageRoute(
      builder: (context) => SettingsScreen(),
      settings: RouteSettings(name: routeName),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.orange[900],
          title: Text('Settings'),
          actions: [
            IconButton(
                icon: Icon(Icons.message),
                onPressed: () {
                  Navigator.pushNamed(context, '/matches');
                }),
            IconButton(
                icon: Icon(Icons.person),
                onPressed: () {
                  Navigator.pushNamed(context, '/profile');
                }),
          ]),
      body: SingleChildScrollView(
        child: BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, state) {
            if (state is ProfileLoading) {
              return Center(child: CircularProgressIndicator());
            }
            if (state is ProfileLoaded) {
              return Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      height: 50,
                      padding: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromARGB(255, 184, 165, 165),
                            spreadRadius: 2,
                            blurRadius: 2,
                            offset: Offset(2, 2),
                          ),
                        ],
                        gradient: LinearGradient(
                          colors: [
                            Color.fromARGB(255, 222, 86, 2),
                            Theme.of(context).secondaryHeaderColor,
                          ],
                        ),
                      ),
                      child: Center(
                        child: Text(
                          'Set Up your Preferences',
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    _GenderPreference(),
                    _AgeRangePreference(),
                    _DistancePreference(),
                  ],
                ),
              );
            } else {
              return Text('Something went wrong.');
            }
          },
        ),
      ),
    );
  }
}

class _DistancePreference extends StatelessWidget {
  const _DistancePreference({
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
              'Maximum Distance',
              style: TextStyle(fontSize: 30),
            ),
            Row(
              children: [
                Expanded(
                  child: Slider(
                    value: state.user.distancePreference!.toDouble(),
                    min: 0,
                    max: 5000,
                    activeColor: Theme.of(context).primaryColor,
                    inactiveColor: Theme.of(context).primaryColor,
                    onChanged: (value) {
                      context.read<ProfileBloc>().add(
                            UpdateUserProfile(
                              user: state.user.copyWith(
                                distancePreference: value.toInt(),
                              ),
                            ),
                          );
                    },
                    onChangeEnd: (double newValue) {
                      print('Ended change on $newValue');
                      context.read<ProfileBloc>().add(
                            SaveProfile(
                              user: state.user.copyWith(
                                distancePreference: newValue.toInt(),
                              ),
                            ),
                          );
                    },
                  ),
                ),
                SizedBox(
                  width: 50,
                  child: Text(
                    '${state.user.distancePreference!} km',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
          ],
        );
      },
    );
  }
}

class _AgeRangePreference extends StatelessWidget {
  const _AgeRangePreference({
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
              'Age Range',
              style: TextStyle(fontSize: 30),
            ),
            Row(
              children: [
                Expanded(
                  child: RangeSlider(
                    values: RangeValues(
                      state.user.ageRangePreference![0].toDouble(),
                      state.user.ageRangePreference![1].toDouble(),
                    ),
                    min: 5,
                    max: 100,
                    activeColor: Theme.of(context).primaryColor,
                    inactiveColor: Theme.of(context).primaryColor,
                    onChanged: (rangeValues) {
                      context.read<ProfileBloc>().add(
                            UpdateUserProfile(
                              user: state.user.copyWith(
                                ageRangePreference: [
                                  rangeValues.start.toInt(),
                                  rangeValues.end.toInt(),
                                ],
                              ),
                            ),
                          );
                    },
                    onChangeEnd: (RangeValues newRangeValues) {
                      print('Ended change on $newRangeValues');
                      context.read<ProfileBloc>().add(
                            SaveProfile(
                              user: state.user.copyWith(
                                ageRangePreference: [
                                  newRangeValues.start.toInt(),
                                  newRangeValues.end.toInt(),
                                ],
                              ),
                            ),
                          );
                    },
                  ),
                ),
                SizedBox(
                  width: 50,
                  child: Text(
                    '${state.user.ageRangePreference![0]} - ${state.user.ageRangePreference![1]}',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
          ],
        );
      },
    );
  }
}

class _GenderPreference extends StatelessWidget {
  const _GenderPreference({
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
              'Show me: ',
              style: TextStyle(fontSize: 30),
            ),
            Row(
              children: [
                Checkbox(
                  value: state.user.genderPreference!.contains('Male'),
                  onChanged: (value) {
                    if (state.user.genderPreference!.contains('Male')) {
                      context.read<ProfileBloc>().add(
                            UpdateUserProfile(
                              user: state.user.copyWith(
                                genderPreference:
                                    List.from(state.user.genderPreference!)
                                      ..remove('Male'),
                              ),
                            ),
                          );
                      context.read<ProfileBloc>().add(
                            SaveProfile(user: state.user),
                          );
                    } else {
                      context.read<ProfileBloc>().add(
                            UpdateUserProfile(
                              user: state.user.copyWith(
                                genderPreference:
                                    List.from(state.user.genderPreference!)
                                      ..add('Male'),
                              ),
                            ),
                          );
                      context.read<ProfileBloc>().add(
                            SaveProfile(user: state.user),
                          );
                    }
                  },
                  visualDensity: VisualDensity.compact,
                ),
                Text(
                  'Man',
                  style: TextStyle(fontSize: 15),
                ),
              ],
            ),
            Row(
              children: [
                Checkbox(
                  value: state.user.genderPreference!.contains('Female'),
                  onChanged: (value) {
                    if (state.user.genderPreference!.contains('Female')) {
                      context.read<ProfileBloc>().add(
                            UpdateUserProfile(
                              user: state.user.copyWith(
                                genderPreference:
                                    List.from(state.user.genderPreference!)
                                      ..remove('Female'),
                              ),
                            ),
                          );
                      context.read<ProfileBloc>().add(
                            SaveProfile(user: state.user),
                          );
                    } else {
                      context.read<ProfileBloc>().add(
                            UpdateUserProfile(
                              user: state.user.copyWith(
                                genderPreference:
                                    List.from(state.user.genderPreference!)
                                      ..add('Female'),
                              ),
                            ),
                          );
                      context.read<ProfileBloc>().add(
                            SaveProfile(user: state.user),
                          );
                    }
                  },
                  visualDensity: VisualDensity.compact,
                ),
                Text(
                  'Woman',
                  style: TextStyle(fontSize: 15),
                ),
              ],
            ),
            SizedBox(height: 10),
          ],
        );
      },
    );
  }
}
