import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'architech_profile_details_repository.dart';
import 'architech_profile_details_state.dart';

class ArchitechProfileDetailsCubit extends Cubit<ArchitechProfileDetailsState> {
  final ArchitechProfileDetailsRepository architechProfileRepository;

  ArchitechProfileDetailsCubit(this.architechProfileRepository)
    : super(ArchitechProfileDetailsIntailly());

  Future<void> getArchitechProfileDetails(int id) async {
    emit(ArchitechProfileDetailsLoading());
    try {
      final res = await architechProfileRepository.getArchitechProfileDetails(id);
      if (res != null) {
        emit(ArchitechProfileDetailsLoaded(architechProfileModel: res));
      } else {
        emit(ArchitechProfileDetailsError(message: "No data available"));
      }
    } catch (e) {
      emit(ArchitechProfileDetailsError(message: "An error occurred: $e"));
    }
  }
  Future<void> getUserArchitechProfileDetails(int id) async {
    emit(ArchitechProfileDetailsLoading());
    try {
      final res = await architechProfileRepository.getUserArchitechProfileDetails(id);
      debugPrint("Architechurl:${res}");
      if (res != null) {
        emit(ArchitechProfileDetailsLoaded(architechProfileModel: res));
      } else {
        emit(ArchitechProfileDetailsError(message: "No data available"));
      }
    } catch (e) {
      emit(ArchitechProfileDetailsError(message: "An error occurred: $e"));
    }
  }
}
