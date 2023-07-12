part of 'onboarding_bloc.dart';

abstract class OnboardingEvent extends Equatable {
  const OnboardingEvent();

  @override
  List<Object?> get props => [];
}

// class StartOnboarding extends OnboardingEvent {
//   final UserUI user;

//   StartOnboarding(
//       {this.user = const UserUI(
//           id: '',
//           name: '',
//           age: 0,
//           imageUrls: [],
//           bio: '',
//           jobTitle: '',
//           interests: [],
//           gender: '',
//           location: '')});

//   @override
//   List<Object?> get props => [user];
// }

class StartOnboarding extends OnboardingEvent {}

class UpdateUser extends OnboardingEvent {
  final UserUI user;

  UpdateUser({required this.user});

  @override
  List<Object?> get props => [user];
}

class UpdateUserImages extends OnboardingEvent {
  final UserUI? user;
  final XFile image;

  UpdateUserImages({this.user, required this.image});

  @override
  List<Object?> get props => [user, image];
}

class SetUserLocation extends OnboardingEvent {
  final Location? location;
  final GoogleMapController? controller;
  final bool isUpdateComplete;

  const SetUserLocation({
    this.location,
    this.controller,
    this.isUpdateComplete = false,
  });

  @override
  List<Object?> get props => [location, controller, isUpdateComplete];
}
