import 'package:equatable/equatable.dart';

class UserUI extends Equatable {
  final int id;
  final String name;
  final int age;
  final List<String> imageUrls;
  final List<String> interests;
  final String bio;
  final String jobTitle;

  const UserUI({
    required this.id,
    required this.name,
    required this.age,
    required this.imageUrls,
    required this.interests,
    required this.bio,
    required this.jobTitle,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        age,
        imageUrls,
        bio,
        jobTitle,
      ];

  static List<UserUI> users = [
    UserUI(
      id: 1,
      name: 'Ruobei',
      age: 20,
      imageUrls: [
        'https://images.unsplash.com/flagged/photo-1595514191830-3e96a518989b?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTF8fHByb2ZpbGUlMjBwaG90b3xlbnwwfHwwfHx8MA%3D%3D&auto=format&fit=crop&w=800&q=60',
        'https://images.unsplash.com/photo-1532202802379-df93d543bac3?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTJ8fHN1cGVyaGVyb3xlbnwwfHwwfHx8MA%3D%3D&auto=format&fit=crop&w=800&q=60',
        'https://images.unsplash.com/photo-1600480505021-e9cfb05527f1?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTZ8fHN1cGVyaGVyb3xlbnwwfHwwfHx8MA%3D%3D&auto=format&fit=crop&w=800&q=60',
        'https://plus.unsplash.com/premium_photo-1663126494738-549d0a6333a4?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTl8fHN1cGVyaGVyb3xlbnwwfHwwfHx8MA%3D%3D&auto=format&fit=crop&w=800&q=60',
        'https://plus.unsplash.com/premium_photo-1682097967456-7f1c2bd9397f?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8N3x8c3VwZXJoZXJvfGVufDB8fDB8fHww&auto=format&fit=crop&w=800&q=60',
      ],
      interests: ['Music', 'Politics', 'Hiking'],
      jobTitle: 'super hero',
      bio:
          'Lets save the world njshqauiSDHCUHUID SIKXUWHSGDUYGAIZUJ DQWHSAUUZIjuguiic djivdijij',
    ),
    UserUI(
      id: 2,
      name: 'XiaoMa',
      age: 20,
      imageUrls: [
        'https://images.unsplash.com/photo-1616790876844-97c0c6057364?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8cG9ydHJhaXQlMjBnaXJsfGVufDB8fDB8fHww&w=1000&q=80',
        'https://images.unsplash.com/photo-1532202802379-df93d543bac3?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTJ8fHN1cGVyaGVyb3xlbnwwfHwwfHx8MA%3D%3D&auto=format&fit=crop&w=800&q=60',
        'https://images.unsplash.com/photo-1600480505021-e9cfb05527f1?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTZ8fHN1cGVyaGVyb3xlbnwwfHwwfHx8MA%3D%3D&auto=format&fit=crop&w=800&q=60',
        'https://plus.unsplash.com/premium_photo-1663126494738-549d0a6333a4?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTl8fHN1cGVyaGVyb3xlbnwwfHwwfHx8MA%3D%3D&auto=format&fit=crop&w=800&q=60',
        'https://plus.unsplash.com/premium_photo-1682097967456-7f1c2bd9397f?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8N3x8c3VwZXJoZXJvfGVufDB8fDB8fHww&auto=format&fit=crop&w=800&q=60',
      ],
      interests: ['Music', 'Politics', 'Hiking'],
      jobTitle: 'super woman',
      bio: 'Lets eat food',
    ),
    UserUI(
      id: 3,
      name: 'Ervin',
      age: 20,
      imageUrls: [
        'https://img.freepik.com/free-photo/portrait-dark-skinned-cheerful-woman-with-curly-hair-touches-chin-gently-laughs-happily-enjoys-day-off-feels-happy-enthusiastic-hears-something-positive-wears-casual-blue-turtleneck_273609-43443.jpg',
        'https://images.unsplash.com/photo-1532202802379-df93d543bac3?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTJ8fHN1cGVyaGVyb3xlbnwwfHwwfHx8MA%3D%3D&auto=format&fit=crop&w=800&q=60',
        'https://images.unsplash.com/photo-1600480505021-e9cfb05527f1?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTZ8fHN1cGVyaGVyb3xlbnwwfHwwfHx8MA%3D%3D&auto=format&fit=crop&w=800&q=60',
        'https://plus.unsplash.com/premium_photo-1663126494738-549d0a6333a4?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTl8fHN1cGVyaGVyb3xlbnwwfHwwfHx8MA%3D%3D&auto=format&fit=crop&w=800&q=60',
        'https://plus.unsplash.com/premium_photo-1682097967456-7f1c2bd9397f?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8N3x8c3VwZXJoZXJvfGVufDB8fDB8fHww&auto=format&fit=crop&w=800&q=60',
      ],
      interests: ['Music', 'Politics', 'Hiking'],
      jobTitle: 'super fat',
      bio: 'Lets cry',
    )
  ];
}
