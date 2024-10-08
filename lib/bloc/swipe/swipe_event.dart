part of 'swipe_bloc.dart';

abstract class SwipeEvent extends Equatable {
  const SwipeEvent();

  @override
  List<Object?> get props => [];
}

class LoadUsersEvent extends SwipeEvent {
  final UserUI user;

  LoadUsersEvent({required this.user});

  @override
  List<Object?> get props => [user];
}

class UpdateHomeEvent extends SwipeEvent {
  final List<UserUI>? users;
  final UserUI? currentUser;

  UpdateHomeEvent({required this.users, this.currentUser});

  @override
  List<Object?> get props => [users];
}

class SwipeLeftEvent extends SwipeEvent {
  final UserUI user;

  SwipeLeftEvent({required this.user});

  @override
  List<Object?> get props => [user];
}

class SwipeRightEvent extends SwipeEvent {
  final UserUI user;

  SwipeRightEvent({required this.user});

  @override
  List<Object?> get props => [user];
}
