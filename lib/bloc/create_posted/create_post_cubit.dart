import 'package:flutter_bloc/flutter_bloc.dart';
import '../login/login_repository.dart';
import 'create_post_repository.dart';
import 'create_post_state.dart';

class CreatePostCubit extends Cubit<CreatePostState> {
  final CreatePostRepository createPostRepository;

  CreatePostCubit(this.createPostRepository) : super(CreatePostIntially());

  Future<void> createPostApi(Map<String, dynamic> data) async {
    emit(CreatePostLoading());
    try {
      final res = await createPostRepository.createPost(data);
      if (res != null) {
        if(res.status==true){
          emit(CreatePostSucess(successModel: res));
        }else{
          emit(CreatePostError(message: "${res.message}"));
        }

      } else {
        emit(CreatePostError(message: "No data available"));
      }
    } catch (e) {
      emit(CreatePostError(message: "An error occurred: $e"));
    }
  }

}
