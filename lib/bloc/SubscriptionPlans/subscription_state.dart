import 'package:architect/models/SubscriptionModel.dart';
import 'package:equatable/equatable.dart';

import '../../models/ActiveSubscriptionmodel.dart';



abstract class SubscriptionState extends Equatable {
  @override
  List<Object?> get props => [];
}

class SubscriptionIntailly extends SubscriptionState {}

class SubscriptionLoading extends SubscriptionState {}
class ActiveSubscriptionLoading extends SubscriptionState {}

class SubscriptionLoaded extends SubscriptionState {
  final SubscriptionModel subscriptionModel;
  SubscriptionLoaded({required this.subscriptionModel});
}
class ActiveSubscriptionLoaded extends SubscriptionState {
  final ActiveSubscriptionModel activeSubscriptionModel;
  ActiveSubscriptionLoaded({required this.activeSubscriptionModel});
}

class SubscriptionError extends SubscriptionState {
  final String message;
  SubscriptionError({required this.message});
}