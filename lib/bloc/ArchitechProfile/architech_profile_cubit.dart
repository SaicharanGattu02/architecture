import 'package:flutter_bloc/flutter_bloc.dart';

import 'architech_profile_repository.dart';
import 'architech_profile_state.dart';

class ArchitechProfileCubit extends Cubit<ArchitechProfileState> {
  final ArchitechProfileRepository architechProfileRepository;

  ArchitechProfileCubit(this.architechProfileRepository)
    : super(ArchitechProfileIntailly());

  Future<void> getArchitechProfile() async {
    emit(ArchitechProfileLoading());
    try {
      final res = await architechProfileRepository.getArchitechProfile();
      if (res != null) {
        emit(ArchitechProfileLoaded(architechProfileModel: res));
      } else {
        emit(ArchitechProfileError(message: "No data available"));
      }
    } catch (e) {
      emit(ArchitechProfileError(message: "An error occurred: $e"));
    }
  }
}
