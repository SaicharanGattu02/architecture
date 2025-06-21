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
        emit(LoginOtpSucess(successModel: res));
      } else {
        emit(LoginOtpError(message: "No data available"));
      }
    } catch (e) {
      emit(LoginOtpError(message: "An error occurred: $e"));
    }
  }
}
