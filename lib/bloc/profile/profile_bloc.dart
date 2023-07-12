import 'package:bloc/bloc.dart';
import 'package:dating_app/repositories/database/database_repository.dart';
import 'package:dating_app/repositories/location/location_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../models/location_model.dart';
import '../../models/models.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final DatabaseRepository _databaseRepository;
  final LocationRepository _locationRepository;

  ProfileBloc({
    required DatabaseRepository databaseRepository,
    required LocationRepository locationRepository,
  })  : _databaseRepository = databaseRepository,
        _locationRepository = locationRepository,
        super(ProfileLoading()) {
    on<LoadProfile>(_onLoadProfile);
    on<EditProfile>(_onEditProfile);
    on<SaveProfile>(_onSaveProfile);
    on<UpdateUserProfile>(_onUpdateUserProfile);
    on<UpdateUserLocation>(_onUpdateUserLocation);

    if (FirebaseAuth.instance.currentUser != null) {
      add(LoadProfile(userId: FirebaseAuth.instance.currentUser!.uid));
    }
  }

  void _onLoadProfile(
    LoadProfile event,
    Emitter<ProfileState> emit,
  ) async {
    UserUI user = await _databaseRepository.getUser(event.userId).first;
    emit(ProfileLoaded(user: user));
  }

  void _onEditProfile(
    EditProfile event,
    Emitter<ProfileState> emit,
  ) {
    if (state is ProfileLoaded) {
      emit(
        ProfileLoaded(
          user: (state as ProfileLoaded).user,
          isEditingOn: event.isEditingOn,
          controller: (state as ProfileLoaded).controller,
        ),
      );
    }
  }

  void _onSaveProfile(
    SaveProfile event,
    Emitter<ProfileState> emit,
  ) {
    if (state is ProfileLoaded) {
      _databaseRepository.updateUser((state as ProfileLoaded).user);
      emit(
        ProfileLoaded(
          user: (state as ProfileLoaded).user,
          isEditingOn: false,
          controller: (state as ProfileLoaded).controller,
        ),
      );
    }
  }

  void _onUpdateUserProfile(
    UpdateUserProfile event,
    Emitter<ProfileState> emit,
  ) {
    if (state is ProfileLoaded) {
      emit(
        ProfileLoaded(
          user: event.user,
          isEditingOn: (state as ProfileLoaded).isEditingOn,
          controller: (state as ProfileLoaded).controller,
        ),
      );
    }
  }

  void _onUpdateUserLocation(
    UpdateUserLocation event,
    Emitter<ProfileState> emit,
  ) async {
    final state = this.state as ProfileLoaded;

    if (event.isUpdateComplete && event.location != null) {
      print('Getting location with the Places API');
      final Location location =
          await _locationRepository.getLocation(event.location!.name);

      state.controller!.animateCamera(
        CameraUpdate.newLatLng(
          LatLng(
            location.lat.toDouble(),
            location.lon.toDouble(),
          ),
        ),
      );

      add(UpdateUserProfile(user: state.user.copyWith(location: location)));
    } else {
      emit(
        ProfileLoaded(
          user: state.user.copyWith(location: event.location),
          controller: event.controller ?? state.controller,
          isEditingOn: state.isEditingOn,
        ),
      );
    }
  }
}
