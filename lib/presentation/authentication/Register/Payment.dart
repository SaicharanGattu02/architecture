import 'package:architect/presentation/Components/CustomSnackBar.dart';
import 'package:architect/utils/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../bloc/create_payment/create_payment_cubit.dart';
import '../../../bloc/create_payment/create_payment_state.dart';
import '../../Components/CustomAppButton.dart';
import '../../Components/CutomAppBar.dart';

class Payment extends StatefulWidget {
  final Map<String, dynamic> data;
  final String type;
  const  Payment({Key? key, required this.data,required this.type}) : super(key: key);

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<Payment> {
  String _method = 'RazorPay';

  final List<String> _paymentMethods = ['GooglePay', 'RazorPay', 'PhonePay'];

  Widget _buildOption(String label) {
    final bool selected = _method == label;
    return GestureDetector(
      onTap: () => setState(() => _method = label),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          border: Border.all(color: selected ? Colors.white : Colors.white38),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                label,
                style: const TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ),
            Icon(
              selected ? Icons.radio_button_checked : Icons.radio_button_off,
              color: selected ? Colors.white : Colors.white38,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primarycolor,
      appBar: CustomAppBar1(title: 'Payment', actions: []),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            child: Text(
              'Select a payment method',
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
          ..._paymentMethods.map((method) => _buildOption(method)).toList(),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: BlocConsumer<CreatePaymentCubit, CreatePaymentState>(
            listener: (context, state) {
              if (state is CreatePaymentSucess) {
                Future.delayed(const Duration(seconds: 1), () {
                  if(widget.type=="Renew"){
                    context.go('/architech_profile');

                  }else{
                    context.go('/architect_profile_setup?id=${widget.data['company_id']}&type=New');
                  }

                });
              } else if (state is CreatePaymentError) {
                CustomSnackBar.show(context, state.message);
              }
            },
            builder: (context, state) {
              return CustomAppButton1(
                isLoading: state is CreatePaymentLoading,
                text: 'Continue',
                onPlusTap: () {
                  final updatedData = {
                    ...widget.data,
                    "payment_method": _method,
                    "status": "completed",
                  };
                  context.read<CreatePaymentCubit>().createPaymentApi(updatedData);
                  print("selectedPlan data: $updatedData");
                },
              );
            },
          ),
        ),
      ),
    );
  }
}

