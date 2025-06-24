import 'package:equatable/equatable.dart';

import '../../models/ArchitechProfileModel.dart';
import '../../models/ArchitectModel.dart';
import '../../models/UserPostedModel.dart';

abstract class ArchitechProfileState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ArchitechProfileIntailly extends ArchitechProfileState {

}

class ArchitechProfileLoading extends ArchitechProfileState {

}

class ArchitechProfileLoaded extends ArchitechProfileState {

  final ArchitechProfileModel architechProfileModel;
  ArchitechProfileLoaded({required this.architechProfileModel});

}

class ArchitechProfileError extends ArchitechProfileState {

  final String message;
  ArchitechProfileError({required this.message});

}
