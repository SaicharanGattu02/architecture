
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
  Future<void> getArchitectCity(String state) async {
    emit(CityArchitectLoading());
    try {
      final res = await cityRepo.getArchitechCityApi(state);
      if (res != null) {
        print('loaded');
        emit(CityArchitectLoaded(cityList: res));
      } else {
        print('failure');
        emit(CityFailure(msg: "An error occurred: ${res}"));
      }
    } catch (e) {
      print('catch');
      emit(CityFailure(msg: "An error occurred: $e"));
    }
  }
}
