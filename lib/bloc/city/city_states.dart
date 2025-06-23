import '../../models/CitiesModel.dart';

abstract class CityStates {
  
}

class CityIntially extends CityStates {}

class CityLoading extends CityStates {}

class CityLoaded extends CityStates {
  final List<CityModel> cityList;

  CityLoaded({required this.cityList});
}


class CityFailure extends CityStates {
  final String msg;
  CityFailure({required this.msg});
}
