import 'package:architect/authentication/Register/ActiveplanId/ActiveplanId_get_Repository.dart';
import 'package:architect/authentication/Register/ActiveplanId/ActiveplanId_get_State.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ActiveplanidGetCubit extends Cubit<ActiveplanidGetState> {
  final ActiveplanidGetRepository activeplanidGetRepository;

  ActiveplanidGetCubit(this.activeplanidGetRepository) : super(subscriptionplanIntailly());

  Future<void> getarchitecture(int Id) async {
    emit( subscriptionplanLoading());
    try {
      final res = await activeplanidGetRepository.getsubscriptionplans(Id);
      if (res != null) {
        emit(subscriptionplanLoaded(activesubscriptionmodel: res));
      } else {
        emit(subscriptionplanError(message: "No data available"));
      }
    } catch (e) {
      emit(subscriptionplanError(message: "An error occurred: $e"));
    }


  }
}