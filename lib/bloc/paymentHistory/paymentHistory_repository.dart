import 'package:architect/models/CitiesModel.dart';
import 'package:architect/services/remote_data_source.dart';

import '../../models/CategoryTypeModel.dart';
import '../../models/PaymentHistoryModel.dart';

abstract class PaymentHistoryRepo {
  Future<PaymentHistoryModel?> getPaymentHistoryApi(int id);

}

class PaymentHistoryImpl implements PaymentHistoryRepo {
  final RemoteDataSource remoteDataSource;
  PaymentHistoryImpl({required this.remoteDataSource});

  @override
  Future<PaymentHistoryModel?> getPaymentHistoryApi(int id) async {
    return await remoteDataSource.getArchitechPaymentsHistory( id);
  }
}

