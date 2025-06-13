import '../../models/SuccessModel.dart';
import '../../services/remote_data_source.dart';

abstract class RegisterRepository {
  Future<SuccessModel?> registerApi(Map<String,dynamic> data);
}

class RegisterRepositoryImpl implements RegisterRepository {
  final RemoteDataSource remoteDataSource;
  RegisterRepositoryImpl({required this.remoteDataSource});

  Future<SuccessModel?> registerApi(Map<String,dynamic> data) async {
    return await remoteDataSource.registerApi(data);
  }
}