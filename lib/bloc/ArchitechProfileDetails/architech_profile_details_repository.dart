import '../../models/ArchitechProfileModel.dart';
import '../../models/UserPostedModel.dart';
import '../../services/remote_data_source.dart';

abstract class ArchitechProfileDetailsRepository {
  Future<ArchitechProfileModel?> getArchitechProfileDetails(int id);
}

class ArchitechProfileDetailsImpl implements ArchitechProfileDetailsRepository {
  final RemoteDataSource remoteDataSource;
  ArchitechProfileDetailsImpl({required this.remoteDataSource});

  Future<ArchitechProfileModel?> getArchitechProfileDetails(int id) async {
    return await remoteDataSource.getArchitechProfileDetails(id);
  }
}
