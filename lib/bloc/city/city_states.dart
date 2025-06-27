import '../../models/ArchitechCityModel.dart';
import '../../models/CitiesModel.dart';

abstract class CityStates {
  
}

class CityIntially extends CityStates {}

class CityLoading extends CityStates {}
class CityArchitectLoading extends CityStates {}

class CityLoaded extends CityStates {
  final List<CityModel> cityList;

  CityLoaded({required this.cityList});
}
class CityArchitectLoaded extends CityStates {
  final ArchitechCityModel cityList;

  CityArchitectLoaded({required this.cityList});
}


class CityFailure extends CityStates {
  final String msg;
  CityFailure({required this.msg});
}
