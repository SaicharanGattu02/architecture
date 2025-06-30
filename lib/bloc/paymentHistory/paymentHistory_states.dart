import 'package:architect/models/CitiesModel.dart';

import '../../models/CategoryTypeModel.dart';
import '../../models/PaymentHistoryModel.dart';
import '../../models/StatesModel.dart';

abstract class PaymentsHistoryStates {}

class PaymentsHistoryIntially extends PaymentsHistoryStates {}

class PaymentsHistoryLoading extends PaymentsHistoryStates {}


class PaymentsHistoryLoaded extends PaymentsHistoryStates {
  final PaymentHistoryModel paymentHistoryModel;

  PaymentsHistoryLoaded({required this.paymentHistoryModel});
}


class PaymentsHistoryFailure extends PaymentsHistoryStates {
  final String msg;
  PaymentsHistoryFailure({required this.msg});

}
