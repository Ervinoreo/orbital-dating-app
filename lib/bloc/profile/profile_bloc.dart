import 'package:bloc/bloc.dart';
import 'package:dating_app/repositories/database/database_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../models/models.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final DatabaseRepository _databaseRepository;

  ProfileBloc({required DatabaseRepository databaseRepository})
      : _databaseRepository = databaseRepository,
        super(ProfileLoading()) {
    on<LoadProfile>(_onLoadProfile);
    on<UpdateProfile>(_onUpdateProfile);

    if (FirebaseAuth.instance.currentUser != null) {
      add(LoadProfile(userId: FirebaseAuth.instance.currentUser!.uid));
    }
  }

  void _onLoadProfile(LoadProfile event, Emitter<ProfileState> emit) {
    _databaseRepository.getUser(event.userId).listen((user) {
      add((UpdateProfile(user: user)));
    });
  }

  void _onUpdateProfile(UpdateProfile event, Emitter<ProfileState> emit) {
    print(event.user);
    emit(ProfileLoaded(user: event.user));
  }
}
