import 'package:equatable/equatable.dart';

import '../../models/ArchitectModel.dart';

abstract class ArchitectState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ArchitectIntailly extends ArchitectState {}

class ArchitectLoading extends ArchitectState {}

class ArchitectLoaded extends ArchitectState {
  final ArchitectModel architectModel;
  ArchitectLoaded({required this.architectModel});
}

class ArchitectError extends ArchitectState {
  final String message;
  ArchitectError({required this.message});
}
