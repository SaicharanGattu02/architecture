import 'package:architect/utils/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:icons_plus/icons_plus.dart';
import '../../../bloc/SubscriptionPlans/subscription_cubit.dart';
import '../../../bloc/SubscriptionPlans/subscription_state.dart';
import '../../Components/CustomAppButton.dart';
import '../../Components/CutomAppBar.dart';

class Subscription extends StatefulWidget {
  final int id;
  final String type;
  const Subscription({Key? key, required this.id, required this.type})
    : super(key: key);

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
    if (widget.type == "New") {
      context.read<SubscriptionCubit>().getsubscriptionplans();
    } else {
      debugPrint("Fetching active subscription for ID: ${widget.id}");
      context.read<SubscriptionCubit>().getActiveSubscriptionPlan(widget.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SubscriptionCubit, SubscriptionState>(
      builder: (context, state) {
        if (state is SubscriptionLoading ||
            state is ActiveSubscriptionLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is SubscriptionLoaded) {
          final plans = state.subscriptionModel.data;
          return Scaffold(
            backgroundColor: primarycolor,
            appBar: CustomAppBar1(title: 'Subscription', actions: const []),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // if (widget.type == "New") ...[
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: Text(
                    '3 of 4',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: LinearProgressIndicator(
                    minHeight: 8,
                    value: 0.75,
                    backgroundColor: const Color(0xff4D4D4D),
                    valueColor: const AlwaysStoppedAnimation<Color>(
                      Colors.white,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                const SizedBox(height: 30),
                // ],
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
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
                                Text(
                                  '/${plan.duration} days',
                                  style: _subPriceStyle,
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            SizedBox(
                              width: double.infinity,
                              child: OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                  side: BorderSide(
                                    color: isSelected
                                        ? Colors.white
                                        : Colors.white38,
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
                  ),
                ),
              ],
            ),
            bottomNavigationBar: _selectedIndex != -1
                ? SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 20,
                      ),
                      child: CustomAppButton1(
                        text: 'Continue',
                        onPlusTap: () {
                          final selectedPlan = plans[_selectedIndex];
                          final Map<String, dynamic> data = {
                            "plan_id": selectedPlan.id,
                            "amount": selectedPlan.price,
                            "company_id": widget.id,
                          };
                          context.push('/payment', extra: data);
                        },
                      ),
                    ),
                  )
                : const SizedBox.shrink(),
          );
        } else if (state is ActiveSubscriptionLoaded) {
          final activePlans = state.activeSubscriptionModel.data;
          return Scaffold(
            backgroundColor: primarycolor,
            appBar: CustomAppBar1(title: 'Subscription', actions: []),
            body: Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: activePlans?.length == 0
                        ? const Center(
                            child: Text(
                              'No active subscriptions found',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                          )
                        : ListView.builder(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            itemCount: activePlans?.length ?? 0,
                            itemBuilder: (context, index) {
                              final activePlan = activePlans![index];
                              final isSelected = _selectedIndex == index;

                              return Container(
                                margin: const EdgeInsets.only(bottom: 16),
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: activePlan.planActive == true
                                        ? Colors.green
                                        : Colors.transparent,
                                    width: 2,
                                  ),
                                  color: Colors.grey[850],
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          activePlan.name ?? 'Unnamed Plan',
                                          style: _titleStyle,
                                        ),
                                        Spacer(),
                                        if (activePlan.planActive == true) ...[
                                          Text(
                                            'Active',
                                            style: TextStyle(
                                              fontFamily: 'Inter',
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.green,
                                            ),
                                          ),
                                        ],
                                      ],
                                    ),
                                    const SizedBox(height: 8),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          activePlan.price ?? '0',
                                          style: _priceStyle,
                                        ),
                                        const SizedBox(width: 4),
                                        Text(
                                          '/${activePlan.duration ?? 'N/A'} days',
                                          style: _subPriceStyle,
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 12),
                                    SizedBox(
                                      width: double.infinity,
                                      child: OutlinedButton(
                                        style: OutlinedButton.styleFrom(
                                          side: BorderSide(
                                            color: isSelected
                                                ? Colors.white
                                                : Colors.white38,
                                          ),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              8,
                                            ),
                                          ),
                                        ),
                                        onPressed: () {
                                          setState(
                                            () => _selectedIndex = index,
                                          );
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
                                    _FeatureRow(
                                      activePlan.description ??
                                          'No description',
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                  ),
                ],
              ),
            ),
            bottomNavigationBar: _selectedIndex != -1
                ? SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 20,
                      ),
                      child: CustomAppButton1(
                        text: 'Continue',
                        onPlusTap: () {
                          final selectedPlan = activePlans![_selectedIndex];
                          final Map<String, dynamic> data = {
                            "plan_id": selectedPlan.id ?? 0,
                            "amount": selectedPlan.price ?? "0",
                            "company_id": widget.id,
                          };
                          context.push('/payment?type=${widget.type}', extra: data);
                        },
                      ),
                    ),
                  )
                : const SizedBox.shrink(),
          );
        } else if (state is SubscriptionError) {
          return Scaffold(
            backgroundColor: primarycolor,
            appBar: CustomAppBar1(title: 'Subscription', actions: const []),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    state.message,
                    style: const TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  const SizedBox(height: 16),
                  if (state.message.contains('Token is not provided'))
                    ElevatedButton(
                      onPressed: () {
                        GoRouter.of(context).push('/login');
                      },
                      child: const Text('Go to Login'),
                    ),
                ],
              ),
            ),
          );
        }

        if (state is SubscriptionError) {
          return Center(
            child: Text(
              state.message,
              style: const TextStyle(color: Colors.white),
            ),
          );
        }

        return const SizedBox.shrink();
      },
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
              style: const TextStyle(
                fontFamily: 'Inter',
                color: Colors.white70,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
