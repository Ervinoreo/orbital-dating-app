import 'package:dating_app/screens/onboarding/widgets/widgets.dart';
import 'package:dating_app/screens/widgets/user_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/profile/profile_bloc.dart';

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
              IconButton(icon: Icon(Icons.message), onPressed: () {}),
              IconButton(icon: Icon(Icons.person), onPressed: () {}),
            ]),
        body: BlocBuilder<ProfileBloc, ProfileState>(
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
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TitleWithIcon(title: 'Biography', icon: Icons.edit),
                        Text(
                          state.user.bio,
                        ),
                        TitleWithIcon(title: 'Pictures', icon: Icons.edit),
                        SizedBox(
                          height: 125,
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
                                      border: Border.all(color: Colors.black),
                                    ));
                              }),
                        ),
                        TitleWithIcon(title: 'Location', icon: Icons.edit),
                        Text(state.user.location!.name),
                        TitleWithIcon(title: 'Interest', icon: Icons.edit),
                        Row(
                          children: [
                            CustomTextContainer(text: state.user.interests[0]),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              );
            } else {
              return Text('Something went wrong!');
            }
          },
        ));
  }
}

class TitleWithIcon extends StatelessWidget {
  final String title;
  final IconData icon;

  const TitleWithIcon({
    Key? key,
    required this.title,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Text(
        title,
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
      IconButton(
        icon: Icon(icon),
        onPressed: () {},
      ),
    ]);
  }
}
