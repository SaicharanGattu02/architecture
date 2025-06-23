import 'package:equatable/equatable.dart';

import '../../models/ArchitectModel.dart';
import '../../models/UserPostedModel.dart';

abstract class UserPostsState extends Equatable {
  @override
  List<Object?> get props => [];
}

class UserPostsStateIntailly extends UserPostsState {

}

class UserPostsStateLoading extends UserPostsState {

}

class UserPostsStateLoaded extends UserPostsState {

  final UserPostedModel userPostedModel;
  UserPostsStateLoaded({required this.userPostedModel});

}

class UserPostsStateError extends UserPostsState {

  final String message;
  UserPostsStateError({required this.message});

}
