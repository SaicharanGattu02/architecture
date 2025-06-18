import 'package:architect/models/SubscriptionModel.dart';
import 'package:equatable/equatable.dart';



abstract class SubscriptionState extends Equatable {
  @override
  List<Object?> get props => [];
}

class SubscriptionIntailly extends SubscriptionState {}

class SubscriptionLoading extends SubscriptionState {}

class SubscriptionLoaded extends SubscriptionState {
  final SubscriptionModel subscriptionModel;
  SubscriptionLoaded({required this.subscriptionModel});
}

class SubscriptionError extends SubscriptionState {
  final String message;
  SubscriptionError({required this.message});
}