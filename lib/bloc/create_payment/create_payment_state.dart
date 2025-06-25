import 'package:equatable/equatable.dart';

import '../../models/SuccessModel.dart';
import '../../models/VerifyOtpModel.dart';

abstract class CreatePaymentState extends Equatable {
  @override
  List<Object?> get props => [];
}

class CreatePaymentIntially extends CreatePaymentState {}

class CreatePaymentLoading extends CreatePaymentState {}


class CreatePaymentSucess extends CreatePaymentState {
  final SuccessModel successModel;
  CreatePaymentSucess({required this.successModel});
}


class CreatePaymentError extends CreatePaymentState {
  final String message;
  CreatePaymentError({required this.message});
}