import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Components/CutomAppBar.dart';

class Subscription extends StatefulWidget {
  const Subscription({Key? key}) : super(key: key);

  @override
  _SubscriptionScreenState createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends State<Subscription> {
  bool _selected = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar:CustomAppBar1(title: 'Subscription', actions: []),
      body: Column(
        children: [
          SizedBox(height: 16),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey[850],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('Basic', style: TextStyle(fontFamily: 'Inter', fontSize: 16, fontWeight: FontWeight.w600)),
                const SizedBox(height: 8),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text('200', style: TextStyle(fontFamily: 'Inter', fontSize: 32, fontWeight: FontWeight.w700)),
                    Text('/month', style: TextStyle(fontFamily: 'Inter', fontSize: 14, color: Colors.white70)),
                  ],
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: _selected ? Colors.white : Colors.white38),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    onPressed: () => setState(() => _selected = !_selected),
                    child: Text(
                      _selected ? 'Selected' : 'Select',
                      style: TextStyle(fontFamily: 'Inter', color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    _FeatureRow('Access to basic features'),
                    _FeatureRow('Limited projects'),
                    _FeatureRow('Community support'),
                  ],
                ),
              ],
            ),
          ),
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
                onPressed: _selected ? () {
                  // TODO: Continue
                } : null,
                child: Text('Continue', style: TextStyle(fontFamily: 'Inter', color: Colors.black, fontSize: 16)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _FeatureRow extends StatelessWidget {
  final String text;
  const _FeatureRow(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          const Icon(Icons.check, size: 16, color: Colors.white),
          const SizedBox(width: 8),
          Expanded(child: Text(text, style: TextStyle(fontFamily: 'Inter', color: Colors.white70))),
        ],
      ),
    );
  }
}