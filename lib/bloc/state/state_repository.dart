import 'package:architect/models/StatesModel.dart';
import 'package:architect/models/SuccessModel.dart';
import 'package:architect/services/remote_data_source.dart';

abstract class StateRepo {
  Future<List<StatesModel>?> getStateApi();
}

class StateImpl implements StateRepo {
  final RemoteDataSource remoteDataSource;

  StateImpl({required this.remoteDataSource});

  @override
  Future<List<StatesModel>?> getStateApi() async {
    return await remoteDataSource.getStates();
  }
}

