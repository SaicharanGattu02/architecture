import 'package:architect/bloc/state/state_repository.dart';
import 'package:architect/bloc/state/state_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StateCubit extends Cubit<StateStates>{
  StateRepo stateRepo;
  StateCubit(this.stateRepo):super(StateIntially());
  Future<void>getState()async{
    emit(StateLoading());
    try{

    }catch(e){

    }
  }

}