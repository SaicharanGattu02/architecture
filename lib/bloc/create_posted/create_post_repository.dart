
import '../../models/SuccessModel.dart';
import '../../models/VerifyOtpModel.dart';
import '../../services/remote_data_source.dart';

abstract class CreatePostRepository {
  Future<SuccessModel?> createPost(Map<String,dynamic> data);

}

class CreatePostImpl implements CreatePostRepository {
  final RemoteDataSource remoteDataSource;
  CreatePostImpl({required this.remoteDataSource});

  Future<SuccessModel?> createPost(Map<String,dynamic> data) async {
    return await remoteDataSource.createPost(data);
  }

}