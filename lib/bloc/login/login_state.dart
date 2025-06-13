import 'package:equatable/equatable.dart';

import '../../models/SuccessModel.dart';

abstract class LoginState extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoginIntially extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSucess extends LoginState {
  final SuccessModel successModel;
  LoginSucess({required this.successModel});
}

class LoginError extends LoginState {
  final String message;
  LoginError({required this.message});
}
