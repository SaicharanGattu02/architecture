import 'package:architect/models/SuccessModel.dart';
import 'package:architect/services/remote_data_source.dart';

abstract class CityRepo {
  Future<SuccessModel?> getCityApi();
}

class CityImpl implements CityRepo {
  final RemoteDataSource remoteDataSource;
  CityImpl({required this.remoteDataSource});

  Future<SuccessModel?> getCityApi() async {
    return await remoteDataSource.getCity();
  }
}
