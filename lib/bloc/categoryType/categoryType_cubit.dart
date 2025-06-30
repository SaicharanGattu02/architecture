import 'package:architect/bloc/categoryType/categoryType_states.dart';
import 'package:architect/bloc/state/state_repository.dart';
import 'package:architect/bloc/state/state_states.dart';
import 'package:architect/models/CitiesModel.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/StatesModel.dart';
import 'categoryType_repository.dart';

class CategoryTypeCubit extends Cubit<CategoryTypeStates> {
  CategoryTypeRepo categoryTypeRepo;

  CategoryTypeCubit(this.categoryTypeRepo) : super(CategoryTypeIntially());

  Future<void> getCategoryType(String cities) async {
    emit(CategoryTypeLoading());
    try {
      final  res = await categoryTypeRepo.getCategoryTypeApi(cities);
      if (res != null) {
        emit(CategoryTypeLoaded(categoryType:res ));
      } else {
        emit(CategoryTypeFailure(msg: "No categoryType found."));
      }
    } catch (e) {
      emit(CategoryTypeFailure(msg: "An error occurred: $e"));
    }
  }
}
