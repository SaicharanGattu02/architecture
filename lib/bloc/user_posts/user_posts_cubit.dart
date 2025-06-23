import 'package:flutter_bloc/flutter_bloc.dart';

import 'user_posts_repository.dart';
import 'user_posts_state.dart';

class UserPostsCubit extends Cubit<UserPostsState> {
  final UserPostsRepository archeticrepository;

  UserPostsCubit(this.archeticrepository) : super(UserPostsStateIntailly());

  Future<void> getUserPosts() async {
    emit(UserPostsStateLoading());
    try {
      final res = await archeticrepository.getUserPosts();
      if (res != null) {
        emit(UserPostsStateLoaded(userPostedModel: res));
      } else {
        emit(UserPostsStateError(message: "No data available"));
      }
    } catch (e) {
      emit(UserPostsStateError(message: "An error occurred: $e"));
    }
  }
}
