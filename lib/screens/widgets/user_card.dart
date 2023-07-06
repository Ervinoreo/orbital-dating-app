import 'package:dating_app/models/user_model.dart';
import 'package:dating_app/screens/widgets/user_image.dart';
import 'package:flutter/material.dart';

class UserCard extends StatelessWidget {
  final UserUI user;

  const UserCard({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'user-image',
      child: Padding(
        padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
        child: SizedBox(
            height: MediaQuery.of(context).size.height / 1.4,
            width: MediaQuery.of(context).size.width,
            child: Stack(
              children: [
                UserImage.large(
                  url: user.imageUrls[0],
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                    gradient: LinearGradient(
                      colors: [
                        Color.fromARGB(200, 0, 0, 0),
                        Color.fromARGB(0, 0, 0, 0)
                      ],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 30,
                  left: 20,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${user.name}, ${user.age}',
                          style: TextStyle(
                            color: Colors.orange[900],
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          )),
                      Text('${user.jobTitle}',
                          style: TextStyle(
                            color: Colors.orange[900],
                            fontSize: 20,
                          )),
                      SizedBox(
                        height: 70,
                        child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: user.imageUrls.length + 1,
                            itemBuilder: (builder, index) {
                              return (index < user.imageUrls.length)
                                  ? UserImage.small(
                                      url: user.imageUrls[index],
                                      margin: const EdgeInsets.only(
                                          top: 8, right: 8),
                                    )
                                  : Container(
                                      width: 35,
                                      height: 35,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.white,
                                      ),
                                      child: Icon(
                                        Icons.info_outline,
                                        size: 25,
                                        color: Colors.orange[900],
                                      ));
                            }),
                      )
                    ],
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
