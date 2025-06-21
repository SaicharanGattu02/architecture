import 'package:architect/bloc/state/state_repository.dart';
import 'package:architect/bloc/state/state_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StateCubit extends Cubit<StateStates> {
  StateRepo stateRepo;
  StateCubit(this.stateRepo) : super(StateIntially());
  Future<void> getState() async {
    emit(StateLoading());
    try {
      final res = await stateRepo.getStateApi();
      if (res != null) {
        emit(StateLoading());
      } else {
        emit(StateFailure(msg: "An error occurred: ${res?.name ?? ""}"));
      }
    } catch (e) {
      emit(StateFailure(msg: "An error occurred: $e"));
    }
  }
}
