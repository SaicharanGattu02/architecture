import 'package:architect/models/SubscriptionModel.dart';
import 'package:equatable/equatable.dart';



abstract class subscription_state extends Equatable {
  @override
  List<Object?> get props => [];
}

class subscriprionIntailly extends subscription_state {}

class subscriprionLoading extends subscription_state {}

class subscriprionLoaded extends subscription_state {
  final SubscriptionModel subscriptionModel;
  subscriprionLoaded({required this.subscriptionModel});
}

class subscriprionError extends subscription_state {
  final String message;
  subscriprionError({required this.message});
}