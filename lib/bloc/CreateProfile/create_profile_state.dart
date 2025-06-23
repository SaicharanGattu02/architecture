import 'package:equatable/equatable.dart';

import '../../models/SuccessModel.dart';
import '../../models/VerifyOtpModel.dart';

abstract class CreateProfileState extends Equatable {
  @override
  List<Object?> get props => [];
}

class CreateProfileIntially extends CreateProfileState {}

class CreateProfileLoading extends CreateProfileState {}
class CreateProfileVerifyOtpLoading extends CreateProfileState {}

class CreateProfileSucess extends CreateProfileState {
  final SuccessModel successModel;
  CreateProfileSucess({required this.successModel});
}
class CreateProfileVerifyOTPSucess extends CreateProfileState {
  final VerifyOtpModel successModel;
  CreateProfileVerifyOTPSucess({required this.successModel});
}

class CreateProfileError extends CreateProfileState {
  final String message;
  CreateProfileError({required this.message});
}