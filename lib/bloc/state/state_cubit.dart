import 'package:architect/bloc/state/state_repository.dart';
import 'package:architect/bloc/state/state_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/StatesModel.dart';

class StateCubit extends Cubit<StateStates> {
  StateRepo stateRepo;

  StateCubit(this.stateRepo) : super(StateIntially());

  Future<void> getState() async {
    emit(StateLoading());
    try {
      final List<StatesModel>? res = await stateRepo.getStateApi();
      if (res != null) {
        emit(StateLoaded(statesList: res));
      } else {
        emit(StateFailure(msg: "No states found."));
      }
    } catch (e) {
      emit(StateFailure(msg: "An error occurred: $e"));
    }
  }
}
