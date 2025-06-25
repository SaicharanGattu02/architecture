import 'package:flutter_bloc/flutter_bloc.dart';
import '../login/login_repository.dart';
import 'create_profile_repository.dart';
import 'create_profile_state.dart';

class CreateProfileCubit extends Cubit<CreateProfileState> {
  final CreateProfileRepository createProfileRepository;

  CreateProfileCubit(this.createProfileRepository) : super(CreateProfileIntially());

  Future<void> createProfileApi(Map<String, dynamic> data) async {
    emit(CreateProfileLoading());
    try {
      final res = await createProfileRepository.createProfile(data);
      if (res != null) {
        if(res.status==true){
          emit(CreateProfileSucess(successModel: res));
        }else{
          emit(CreateProfileError(message: "${res.message}"));
        }

      } else {
        emit(CreateProfileError(message: "No data available"));
      }
    } catch (e) {
      emit(CreateProfileError(message: "An error occurred: $e"));
    }
  }
  Future<void> updateComapnyProfileApi(Map<String, dynamic> data) async {
    emit(CreateProfileLoading());
    try {
      final res = await createProfileRepository.updateCompanyProfile(data);
      if (res != null) {
        if(res.status==true){
          emit(UpdateCompanyProfileSucess(successModel: res));
        }else{
          emit(CreateProfileError(message: "${res.message}"));
        }

      } else {
        emit(CreateProfileError(message: "No data available"));
      }
    } catch (e) {
      emit(CreateProfileError(message: "An error occurred: $e"));
    }
  }
  Future<void> createProfileVerifyOtpApi(Map<String, dynamic> data) async {
    emit(CreateProfileVerifyOtpLoading());
    try {
      final res = await createProfileRepository.createProfileVerifyOtp(data);
      if (res != null) {
        if(res.status==true){
          emit(CreateProfileVerifyOTPSucess(successModel: res));
        }else{
          emit(CreateProfileError(message: "${res.message}"));
        }

      } else {
        emit(CreateProfileError(message: "No data available"));
      }
    } catch (e) {
      emit(CreateProfileError(message: "An error occurred: $e"));
    }
  }
}
