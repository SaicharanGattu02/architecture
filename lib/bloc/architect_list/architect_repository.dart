import '../../models/ArchitectModel.dart';
import '../../services/remote_data_source.dart';

abstract class ArchitectRepository {
  Future<ArchitectModel?> getArchitect();
}

class ArchitectImpl implements ArchitectRepository {
  final RemoteDataSource remoteDataSource;
  ArchitectImpl({required this.remoteDataSource});

  Future<ArchitectModel?> getArchitect() async {
    return await remoteDataSource.getArchetic();
  }
}
