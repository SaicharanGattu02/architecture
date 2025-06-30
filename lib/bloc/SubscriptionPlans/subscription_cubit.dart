import 'package:architect/bloc/SubscriptionPlans/subscription_repository.dart';
import 'package:architect/bloc/SubscriptionPlans/subscription_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SubscriptionCubit extends Cubit<SubscriptionState> {
  final SubscriptionRepository subscriptionRepository;

  SubscriptionCubit(this.subscriptionRepository)
    : super(SubscriptionIntailly());

  Future<void> getsubscriptionplans() async {
    emit(SubscriptionLoading());
    try {
      final res = await subscriptionRepository.getSubplans();
      if (res != null) {
        emit(SubscriptionLoaded(subscriptionModel: res));
      } else {
        emit(SubscriptionError(message: "No data available"));
      }
    } catch (e) {
      emit(SubscriptionError(message: "An error occurred: $e"));
    }
  }

  Future<void> getActiveSubscriptionPlan(int id) async {
    emit(ActiveSubscriptionLoading());
    try {
      final res = await subscriptionRepository.getSubscriptionPlan(id);
      if (res != null) {
        if (res.status == true) {
          emit(ActiveSubscriptionLoaded(activeSubscriptionModel: res));
        } else {
          emit(SubscriptionError(message: "No data available"));
        }
      } else {
        emit(SubscriptionError(message: "No data available"));
      }
    } catch (e) {
      emit(SubscriptionError(message: "An error occurred: $e"));
    }
  }
}
