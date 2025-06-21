abstract class CityStates {
  
}

class CityIntially extends CityStates {}

class CityLoading extends CityStates {}

class CityLoaded extends CityStates {}

class CityFailure extends CityStates {
  final String msg;
  CityFailure({required this.msg});
}
