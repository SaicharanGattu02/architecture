import '../../models/UserPosteDetailsModel.dart';
import '../../models/UserPostedModel.dart';
import '../../services/remote_data_source.dart';

abstract class UserPostsDetailsRepository {
  Future<UserPosteDetailsModel?> getUserPostDetails(int id);
}

class UserPostDetailsImpl implements UserPostsDetailsRepository {
  final RemoteDataSource remoteDataSource;
  UserPostDetailsImpl({required this.remoteDataSource});

  Future<UserPosteDetailsModel?> getUserPostDetails(int id) async {
    return await remoteDataSource.getUserPostDetails(id);
  }
}
