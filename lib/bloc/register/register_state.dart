import 'package:equatable/equatable.dart';

import '../../models/SuccessModel.dart';

abstract class RegisterState extends Equatable {
  @override
  List<Object?> get props => [];
}

class RegisterIntially extends RegisterState {}

class RegisterLoading extends RegisterState {}

class RegisterLoaded extends RegisterState {
  final SuccessModel successModel;
  RegisterLoaded({required this.successModel});
}

class RegisterError extends RegisterState {
  final String message;
  RegisterError({required this.message});
}
