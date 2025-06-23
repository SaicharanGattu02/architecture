import 'package:equatable/equatable.dart';

import '../../models/SuccessModel.dart';
import '../../models/VerifyOtpModel.dart';

abstract class CreatePostState extends Equatable {
  @override
  List<Object?> get props => [];
}

class CreatePostIntially extends CreatePostState {}

class CreatePostLoading extends CreatePostState {}


class CreatePostSucess extends CreatePostState {
  final SuccessModel successModel;
  CreatePostSucess({required this.successModel});
}


class CreatePostError extends CreatePostState {
  final String message;
  CreatePostError({required this.message});
}