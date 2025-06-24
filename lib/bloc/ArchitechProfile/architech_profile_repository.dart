import '../../models/ArchitechProfileModel.dart';
import '../../models/UserPostedModel.dart';
import '../../services/remote_data_source.dart';

abstract class ArchitechProfileRepository {
  Future<ArchitechProfileModel?> getArchitechProfile();
}

class ArchitechProfileImpl implements ArchitechProfileRepository {
  final RemoteDataSource remoteDataSource;
  ArchitechProfileImpl({required this.remoteDataSource});

  Future<ArchitechProfileModel?> getArchitechProfile() async {
    return await remoteDataSource.getArchitechProfile();
  }
}
