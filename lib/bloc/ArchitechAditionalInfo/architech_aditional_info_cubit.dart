import 'package:flutter_bloc/flutter_bloc.dart';
import '../login/login_repository.dart';
import 'architech_aditional_info_repository.dart';
import 'architech_aditional_info_state.dart';

class ArchitechAditionalInfoCubit extends Cubit<ArchitechAditionalInfoState> {
  final ArchitechAditionalInfoRepository architechAditionalInfoRepository;

  ArchitechAditionalInfoCubit(this.architechAditionalInfoRepository)
    : super(ArchitechAditionalInfoIntially());

  Future<void> createArchitechAditionalInfo(Map<String, dynamic> data) async {
    emit(ArchitechAditionalInfoLoading());
    try {
      final res = await architechAditionalInfoRepository
          .createArchitechAditionalInfo(data);
      if (res != null) {
        if (res.status == true) {
          emit(ArchitechAditionalInfoSucess(successModel: res));
        } else {
          emit(ArchitechAditionalInfoError(message: "${res.message}"));
        }
      } else {
        emit(ArchitechAditionalInfoError(message: "No data available"));
      }
    } catch (e) {
      emit(ArchitechAditionalInfoError(message: "An error occurred: $e"));
    }
  }

  Future<void> createArchitechAditionalInfoUpdate(
    Map<String, dynamic> data,
  ) async {
    emit(ArchitechAditionalInfoUpdateLoading());
    try {
      final res = await architechAditionalInfoRepository
          .ArchitechAditionalInfoUpdate(data);
      if (res != null) {
        if (res.status == true) {
          emit(ArchitechAditionalInfoUpdateSucess(successModel: res));
        } else {
          emit(ArchitechAditionalInfoError(message: "${res.message}"));
        }
      } else {
        emit(ArchitechAditionalInfoError(message: "No data available"));
      }
    } catch (e) {
      emit(ArchitechAditionalInfoError(message: "An error occurred: $e"));
    }
  }
}
