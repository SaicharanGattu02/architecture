import 'package:architect/bloc/categoryType/categoryType_states.dart';
import 'package:architect/bloc/paymentHistory/paymentHistory_states.dart';
import 'package:architect/bloc/state/state_repository.dart';
import 'package:architect/bloc/state/state_states.dart';
import 'package:architect/models/CitiesModel.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/StatesModel.dart';
import 'paymentHistory_repository.dart';

class PaymentHistoryCubit extends Cubit<PaymentsHistoryStates> {
  PaymentHistoryRepo paymentHistoryRepo;

  PaymentHistoryCubit(this.paymentHistoryRepo) : super(PaymentsHistoryIntially());

  Future<void> getPaymentHistory(int id) async {
    emit(PaymentsHistoryLoading());
    try {
      final  res = await paymentHistoryRepo.getPaymentHistoryApi(id);
      if (res != null) {
        emit(PaymentsHistoryLoaded(paymentHistoryModel:res ));
      } else {
        emit(PaymentsHistoryFailure(msg: "No categoryType found."));
      }
    } catch (e) {
      emit(PaymentsHistoryFailure(msg: "An error occurred: $e"));
    }
  }
}
