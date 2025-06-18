import 'package:architect/bloc/SubscriptionPlans/subscription_repository.dart';
import 'package:architect/bloc/SubscriptionPlans/subscription_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class subscription_cubit extends Cubit<subscription_state> {
  final SubscriptionRepository subscriptionRepository;

  subscription_cubit(this.subscriptionRepository) : super(subscriprionIntailly());

  Future<void> getsubscriptionplans() async {
    emit(subscriprionLoading());
    try {
      final res = await subscriptionRepository.getSubplans();
      if (res != null) {
        emit(subscriprionLoaded(subscriptionModel: res));
      } else {
        emit(subscriprionError(message: "No data available"));
      }
    } catch (e) {
      emit(subscriprionError(message: "An error occurred: $e"));
    }
  }
}