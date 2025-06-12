import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Payment extends StatefulWidget {
  const Payment({Key? key}) : super(key: key);

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<Payment> {
  String? _method = 'Credit Card';

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
              child: Text(label, style: TextStyle(fontFamily: 'Inter', fontSize: 16)),
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
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: CloseButton(color: Colors.white),
        centerTitle: true,
        title: Text('Payment', style: TextStyle(fontFamily: 'Inter')),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text('2 of 3', style: TextStyle(fontFamily: 'Inter', color: Colors.white70)),
          ),
          const SizedBox(height: 4),
          LinearProgressIndicator(
            value: 2 / 3,
            backgroundColor: Colors.white24,
            color: Colors.white,
            minHeight: 4,
          ),
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'Select a payment method',
              style: TextStyle(fontFamily: 'Inter', fontSize: 18, fontWeight: FontWeight.w600),
            ),
          ),
          const SizedBox(height: 16),
          _buildOption('Credit Card'),
          _buildOption('Paypal'),
          _buildOption('Apple Pay'),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(16),
            child: SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  shape: const StadiumBorder(),
                ),
                onPressed: _method == null ? null : () {
                  // TODO: Continue action
                },
                child: Text('Continue', style: TextStyle(fontFamily: 'Inter', color: Colors.black, fontSize: 16)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
