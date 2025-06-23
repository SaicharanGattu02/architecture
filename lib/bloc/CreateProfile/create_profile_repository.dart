
import '../../models/SuccessModel.dart';
import '../../models/VerifyOtpModel.dart';
import '../../services/remote_data_source.dart';

abstract class CreateProfileRepository {
  Future<SuccessModel?> createProfile(Map<String,dynamic> data);
  Future<VerifyOtpModel?> createProfileVerifyOtp(Map<String,dynamic> data);
}

class CreateProfileImpl implements CreateProfileRepository {
  final RemoteDataSource remoteDataSource;
  CreateProfileImpl({required this.remoteDataSource});

  Future<SuccessModel?> createProfile(Map<String,dynamic> data) async {
    return await remoteDataSource.createProfile(data);
  }
  Future<VerifyOtpModel?> createProfileVerifyOtp(Map<String,dynamic> data) async {
    return await remoteDataSource.companyVerifyOtp(data);
  }
}