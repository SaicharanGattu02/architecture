
import '../../models/SuccessModel.dart';
import '../../models/VerifyOtpModel.dart';
import '../../services/remote_data_source.dart';

abstract class ArchitechAditionalInfoRepository {
  Future<SuccessModel?> createArchitechAditionalInfo(Map<String,dynamic> data);
}

class ArchitechAditionalInfoImpl implements ArchitechAditionalInfoRepository {
  final RemoteDataSource remoteDataSource;
  ArchitechAditionalInfoImpl({required this.remoteDataSource});

  Future<SuccessModel?> createArchitechAditionalInfo(Map<String,dynamic> data) async {
    return await remoteDataSource.ArchitechCompanyAdditionalInfoPost(data);
  }

}