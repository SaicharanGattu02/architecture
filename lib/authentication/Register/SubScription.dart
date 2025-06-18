import 'package:architect/utils/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../Components/CustomAppButton.dart';
import '../../Components/CutomAppBar.dart';
import '../../bloc/SubscriptionPlans/subscription_cubit.dart';
import '../../bloc/SubscriptionPlans/subscription_state.dart';

class Subscription extends StatefulWidget {
  const Subscription({Key? key}) : super(key: key);

  @override
  _SubscriptionScreenState createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends State<Subscription> {
  int _selectedIndex = -1;

  final _titleStyle = const TextStyle(
    fontFamily: 'Inter',
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );

  final _priceStyle = const TextStyle(
    fontFamily: 'Inter',
    fontSize: 32,
    fontWeight: FontWeight.w700,
    color: Colors.white,
  );

  final _subPriceStyle = const TextStyle(
    fontFamily: 'Inter',
    fontSize: 14,
    color: Colors.white70,
  );

  @override
  void initState() {
    super.initState();
    context.read<subscription_cubit>().getsubscriptionplans();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primarycolor,
      appBar: CustomAppBar1(title: 'Subscription', actions: []),
      body: BlocBuilder<subscription_cubit, subscription_state>(
        builder: (context, state) {
          if (state is subscriprionLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is subscriprionLoaded) {
            final plans = state.subscriptionModel.data;

            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: plans.length,
              itemBuilder: (context, index) {
                final plan = plans[index];
                final isSelected = _selectedIndex == index;

                return Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.grey[850],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(plan.name, style: _titleStyle),
                      const SizedBox(height: 8),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(plan.price, style: _priceStyle),
                          const SizedBox(width: 4),
                          Text('/${plan.duration} days', style: _subPriceStyle),
                        ],
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        width: double.infinity,
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(
                              color: isSelected ? Colors.white : Colors.white38,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          onPressed: () {
                            setState(() => _selectedIndex = index);
                          },
                          child: Text(
                            isSelected ? 'Selected' : 'Select',
                            style: const TextStyle(
                              fontFamily: 'Inter',
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      _FeatureRow(plan.description),
                    ],
                  ),
                );
              },
            );
          }

          if (state is subscriprionError) {
            return Center(
              child: Text(
                state.message,
                style: const TextStyle(color: Colors.white),
              ),
            );
          }

          return const SizedBox();
        },
      ),

      bottomNavigationBar: _selectedIndex != -1
          ? SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: CustomAppButton1(
            text: 'Continue',
            onPlusTap: () {
              context.push('/payment');
            },
          ),
        ),
      )
          : const SizedBox.shrink(),
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
          const Icon(Icons.check, size: 13, color: Colors.white),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontFamily: 'Inter', color: Colors.white70),
            ),
          ),
        ],
      ),
    );
  }
}
