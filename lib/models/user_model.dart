import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

import 'location_model.dart';

class UserUI extends Equatable {
  final String? id;
  final String name;
  final int age;
  final List<dynamic> imageUrls;
  final String bio;
  final String jobTitle;
  final List<dynamic> interests;
  final String gender;
  final Location location;
  final List<String>? swipeLeft;
  final List<String>? swipeRight;
  final List<String>? matches;

  const UserUI({
    required this.id,
    required this.name,
    required this.age,
    required this.imageUrls,
    required this.bio,
    required this.jobTitle,
    required this.interests,
    required this.gender,
    required this.location,
    this.swipeLeft,
    this.swipeRight,
    this.matches,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        age,
        imageUrls,
        bio,
        jobTitle,
        interests,
        gender,
        location,
        swipeLeft,
        swipeRight,
        matches
      ];

  // static UserUI fromSnapshot(DocumentSnapshot snap) {
  //   UserUI user = UserUI(
  //     id: snap.id,
  //     name: snap['name'],
  //     age: snap['age'],
  //     imageUrls: snap['imageUrls'],
  //     bio: snap['bio'],
  //     jobTitle: snap['jobTitle'],
  //     interests: snap['interests'],
  //     gender: snap['gender'],
  //     location: snap['location'],
  //     swipeLeft: (snap['swipeLeft'] as List)
  //         .map((swipeLeft) => swipeLeft as String)
  //         .toList(),
  //     swipeRight: (snap['swipeRight'] as List)
  //         .map((swipeRight) => swipeRight as String)
  //         .toList(),
  //     matches: (snap['matches'] as List)
  //         .map((matches) => matches as String)
  //         .toList(),
  //   );

  //   return user;
  // }
  static UserUI fromSnapshot(DocumentSnapshot snap) {
    UserUI user = UserUI(
      id: snap.id,
      name: snap['name'] ?? '',
      age: snap['age'] ?? 0,
      imageUrls: snap['imageUrls'] != null ? List.from(snap['imageUrls']) : [],
      bio: snap['bio'] ?? '',
      jobTitle: snap['jobTitle'] ?? '',
      interests: snap['interests'] != null ? List.from(snap['interests']) : [],
      gender: snap['gender'] ?? '',
      location: snap['location'] ?? '',
      swipeLeft: snap['swipeLeft'] != null
          ? List<String>.from(snap['swipeLeft'] ?? [])
          : [],
      swipeRight: snap['swipeRight'] != null
          ? List<String>.from(snap['swipeRight'] ?? [])
          : [],
      matches: snap['matches'] != null
          ? List<String>.from(snap['matches'] ?? [])
          : [],
    );

    return user;
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'age': age,
      'gender': gender,
      'imageUrls': imageUrls,
      'interests': interests,
      'bio': bio,
      'jobTitle': jobTitle,
      'location': location!.toMap(),
      'swipeLeft': swipeLeft,
      'swipeRight': swipeRight,
      'matches': matches,
    };
  }

  UserUI copyWith({
    String? id,
    String? name,
    int? age,
    String? gender,
    List<dynamic>? imageUrls,
    List<dynamic>? interests,
    String? bio,
    String? jobTitle,
    Location? location,
    List<String>? swipeLeft,
    List<String>? swipeRight,
    List<String>? matches,
  }) {
    return UserUI(
      id: id ?? this.id,
      name: name ?? this.name,
      age: age ?? this.age,
      imageUrls: imageUrls ?? this.imageUrls,
      bio: bio ?? this.bio,
      jobTitle: jobTitle ?? this.jobTitle,
      interests: interests ?? this.interests,
      gender: gender ?? this.gender,
      location: location ?? this.location,
      swipeLeft: swipeLeft ?? this.swipeLeft,
      swipeRight: swipeRight ?? this.swipeRight,
      matches: matches ?? this.matches,
    );
  }
}
