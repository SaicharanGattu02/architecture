import 'package:equatable/equatable.dart';

import '../../models/SuccessModel.dart';
import '../../models/VerifyLogInOtpModel.dart';

abstract class LoginOtpState extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoginOtpIntially extends LoginOtpState {}

class LoginOtpLoading extends LoginOtpState {}

class LoginVerifyOtpLoading extends LoginOtpState {}

class LoginOtpSucess extends LoginOtpState {
  final SuccessModel successModel;
  LoginOtpSucess({required this.successModel});
}
class LoginResendOtpSucess extends LoginOtpState {
  final SuccessModel successModel;
  LoginResendOtpSucess({required this.successModel});
}
class CompanyResendOtpSucess extends LoginOtpState {
  final SuccessModel successModel;
  CompanyResendOtpSucess({required this.successModel});
}

class LoginVerifyOtpSucess extends LoginOtpState {
  final VerifyLogInOtpModel successModel;
  LoginVerifyOtpSucess({required this.successModel});
}

class LoginOtpError extends LoginOtpState {
  final String message;
  LoginOtpError({required this.message});
}
