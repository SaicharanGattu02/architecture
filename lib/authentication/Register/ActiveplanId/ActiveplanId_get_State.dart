import 'package:architect/models/ActiveSubscriptionmodel.dart';
import 'package:equatable/equatable.dart';

abstract class ActiveplanidGetState extends Equatable {
  @override
  List<Object?> get props => [];
}

class subscriptionplanIntailly extends ActiveplanidGetState {}

class subscriptionplanLoading extends ActiveplanidGetState {}

class subscriptionplanLoaded extends ActiveplanidGetState {
  final Activesubscriptionmodel activesubscriptionmodel;
  subscriptionplanLoaded({required this.activesubscriptionmodel});
}

class subscriptionplanError extends ActiveplanidGetState {
  final String message;
  subscriptionplanError({required this.message});
}