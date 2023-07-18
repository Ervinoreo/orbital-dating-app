import 'package:dating_app/screens/onboarding/widgets/custom_elevated_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/swipe/swipe_bloc.dart';
import '../chat/chat_screen.dart';
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
    return BlocBuilder<SwipeBloc, SwipeState>(
      builder: (context, state) {
        if (state is SwipeLoading) {
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
              body: Center(
                child: CircularProgressIndicator(),
              ));
        } else if (state is SwipeLoaded) {
          return SwipeLoadedHomeScreen(state: state);
        }
        if (state is SwipeMatched) {
          return Scaffold(body: SwipeMatchedHomeScreen(state: state));
        }
        if (state is SwipeError) {
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
              body: Center(
                child: Text(
                  'There aren\'t any more users.',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ));
        } else {
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
              body: Text('Something went wrong!'));
        }
      },
    );
  }
}

class SwipeMatchedHomeScreen extends StatelessWidget {
  const SwipeMatchedHomeScreen({
    Key? key,
    required this.state,
  }) : super(key: key);

  final SwipeMatched state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Congrats, it is a match!',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            'You and ${state.user.name} have linked each other!',
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.normal),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipOval(
                child: Container(
                  padding: const EdgeInsets.all(5.0),
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [Colors.orange[900]!, Colors.orange[300]!])),
                  child: CircleAvatar(
                    radius: 45,
                    backgroundImage:
                        NetworkImage(state.currentUser!.imageUrls[0]),
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              ClipOval(
                child: Container(
                  padding: const EdgeInsets.all(5.0),
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [Colors.orange[900]!, Colors.orange[300]!])),
                  child: CircleAvatar(
                    radius: 45,
                    backgroundImage: NetworkImage(state.user.imageUrls[0]),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          // CustomElevatedButton(
          //   text: 'Send A Message',
          //   beginColor: Colors.white,
          //   endColor: Colors.white,
          //   textColor: Colors.black,
          //   onPressed: () {
          //     Navigator.pushNamed(
          //       context,
          //       ChatScreen.routeName,
          //       arguments:
          //     );
          //   },
          // ),
          // const SizedBox(
          //   height: 10,
          // ),
          CustomElevatedButton(
            text: 'Back To Swiping',
            beginColor: Colors.white,
            endColor: Colors.white,
            textColor: Colors.black,
            onPressed: () {
              context
                  .read<SwipeBloc>()
                  .add(LoadUsersEvent(user: state.currentUser!));
            },
          ),
        ],
      ),
    ));
  }
}

class SwipeLoadedHomeScreen extends StatelessWidget {
  const SwipeLoadedHomeScreen({Key? key, required this.state})
      : super(key: key);

  final SwipeLoaded state;

  @override
  Widget build(BuildContext context) {
    var userCount = state.users.length;

    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.orange[900],
          title: Text('WassupNus'),
          actions: [
            IconButton(
                onPressed: () {
                  FirebaseAuth.instance.signOut();
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
      body: Column(
        children: [
          InkWell(
            onDoubleTap: () {
              Navigator.pushNamed(context, '/user', arguments: state.users[0]);
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
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 60),
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
      ),
    );
  }
}
