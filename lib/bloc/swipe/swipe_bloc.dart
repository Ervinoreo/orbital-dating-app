// import 'dart:async';

// import 'package:bloc/bloc.dart';
// import 'package:equatable/equatable.dart';
// import '../../models/models.dart';

// part 'swipe_event.dart';
// part 'swipe_state.dart';

// class SwipeBloc extends Bloc<SwipeEvent, SwipeState> {
//   SwipeBloc() : super(SwipeLoading());

//   Stream<SwipeState> mapEventToState(
//     SwipeEvent event,
//   ) async* {
//     if (event is LoadUsersEvent) {
//       yield* _mapLoadUsersToState(event);
//     }
//     if (event is SwipeLeftEvent) {
//       yield* _mapSwipeLeftToState(event, state);
//     }
//     if (event is SwipeRightEvent) {
//       yield* _mapSwipeRightToState(event, state);
//     }
//   }

//   Stream<SwipeState> _mapLoadUsersToState(LoadUsersEvent event) async* {
//     yield SwipeLoaded(users: event.users);
//   }

//   Stream<SwipeState> _mapSwipeLeftToState(
//       SwipeLeftEvent event, SwipeState state) async* {
//     if (state is SwipeLoaded) {
//       try {
//         yield SwipeLoaded(users: List.from(state.users)..remove(event.user));
//       } catch (_) {}
//     }
//   }

//   Stream<SwipeState> _mapSwipeRightToState(
//       SwipeRightEvent event, SwipeState state) async* {
//     if (state is SwipeLoaded) {
//       try {
//         yield SwipeLoaded(users: List.from(state.users)..remove(event.user));
//       } catch (_) {}
//     }
//   }
// }

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../models/models.dart';

part 'swipe_event.dart';
part 'swipe_state.dart';

class SwipeBloc extends Bloc<SwipeEvent, SwipeState> {
  SwipeBloc() : super(SwipeLoading()) {
    on<LoadUsersEvent>(_onLoadUsers);
    on<SwipeLeftEvent>(_onSwipeLeft);
    on<SwipeRightEvent>(_onSwipeRight);
  }

  void _onLoadUsers(
    LoadUsersEvent event,
    Emitter<SwipeState> emit,
  ) {
    if (event.users != null) {
      emit(SwipeLoaded(users: event.users));
    } else {
      emit(SwipeError());
    }
  }

  void _onSwipeLeft(
    SwipeLeftEvent event,
    Emitter<SwipeState> emit,
  ) {
    if (state is SwipeLoaded) {
      final state = this.state as SwipeLoaded;

      List<UserUI> users = List.from(state.users)..remove(event.user);

      if (users.isNotEmpty) {
        emit(SwipeLoaded(users: users));
      } else {
        emit(SwipeError());
      }
    }
  }

  void _onSwipeRight(
    SwipeRightEvent event,
    Emitter<SwipeState> emit,
  ) {
    if (state is SwipeLoaded) {
      final state = this.state as SwipeLoaded;
      List<UserUI> users = List.from(state.users)..remove(event.user);

      if (users.isNotEmpty) {
        emit(SwipeLoaded(users: users));
      } else {
        emit(SwipeError());
      }
    }
  }
}
