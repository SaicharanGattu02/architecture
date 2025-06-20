
import '../../models/SuccessModel.dart';
import '../../services/remote_data_source.dart';

abstract class LoginOTPRepository {
  Future<SuccessModel?> loginOtpApi(Map<String,dynamic> data);
}

class LogInRepositoryImpl implements LoginOTPRepository {
  final RemoteDataSource remoteDataSource;
  LogInRepositoryImpl({required this.remoteDataSource});

  Future<SuccessModel?> loginOtpApi(Map<String,dynamic> data) async {
    return await remoteDataSource.loginotp(data);
  }
}