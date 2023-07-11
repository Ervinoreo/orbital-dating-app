part of 'swipe_bloc.dart';

abstract class SwipeState extends Equatable {
  const SwipeState();

  @override
  List<Object> get props => [];
}

class SwipeLoading extends SwipeState {}

class SwipeLoaded extends SwipeState {
  final List<UserUI> users;
  final UserUI? user;

  const SwipeLoaded({required this.users, this.user});

  @override
  List<Object> get props => [users];
}

class SwipeError extends SwipeState {}

class SwipeMatched extends SwipeState {
  final UserUI user;

  SwipeMatched({required this.user});

  @override
  List<Object> get props => [user];
}
