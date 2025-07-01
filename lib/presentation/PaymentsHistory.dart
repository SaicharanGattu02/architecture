import 'package:architect/bloc/paymentHistory/paymentHistory_states.dart';
import 'package:architect/presentation/Components/CutomAppBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/paymentHistory/paymentHistory_cubit.dart';
import '../utils/color_constants.dart';

class PaymentsHistory extends StatefulWidget {
  final int id;
  const PaymentsHistory({super.key, required this.id});

  @override
  State<PaymentsHistory> createState() => _PaymentsHistoryState();
}

class _PaymentsHistoryState extends State<PaymentsHistory> {
  @override
  void initState() {
    super.initState();
    context.read<PaymentHistoryCubit>().getPaymentHistory(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primarycolor,
      appBar: CustomAppBar1(title: 'Payments History', actions: []),
      body: BlocBuilder<PaymentHistoryCubit, PaymentsHistoryStates>(
        builder: (context, state) {
          if (state is PaymentsHistoryLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is PaymentsHistoryLoaded) {
            final data = state.paymentHistoryModel.data;
            if (data == null || data.isEmpty) {
              return const Center(
                child: Text(
                  "No payment history found.",
                  style: TextStyle(color: Colors.white),
                ),
              );
            }

            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: data.length,
              itemBuilder: (context, index) {
                final payment = data[index];
                return Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1E1E1E),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey.withOpacity(0.4)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 6,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            payment.planName ?? "Subscription Plan",
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            payment.paidAt?.split(" ").first ?? '',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey.shade400,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),

                      Text(
                        '₹ ${payment.amount ?? "0"}',
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF00FFAA),
                        ),
                      ),
                      const SizedBox(height: 8),

                      Row(
                        children: [
                          const Icon(
                            Icons.payment,
                            size: 18,
                            color: Colors.grey,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            'Payment Method: ${payment.paymentMethod ?? "—"}',
                            style: const TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),

                      Row(
                        children: [
                          const Icon(
                            Icons.confirmation_number,
                            size: 18,
                            color: Colors.grey,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            'Txn ID: ${payment.transactionId}',
                            style: const TextStyle(color: Color(0xffcccccc)),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),

                      RichText(
                        text: TextSpan(
                          style: const TextStyle(fontSize: 12),
                          children: [
                            const TextSpan(
                              text: 'Expiry Date: ',
                              style: TextStyle(color: Colors.grey),
                            ),
                            TextSpan(
                              text: '${payment.expireDate ?? "--"} ',
                              style: const TextStyle(color: Colors.white),
                            ),
                            TextSpan(
                              text: '(${payment.planDurationDays} Days)',
                              style: const TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),

                      Row(
                        children: [
                          const Icon(
                            Icons.verified,
                            size: 18,
                            color: Colors.green,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            'Status: ${payment.status ?? ""}',
                            style: const TextStyle(color: Colors.greenAccent),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            );
          } else if (state is PaymentsHistoryFailure) {
            return Center(
              child: Text(
                state.msg,
                style: const TextStyle(color: Colors.white),
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
