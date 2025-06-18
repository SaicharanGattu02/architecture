import 'package:architect/models/SubscriptionModel.dart';

import '../../services/remote_data_source.dart';

abstract class SubscriptionRepository {
  Future<SubscriptionModel?> getSubplans();
}

class GetsubplansImpl implements SubscriptionRepository {
  final RemoteDataSource remoteDataSource;
  GetsubplansImpl({required this.remoteDataSource});

  Future<SubscriptionModel?> getSubplans() async {
    return await remoteDataSource.getsubplans();
  }
}
