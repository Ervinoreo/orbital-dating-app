part of 'swipe_bloc.dart';

abstract class SwipeState extends Equatable {
  const SwipeState();

  @override
  List<Object> get props => [];
}

class SwipeLoading extends SwipeState {}

class SwipeLoaded extends SwipeState {
  final List<UserUI> users;
  final UserUI? currentUser;

  const SwipeLoaded({required this.users, this.currentUser});

  @override
  List<Object> get props => [
        users,
      ];
}

class SwipeError extends SwipeState {}

class SwipeMatched extends SwipeState {
  final UserUI user;
  final UserUI? currentUser;

  SwipeMatched({required this.user, this.currentUser});

  @override
  List<Object> get props => [user];
}
