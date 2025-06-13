
import 'package:flutter_bloc/flutter_bloc.dart';

import 'add_edit_post_repository.dart';
import 'add_edit_post_state.dart';

class AddEditPostCubit extends Cubit<AddEditPostState> {
  final AddEditPostRepository addEditPostRepository;

  AddEditPostCubit(this.addEditPostRepository) : super(AddEditPostIntially());

  Future<void> addPost(Map<String, dynamic> data) async {
    emit(AddEditPostLoading());
    try {
      final res = await addEditPostRepository.addPost(data);
      if (res != null) {
        emit(AddEditPostLoaded(successModel: res));
      } else {
        emit(AddEditPostError(message: "No data available"));
      }
    } catch (e) {
      emit(AddEditPostError(message: "An error occurred: $e"));
    }
  }

  Future<void> editPost(Map<String, dynamic> data, String id) async {
    emit(AddEditPostLoading());
    try {
      final res = await addEditPostRepository.editPost(data, id);
      if (res != null) {
        emit(AddEditPostLoaded(successModel: res));
      } else {
        emit(AddEditPostError(message: "No data available"));
      }
    } catch (e) {
      emit(AddEditPostError(message: "An error occurred: $e"));
    }
  }

  Future<void> deletePost(String id) async {
    emit(AddEditPostLoading());
    try {
      final res = await addEditPostRepository.deletePost(id);
      if (res != null) {
        emit(AddEditPostLoaded(successModel: res));
      } else {
        emit(AddEditPostError(message: "No data available"));
      }
    } catch (e) {
      emit(AddEditPostError(message: "An error occurred: $e"));
    }
  }
}
