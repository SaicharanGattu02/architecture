import 'package:architect/models/CitiesModel.dart';
import 'package:architect/models/SuccessModel.dart';
import 'package:architect/services/remote_data_source.dart';

abstract class CityRepo {
  Future<List<CityModel>?> getCityApi(String state);
}


class CityImpl implements CityRepo {
  final RemoteDataSource remoteDataSource;

  CityImpl({required this.remoteDataSource});

  @override
  Future<List<CityModel>?> getCityApi(String state) async {
    return await remoteDataSource.getCity(state);
  }
}
