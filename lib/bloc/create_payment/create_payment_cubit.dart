import 'package:flutter_bloc/flutter_bloc.dart';
import '../login/login_repository.dart';
import 'create_payment_repository.dart';
import 'create_payment_state.dart';

class CreatePaymentCubit extends Cubit<CreatePaymentState> {
  final CreatePaymentRepository createPostRepository;

  CreatePaymentCubit(this.createPostRepository) : super(CreatePaymentIntially());

  Future<void> createPostApi(Map<String, dynamic> data) async {
    emit(CreatePaymentLoading());
    try {
      final res = await createPostRepository.createPayment(data);
      if (res != null) {
        if(res.status==true){
          emit(CreatePaymentSucess(successModel: res));
        }else{
          emit(CreatePaymentError(message: "${res.message}"));
        }

      } else {
        emit(CreatePaymentError(message: "No data available"));
      }
    } catch (e) {
      emit(CreatePaymentError(message: "An error occurred: $e"));
    }
  }

}
