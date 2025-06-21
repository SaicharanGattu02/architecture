
import 'package:flutter_bloc/flutter_bloc.dart';

import 'city_repository.dart';
import 'city_states.dart';

class CityCubit extends Cubit<CityStates> {
  CityRepo stateRepo;
  CityCubit(this.stateRepo) : super(CityIntially());
  Future<void> getCity(String city) async {
    emit(CityLoading());
    try {
      final res = await stateRepo.getCityApi(city);
      if (res != null) {
        emit(CityLoading());
      } else {
        emit(CityFailure(msg: "An error occurred: ${res?.name ?? ""}"));
      }
    } catch (e) {
      emit(CityFailure(msg: "An error occurred: $e"));
    }
  }
}
