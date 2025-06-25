import 'package:architect/bloc/state/state_states.dart';
import 'package:architect/utils/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

import '../bloc/state/state_cubit.dart';
import 'Components/CustomAppButton.dart';

class EnterState extends StatefulWidget {
  @override
  State<EnterState> createState() => _EnterStateScreenState();
}

class _EnterStateScreenState extends State<EnterState> {
  String? _selectState;

  @override
  void initState() {
    super.initState();
    context.read<StateCubit>().getState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primarycolor,
      appBar: AppBar(
        backgroundColor: const Color(0xff1A1A1A),
        centerTitle: true,
        leading: IconButton(
          visualDensity: VisualDensity.compact,
          onPressed: () {
            context.pop(true);
          },
          icon: const Icon(Icons.arrow_back, size: 24, color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.asset(
                'assets/india_map.png',
                fit: BoxFit.contain,
                height: 300,
                color: Colors.white.withOpacity(0.9),
                colorBlendMode: BlendMode.modulate,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Enter Your State',
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.5,
              ),
            ),
            const SizedBox(height: 12),
            BlocBuilder<StateCubit, StateStates>(
              builder: (context, state) {
                if (state is StateLoading) {
                  return const Center(
                    child: CircularProgressIndicator(color: Colors.white),
                  );
                } else if (state is StateLoaded) {
                  return DropdownButtonHideUnderline(
                    child: DropdownButton2<String>(
                      isExpanded: true,
                      hint: Row(
                        children: [
                          Expanded(
                            child: Text(
                              'Select State',
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 16,
                                color: Colors.grey.shade500,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      items: state.statesList.map((e) {
                        return DropdownMenuItem<String>(
                          value: e.name,
                          child: Text(
                            e.name ?? '',
                            style: const TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 15,
                              color: Colors.white,
                            ),
                          ),
                        );
                      }).toList(),
                      value: _selectState,
                      onChanged: (String? value) {
                        setState(() {
                          _selectState = value;
                        });
                      },
                      buttonStyleData: ButtonStyleData(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: Colors.grey.shade800,
                            width: 0.5,
                          ),
                          color: Colors.grey.shade900,
                        ),
                      ),
                      iconStyleData: const IconStyleData(
                        icon: Icon(Icons.keyboard_arrow_down_rounded),
                        iconSize: 26,
                        iconEnabledColor: Colors.white70,
                      ),
                      dropdownStyleData: DropdownStyleData(
                        offset: const Offset(0, -6),
                        maxHeight: 200,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.grey.shade900,
                        ),
                      ),
                      menuItemStyleData: MenuItemStyleData(
                        height: 45,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        overlayColor: MaterialStateProperty.resolveWith<Color?>(
                          (Set<MaterialState> states) {
                            if (states.contains(MaterialState.hovered)) {
                              return Colors.white.withOpacity(0.12);
                            }
                            if (states.contains(MaterialState.pressed)) {
                              return Colors.white.withOpacity(0.2);
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                  );
                } else {
                  return const Text(
                    'Failed to load states',
                    style: TextStyle(color: Colors.white70),
                  );
                }
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: CustomAppButton1(
            text: 'Next',
            onPlusTap: _selectState == null
                ? null
                : () {
                    context.push('/select_city?state=${_selectState}');
                  },
          ),
        ),
      ),
    );
  }
}
