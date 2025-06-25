import 'package:equatable/equatable.dart';

import '../../models/SuccessModel.dart';
import '../../models/VerifyOtpModel.dart';

abstract class ArchitechAditionalInfoState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ArchitechAditionalInfoIntially extends ArchitechAditionalInfoState {}

class ArchitechAditionalInfoLoading extends ArchitechAditionalInfoState {}
class ArchitechAditionalInfoUpdateLoading extends ArchitechAditionalInfoState {}

class ArchitechAditionalInfoSucess extends ArchitechAditionalInfoState {
  final SuccessModel successModel;
  ArchitechAditionalInfoSucess({required this.successModel});
}
class ArchitechAditionalInfoUpdateSucess extends ArchitechAditionalInfoState {
  final SuccessModel successModel;
  ArchitechAditionalInfoUpdateSucess({required this.successModel});
}

class ArchitechAditionalInfoError extends ArchitechAditionalInfoState {
  final String message;
  ArchitechAditionalInfoError({required this.message});
}