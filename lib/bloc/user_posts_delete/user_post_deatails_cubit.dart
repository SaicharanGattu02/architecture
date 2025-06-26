import 'package:flutter_bloc/flutter_bloc.dart';

import 'user_post_details_repository.dart';
import 'user_post_details_state.dart';

class UserPostDetailsCubit extends Cubit<UserPostDetailsState> {
  final UserPostsDetailsRepository userPostsDetailsRepository;

  UserPostDetailsCubit(this.userPostsDetailsRepository) : super(UserPostDetailsIntailly());

  Future<void> getUserPostDetails(int id) async {
    emit(UserPostDetailsLoading());
    try {
      final res = await userPostsDetailsRepository.getUserPostDetails(id);
      if (res != null) {
        emit(UserPostDetailsLoaded(userPosteDetailsModel: res));
      } else {
        emit(UserPostDetailsError(message: "No data available"));
      }
    } catch (e) {
      emit(UserPostDetailsError(message: "An error occurred: $e"));
    }
  }
}
