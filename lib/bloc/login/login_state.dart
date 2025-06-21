import 'package:equatable/equatable.dart';

import '../../models/SuccessModel.dart';

abstract class LoginOtpState extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoginOtpIntially extends LoginOtpState {}

class LoginOtpLoading extends LoginOtpState {}

class LoginOtpSucess extends LoginOtpState {
  final SuccessModel successModel;
  LoginOtpSucess({required this.successModel});
}

class LoginOtpError extends LoginOtpState {
  final String message;
  LoginOtpError({required this.message});
}