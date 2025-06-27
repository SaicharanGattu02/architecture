import 'package:equatable/equatable.dart';

import '../../models/ArchitechProfileModel.dart';
import '../../models/ArchitectModel.dart';
import '../../models/UserPostedModel.dart';

abstract class ArchitechProfileDetailsState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ArchitechProfileDetailsIntailly extends ArchitechProfileDetailsState {}

class ArchitechProfileDetailsLoading extends ArchitechProfileDetailsState {}
// class UserArchitechProfileDetailsLoading extends ArchitechProfileDetailsState {}

class ArchitechProfileDetailsLoaded extends ArchitechProfileDetailsState {
  final ArchitechProfileModel architechProfileModel;
  ArchitechProfileDetailsLoaded({required this.architechProfileModel});
}
// class UserArchitechProfileDetailsLoaded extends ArchitechProfileDetailsState {
//   final ArchitechProfileModel architechProfileModel;
//   UserArchitechProfileDetailsLoaded({required this.architechProfileModel});
// }

class ArchitechProfileDetailsError extends ArchitechProfileDetailsState {
  final String message;
  ArchitechProfileDetailsError({required this.message});
}
