import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dating_app/repositories/database/database_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../models/models.dart';

part 'swipe_event.dart';
part 'swipe_state.dart';

class SwipeBloc extends Bloc<SwipeEvent, SwipeState> {
  final DatabaseRepository _databaseRepository;
  StreamSubscription<User?>? _userSubscription;

  SwipeBloc({
    required DatabaseRepository databaseRepository,
  })  : _databaseRepository = databaseRepository,
        super(SwipeLoading()) {
    on<LoadUsersEvent>(_onLoadUsers);
    on<UpdateHomeEvent>(_onUpdateHome);
    on<SwipeLeftEvent>(_onSwipeLeft);
    on<SwipeRightEvent>(_onSwipeRight);

    _userSubscription = FirebaseAuth.instance.authStateChanges().listen((user) {
      if (user != null) {
        _databaseRepository.getUser(user.uid).listen((inuser) {
          add(LoadUsersEvent(user: inuser));
        });
      }
    });
  }

  void _onLoadUsers(
    LoadUsersEvent event,
    Emitter<SwipeState> emit,
  ) {
    _databaseRepository.getUsers(event.user).listen((users) {
      print('Loading users: $users');
      add(UpdateHomeEvent(users: users));
    });
  }

  void _onUpdateHome(UpdateHomeEvent event, Emitter<SwipeState> emit) {
    if (event.users!.isNotEmpty) {
      emit(SwipeLoaded(users: event.users!));
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

      _databaseRepository.updateUserSwipe(
          FirebaseAuth.instance.currentUser!.uid, event.user.id!, false);

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
  ) async {
    if (state is SwipeLoaded) {
      final state = this.state as SwipeLoaded;
      String userId = FirebaseAuth.instance.currentUser!.uid;
      List<UserUI> users = List.from(state.users)..remove(event.user);

      await _databaseRepository.updateUserSwipe(userId, event.user.id!, true);

      if (event.user.swipeRight!.contains(userId)) {
        await _databaseRepository.updateUserMatch(userId, event.user.id!);
        emit(SwipeLoaded(users: users));
      } else if (users.isNotEmpty) {
        emit(SwipeLoaded(users: users));
      } else {
        emit(SwipeError());
      }
    }
  }

  @override
  Future<void> close() {
    _userSubscription?.cancel();
    return super.close();
  }
}
