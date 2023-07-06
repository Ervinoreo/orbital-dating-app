import 'package:bloc/bloc.dart';
import 'package:dating_app/repositories/database/database_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../models/models.dart';

part 'swipe_event.dart';
part 'swipe_state.dart';

class SwipeBloc extends Bloc<SwipeEvent, SwipeState> {
  final DatabaseRepository _databaseRepository;

  SwipeBloc({
    required DatabaseRepository databaseRepository,
  })  : _databaseRepository = databaseRepository,
        super(SwipeLoading()) {
    on<LoadUsersEvent>(_onLoadUsers);
    on<UpdateHomeEvent>(_onUpdateHome);
    on<SwipeLeftEvent>(_onSwipeLeft);
    on<SwipeRightEvent>(_onSwipeRight);

    if (FirebaseAuth.instance.currentUser != null) {
      add(LoadUsersEvent(userId: FirebaseAuth.instance.currentUser!.uid));
    }
  }

  void _onLoadUsers(
    LoadUsersEvent event,
    Emitter<SwipeState> emit,
  ) {
    _databaseRepository.getUsers(event.userId, 'Male').listen((users) {
      print('$users');
      add(UpdateHomeEvent(users: users));
    });
  }

  void _onUpdateHome(UpdateHomeEvent event, Emitter<SwipeState> emit) {
    if (event.users == null) {
      emit(SwipeError());
    } else {
      emit(SwipeLoaded(users: event.users!));
      print('${event.users}');
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
