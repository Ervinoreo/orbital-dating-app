import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/swipe/swipe_bloc.dart';
import '../widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = '/';

  static Route route() {
    return MaterialPageRoute(
      builder: (_) => HomeScreen(),
      settings: RouteSettings(name: routeName),
    );
  }

  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.orange[900],
          title: Text('WassupNus'),
          actions: [
            IconButton(
                onPressed: () {
                  signUserOut();
                },
                icon: Icon(Icons.logout)),
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
      body: BlocBuilder<SwipeBloc, SwipeState>(builder: (context, state) {
        if (state is SwipeLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is SwipeLoaded) {
          var userCount = state.users.length;
          return Column(
            children: [
              InkWell(
                onDoubleTap: () {
                  Navigator.pushNamed(context, '/user',
                      arguments: state.users[0]);
                },
                child: Draggable(
                  child: UserCard(user: state.users[0]),
                  feedback: UserCard(
                    user: state.users[0],
                  ),
                  childWhenDragging: (userCount > 1)
                      ? UserCard(user: state.users[1])
                      : Container(),
                  onDragEnd: (drag) {
                    if (drag.velocity.pixelsPerSecond.dx < 0) {
                      context.read<SwipeBloc>()
                        ..add(SwipeLeftEvent(user: state.users[0]));
                      print('swipe left');
                    } else {
                      context.read<SwipeBloc>()
                        ..add(SwipeRightEvent(user: state.users[0]));
                      print('swipe right');
                    }
                  },
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 60),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        context.read<SwipeBloc>()
                          ..add(SwipeLeftEvent(user: state.users[0]));
                      },
                      child: ChoiceButton(
                        width: 60,
                        height: 60,
                        size: 25,
                        color: Color.fromRGBO(235, 106, 19, 1),
                        icon: Icons.clear_rounded,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        context.read<SwipeBloc>()
                          ..add(SwipeRightEvent(user: state.users[0]));
                      },
                      child: ChoiceButton(
                        width: 80,
                        height: 80,
                        size: 30,
                        color: Color.fromRGBO(235, 106, 19, 1),
                        icon: Icons.favorite,
                      ),
                    ),
                    ChoiceButton(
                      width: 60,
                      height: 60,
                      size: 25,
                      color: Color.fromRGBO(235, 106, 19, 1),
                      icon: Icons.watch_later,
                    ),
                  ],
                ),
              ),
            ],
          );
        }
        if (state is SwipeError) {
          return Center(
            child: Text(
              'There aren\'t any more users.',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          );
        } else {
          return Text('Something went wrong!');
        }
      }),
    );
  }
}
