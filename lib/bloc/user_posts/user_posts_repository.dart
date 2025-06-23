import '../../models/UserPostedModel.dart';
import '../../services/remote_data_source.dart';

abstract class UserPostsRepository {
  Future<UserPostedModel?> getUserPosts();
}

class UserPostsImpl implements UserPostsRepository {
  final RemoteDataSource remoteDataSource;
  UserPostsImpl({required this.remoteDataSource});

  Future<UserPostedModel?> getUserPosts() async {
    return await remoteDataSource.getUserPosts();
  }
}
