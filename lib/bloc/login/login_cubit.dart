import 'package:flutter_bloc/flutter_bloc.dart';
import 'login_repository.dart';
import 'login_state.dart';

class LoginOTPCubit extends Cubit<LoginOtpState> {
  final LoginOTPRepository loginotpRepository;

  LoginOTPCubit(this.loginotpRepository) : super(LoginOtpIntially());

  Future<void> logInOtpApi(Map<String, dynamic> data) async {
    emit(LoginOtpLoading());
    try {
      final res = await loginotpRepository.loginOtpApi(data);
      if (res != null) {
        if (res.status == true) {
          emit(LoginOtpSucess(successModel: res));
        } else {
          emit(LoginOtpError(message: "${res.message}"));
        }
      } else {
        emit(LoginOtpError(message: "No data available"));
      }
    } catch (e) {
      emit(LoginOtpError(message: "An error occurred: $e"));
    }
  }

  Future<void> logInResendOtpApi(Map<String, dynamic> data) async {
    emit(LoginOtpLoading());
    try {
      final res = await loginotpRepository.loginResendOtpApi(data);
      if (res != null) {
        if (res.status == true) {
          emit(LoginResendOtpSucess(successModel: res));
        } else {
          emit(LoginOtpError(message: "${res.message}"));
        }
      } else {
        emit(LoginOtpError(message: "No data available"));
      }
    } catch (e) {
      emit(LoginOtpError(message: "An error occurred: $e"));
    }
  }

  Future<void> resendCompanyCreateOtp(Map<String, dynamic> data) async {
    emit(LoginOtpLoading());
    try {
      final res = await loginotpRepository.resendVerifyCompanyOtp(data);
      if (res != null) {
        if (res.status == true) {
          emit(CompanyResendOtpSucess(successModel: res));
        } else {
          emit(LoginOtpError(message: "${res.message}"));
        }
      } else {
        emit(LoginOtpError(message: "No data available"));
      }
    } catch (e) {
      emit(LoginOtpError(message: "An error occurred: $e"));
    }
  }

  Future<void> logInVerifyOtpApi(Map<String, dynamic> data) async {
    emit(LoginVerifyOtpLoading());
    try {
      final res = await loginotpRepository.verifyLoginOtp(data);
      if (res != null) {
        if (res.status == true) {
          emit(LoginVerifyOtpSucess(successModel: res));
        } else {
          emit(LoginOtpError(message: "${res.message}"));
        }
      } else {
        emit(LoginOtpError(message: "No data available"));
      }
    } catch (e) {
      emit(LoginOtpError(message: "An error occurred: $e"));
    }
  }
}
