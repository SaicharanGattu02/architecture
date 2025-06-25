
import '../../models/SuccessModel.dart';
import '../../models/VerifyOtpModel.dart';
import '../../services/remote_data_source.dart';

abstract class CreatePaymentRepository {
  Future<SuccessModel?> createPayment(Map<String,dynamic> data);

}

class CreatePaymentImpl implements CreatePaymentRepository {
  final RemoteDataSource remoteDataSource;
  CreatePaymentImpl({required this.remoteDataSource});

  Future<SuccessModel?> createPayment(Map<String,dynamic> data) async {
    return await remoteDataSource.createPayment(data);
  }

}