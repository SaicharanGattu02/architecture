import 'package:architect/models/SubscriptionModel.dart';

import '../../models/ActiveSubscriptionmodel.dart';
import '../../services/remote_data_source.dart';

abstract class SubscriptionRepository {
  Future<SubscriptionModel?> getSubplans();
  Future<Activesubscriptionmodel?> getsubscriptionplans(int id);
}

class GetsubplansImpl implements SubscriptionRepository {
  final RemoteDataSource remoteDataSource;
  GetsubplansImpl({required this.remoteDataSource});

  Future<SubscriptionModel?> getSubplans() async {
    return await remoteDataSource.getsubplans();
  }
  Future<Activesubscriptionmodel?> getsubscriptionplans(int id) async {
    return await remoteDataSource.activeSubplans(id);
  }
}
