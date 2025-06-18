abstract class StateStates {}

class StateIntially extends StateStates {}

class StateLoading extends StateStates {}

class StateLoaded extends StateStates {}

class StateFailure extends StateStates {
  final String msg;
  StateFailure({required this.msg});

}
