import 'package:flutter_bloc/flutter_bloc.dart';

import 'architect_repository.dart';
import 'architect_state.dart';

class ArchitectCubit extends Cubit<Archeticstate> {
  final ArchitectRepository archeticrepository;

  ArchitectCubit(this.archeticrepository) : super(archeticIntailly());

  Future<void> getarchitecture() async {
    emit(archeticLoading());
    try {
      final res = await archeticrepository.getArchitect();
      if (res != null) {
        emit(archeticLoaded(architectModel: res));
      } else {
        emit(archeticError(message: "No data available"));
      }
    } catch (e) {
      emit(archeticError(message: "An error occurred: $e"));
    }
  }
}
