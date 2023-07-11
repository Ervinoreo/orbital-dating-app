part of 'onboarding_bloc.dart';

abstract class OnboardingState extends Equatable {
  const OnboardingState();

  @override
  List<Object?> get props => [];
}

class OnboardingLoading extends OnboardingState {}

class OnboardingLoaded extends OnboardingState {
  final UserUI user;
  final GoogleMapController? controller;

  OnboardingLoaded({
    required this.user,
    required this.controller,
  });

  @override
  List<Object?> get props => [
        user,
        controller,
      ];
}
