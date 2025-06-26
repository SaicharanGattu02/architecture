import 'package:equatable/equatable.dart';

import '../../models/ArchitectModel.dart';
import '../../models/UserPosteDetailsModel.dart';
import '../../models/UserPostedModel.dart';

abstract class UserPostDetailsState extends Equatable {
  @override
  List<Object?> get props => [];
}

class UserPostDetailsIntailly extends UserPostDetailsState {}

class UserPostDetailsLoading extends UserPostDetailsState {}

class UserPostDetailsLoaded extends UserPostDetailsState {
  final UserPosteDetailsModel userPosteDetailsModel;
  UserPostDetailsLoaded({required this.userPosteDetailsModel});
}

class UserPostDetailsError extends UserPostDetailsState {
  final String message;
  UserPostDetailsError({required this.message});
}
