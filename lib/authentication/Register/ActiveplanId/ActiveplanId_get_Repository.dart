import 'dart:ffi';

import 'package:architect/models/ActiveSubscriptionmodel.dart';

import '../../../services/remote_data_source.dart';

abstract class ActiveplanidGetRepository {
  Future<Activesubscriptionmodel?> getsubscriptionplans(int Id);
}

class GetactiveplansImpl implements ActiveplanidGetRepository {
  final RemoteDataSource remoteDataSource;
  GetactiveplansImpl({required this.remoteDataSource});

  Future<Activesubscriptionmodel?> getsubscriptionplans(int Id) async {
    return await remoteDataSource.activesubplans(Id);
  }

}