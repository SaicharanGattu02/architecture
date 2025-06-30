import 'package:architect/presentation/Components/CutomAppBar.dart';
import 'package:flutter/material.dart';
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
    // context.read<PaymentHistoryCubit>().getPaymentHistory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primarycolor,
      appBar: CustomAppBar1(title: 'Payments History', actions: []),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ListView.builder(
              itemCount: 1,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    spacing: 10,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Active',
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Color(0xffD5D5D5),
                            ),
                          ),
                          Text(
                            '12 may 25',
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: Color(0xffFAFAFACC).withOpacity(0.8),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        '₹ 1,500',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Color(0xffFAFAFA),
                        ),
                      ),

                      RichText(
                        text: TextSpan(
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                          children: [
                            TextSpan(
                              text: 'Expiry Date ',
                              style: TextStyle(color: Color(0xFF808080)),
                            ),
                            TextSpan(
                              text: '19 Jun 25 ',
                              style: TextStyle(color: Color(0xFFFAFAFA)),
                            ),
                            TextSpan(
                              text: '(1 Month)',
                              style: TextStyle(color: Color(0xFF808080)),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        'Transaction Id 1234564',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff808080),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
