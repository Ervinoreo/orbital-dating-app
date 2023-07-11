import 'package:bloc/bloc.dart';
import 'package:dating_app/repositories/database/database_repository.dart';
import 'package:dating_app/repositories/location/location_repository.dart';
import 'package:dating_app/repositories/storage/storage_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';

import '../../models/models.dart';

part 'onboarding_event.dart';
part 'onboarding_state.dart';

class OnboardingBloc extends Bloc<OnboardingEvent, OnboardingState> {
  final DatabaseRepository _databaseRepository;
  final StorageRepository _storageRepository;
  final LocationRepository _locationRepository;

  OnboardingBloc({
    required DatabaseRepository databaseRepository,
    required StorageRepository storageRepository,
    required LocationRepository locationRepository,
  })  : _databaseRepository = databaseRepository,
        _storageRepository = storageRepository,
        _locationRepository = locationRepository,
        super(OnboardingLoading()) {
    on<StartOnboarding>(_onStartOnboarding);
    on<UpdateUser>(_onUpdateUser);
    on<UpdateUserImages>(_onUpdateUserImages);
    on<UpdateUserLocation>
  }

  // void _onStartOnboarding(
  //     StartOnboarding event, Emitter<OnboardingState> emit) async {
  //   String documentId = await _databaseRepository.createUser(event.user);
  //   emit(OnboardingLoaded(user: event.user.copyWith(id: documentId)));
  // }

  Future<String> inputData() async {
    final User user = await FirebaseAuth.instance.currentUser!;
    final String uid = user.uid.toString();
    return uid;
  }

  void _onStartOnboarding(
      StartOnboarding event, Emitter<OnboardingState> emit) async {
    UserUI user = UserUI(
        id: await inputData(),
        name: '',
        age: 0,
        imageUrls: [],
        bio: '',
        jobTitle: '',
        interests: [],
        gender: '',
        location: Location.initialLocation,
        matches: [],
        swipeLeft: [],
        swipeRight: []);
    await _databaseRepository.createUser(user);
    emit(OnboardingLoaded(user: user));
  }

  void _onUpdateUser(UpdateUser event, Emitter<OnboardingState> emit) {
    if (state is OnboardingLoaded) {
      _databaseRepository.updateUser(event.user);
      emit(OnboardingLoaded(user: event.user));
    }
  }

  Future<void> _onUpdateUserImages(
      UpdateUserImages event, Emitter<OnboardingState> emit) async {
    if (state is OnboardingLoaded) {
      UserUI user = (state as OnboardingLoaded).user;

      await _storageRepository.uploadImage(user, event.image);

      _databaseRepository.getUser(user.id!).listen((user) {
        add(UpdateUser(user: user));
      });
    }
  }

  void _onUpdateUserLocation(
    UpdateUserLocation event,
    Emitter<OnboardingState> emit,
  ) async {
    final state = this.state as OnboardingLoaded;

    if (event.isUpdateComplete && event.location != null) {
      print('Getting the location with the Places API');

      final Location location 
          = await _locationRepository.getLocation(event.location!.name);

      state.controller!.animateCamera(CameraUpdate.newLatLng(
        LatLng(
          
            location.lat,
            location.lon,
        ),
      ),
    );

    _databaseRepository.getUser(state.user.id!).listen((user) {
      add(UpdateUser(user: state.user.copyWith(location : location)));
    });
    }

    else {
      emit(OnboardingLoaded(user: state.user.copyWith(location: event.location),
      controller: event.controller ?? state.controller,
      ));
    }
  }
}
