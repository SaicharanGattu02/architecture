import '../../models/StatesModel.dart';

abstract class StateStates {}

class StateIntially extends StateStates {}

class StateLoading extends StateStates {}

class StateLoaded extends StateStates {
  final List<StatesModel> statesList;

  StateLoaded({required this.statesList});
}


class StateFailure extends StateStates {
  final String msg;
  StateFailure({required this.msg});

}
