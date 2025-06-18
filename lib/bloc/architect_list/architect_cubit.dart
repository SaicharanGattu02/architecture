import 'package:flutter_bloc/flutter_bloc.dart';

import 'architect_repository.dart';
import 'architect_state.dart';

class ArchitectCubit extends Cubit<ArchitectState> {
  final ArchitectRepository archeticrepository;

  ArchitectCubit(this.archeticrepository) : super(ArchitectIntailly());

  Future<void> getArchitect() async {
    emit(ArchitectLoading());
    try {
      final res = await archeticrepository.getArchitect();
      if (res != null) {
        emit(ArchitectLoaded(architectModel: res));
      } else {
        emit(ArchitectError(message: "No data available"));
      }
    } catch (e) {
      emit(ArchitectError(message: "An error occurred: $e"));
    }
  }
}
