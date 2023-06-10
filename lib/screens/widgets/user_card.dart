import 'package:dating_app/models/user_model.dart';
import 'package:flutter/material.dart';
import 'widgets.dart';

class UserCard extends StatelessWidget {
  final UserUI user;

  const UserCard({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
      child: SizedBox(
          height: MediaQuery.of(context).size.height / 1.4,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(user.imageUrls[0]),
                  ),
                  borderRadius: BorderRadius.circular(5.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 4,
                      blurRadius: 4,
                      offset: Offset(3, 3),
                    )
                  ],
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
                    Row(
                      children: [
                        UserImageSmall(imageUrl: user.imageUrls[1]),
                        UserImageSmall(imageUrl: user.imageUrls[2]),
                        UserImageSmall(imageUrl: user.imageUrls[3]),
                        UserImageSmall(imageUrl: user.imageUrls[4]),
                        SizedBox(width: 10),
                        Container(
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
                            ))
                      ],
                    )
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
