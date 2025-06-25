import 'package:architect/utils/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../Components/CustomAppButton.dart';
import '../../Components/CutomAppBar.dart';

class Payment extends StatefulWidget {
  final Map<String, dynamic> data;
  const Payment({Key? key, required this.data}) : super(key: key);

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<Payment> {
  String? _method = 'Google Pay';
  bool _paymentDone = false;

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
          _buildOption('Google Pay'),
          _buildOption('Razor Pay'),
          _buildOption('Phone Pay'),

        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: CustomAppButton1(
            text: 'Continue',
            onPlusTap: _method == null
                ? null
                : () {
              setState(() {
                _paymentDone = true;
              });

              final updatedData = {
                ...widget.data,
                "payment_method": _method,
                "status": "completed",
              };
              Future.delayed(const Duration(seconds: 1), () {
                context.push('/architect_profile_setup', extra: updatedData);
              });
            },
          ),
        ),
      ),
    );
  }
}
