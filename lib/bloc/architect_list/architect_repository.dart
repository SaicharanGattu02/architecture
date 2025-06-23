import '../../models/ArchitectModel.dart';
import '../../services/remote_data_source.dart';

abstract class ArchitectRepository {
  Future<GetArchitectsModel?> getArchitect(String industrialType,String location);
}

class ArchitectImpl implements ArchitectRepository {
  final RemoteDataSource remoteDataSource;
  ArchitectImpl({required this.remoteDataSource});

  Future<GetArchitectsModel?> getArchitect(String industrialType,String location) async {
    return await remoteDataSource.getArchitect(industrialType,location);
  }
}
