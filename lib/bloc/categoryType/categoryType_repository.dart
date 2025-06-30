import 'package:architect/models/CitiesModel.dart';
import 'package:architect/services/remote_data_source.dart';

import '../../models/CategoryTypeModel.dart';

abstract class CategoryTypeRepo {
  Future<CategoryTypeModel?> getCategoryTypeApi(String cities);

}

class CategoryTypeImpl implements CategoryTypeRepo {
  final RemoteDataSource remoteDataSource;
  CategoryTypeImpl({required this.remoteDataSource});

  @override
  Future<CategoryTypeModel?> getCategoryTypeApi(String cities) async {
    return await remoteDataSource.getArchitectCategoryType( cities);
  }
}

