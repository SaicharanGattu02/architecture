
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/CitiesModel.dart';
import 'city_repository.dart';
import 'city_states.dart';

class CityCubit extends Cubit<CityStates> {
  CityRepo cityRepo;
  CityCubit(this.cityRepo) : super(CityIntially());
  Future<void> getCity(String state) async {
    emit(CityLoading());
    try {
      final List<CityModel>? res = await cityRepo.getCityApi(state);
      if (res != null) {
        emit(CityLoaded(cityList: res));
      } else {
        emit(CityFailure(msg: "An error occurred: ${res}"));
      }
    } catch (e) {
      emit(CityFailure(msg: "An error occurred: $e"));
    }
  }
}
