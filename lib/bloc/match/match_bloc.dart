import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dating_app/repositories/database/database_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../models/models.dart';

part 'match_event.dart';
part 'match_state.dart';

class MatchBloc extends Bloc<MatchEvent, MatchState> {
  final DatabaseRepository _databaseRepository;
  StreamSubscription? _databaseSubscription;
  StreamSubscription<User?>? _userSubscription;

  MatchBloc({required DatabaseRepository databaseRepository})
      : _databaseRepository = databaseRepository,
        super(MatchLoading()) {
    on<LoadMatches>(_onLoadMatches);
    on<UpdateMatches>(_onUpdateMatches);

    _userSubscription = FirebaseAuth.instance.authStateChanges().listen((user) {
      if (user != null) {
        _databaseRepository.getUser(user.uid).listen((inuser) {
          add(LoadMatches(user: inuser));
        });
      }
    });
  }

  void _onLoadMatches(LoadMatches event, Emitter<MatchState> emit) {
    print('hi');
    _databaseSubscription =
        _databaseRepository.getMatches(event.user).listen((matchedUsers) {
      print('Matched Users: $matchedUsers');
      add(UpdateMatches(matchedUsers: matchedUsers));
    });
  }

  void _onUpdateMatches(UpdateMatches event, Emitter<MatchState> emit) {
    if (event.matchedUsers.length == 0) {
      emit(MatchUnavailable());
    } else {
      emit(MatchLoaded(matches: event.matchedUsers));
    }
  }

  @override
  Future<void> close() async {
    _databaseSubscription?.cancel();
    _userSubscription?.cancel();
    super.close();
  }
}
