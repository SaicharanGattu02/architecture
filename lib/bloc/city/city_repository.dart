import 'package:architect/models/CitiesModel.dart';
import 'package:architect/models/SuccessModel.dart';
import 'package:architect/services/remote_data_source.dart';

abstract class CityRepo {
  Future<Citiesmodel?> getCityApi();
}

class CityImpl implements CityRepo {
  final RemoteDataSource remoteDataSource;
  CityImpl({required this.remoteDataSource});

  Future<Citiesmodel?> getCityApi() async {
    return await remoteDataSource.getCity();
  }
}
