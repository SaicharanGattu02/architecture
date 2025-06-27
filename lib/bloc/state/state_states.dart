import '../../models/ArchitechStatesModel.dart';
import '../../models/StatesModel.dart';

abstract class StateStates {}

class StateIntially extends StateStates {}

class StateLoading extends StateStates {}
class StateArchitectLoading extends StateStates {}

class StateLoaded extends StateStates {
  final List<StatesModel> statesList;

  StateLoaded({required this.statesList});
}
class StateArchitectLoaded extends StateStates {
  final ArchitechStatesModel statesList;

  StateArchitectLoaded({required this.statesList});
}

class StateFailure extends StateStates {
  final String msg;
  StateFailure({required this.msg});

}
