import 'package:architect/models/CitiesModel.dart';
import 'package:architect/models/SuccessModel.dart';
import 'package:architect/services/remote_data_source.dart';

import '../../models/ArchitechCityModel.dart';

abstract class CityRepo {
  Future<List<CityModel>?> getCityApi(String state);
  Future<ArchitechCityModel?> getArchitechCityApi();
}


class CityImpl implements CityRepo {
  final RemoteDataSource remoteDataSource;

  CityImpl({required this.remoteDataSource});

  @override
  Future<List<CityModel>?> getCityApi(String state) async {
    return await remoteDataSource.getCity(state);
  }
  @override
  Future<ArchitechCityModel?> getArchitechCityApi() async {
    return await remoteDataSource.geArchitecttCity();
  }
}
