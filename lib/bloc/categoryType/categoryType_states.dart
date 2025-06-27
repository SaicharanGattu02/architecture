import 'package:architect/models/CitiesModel.dart';

import '../../models/CategoryTypeModel.dart';
import '../../models/StatesModel.dart';

abstract class CategoryTypeStates {}

class CategoryTypeIntially extends CategoryTypeStates {}

class CategoryTypeLoading extends CategoryTypeStates {}


class CategoryTypeLoaded extends CategoryTypeStates {
  final CategoryTypeModel categoryType;

  CategoryTypeLoaded({required this.categoryType});
}


class CategoryTypeFailure extends CategoryTypeStates {
  final String msg;
  CategoryTypeFailure({required this.msg});

}
