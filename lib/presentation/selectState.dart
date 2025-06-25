import 'package:architect/bloc/state/state_states.dart';
import 'package:architect/utils/color_constants.dart';
import 'package:flutter/cupertino.dart';
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
    context.read<StateCubit>().getState();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primarycolor, // Changed background to black
      body: BlocBuilder<StateCubit, StateStates>(
        builder: (context, state) {
          if (state is StateLoading) {
            return Center(
              child: CircularProgressIndicator(color: Colors.white),
            );
          } else if (state is StateLoaded) {

            return Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 40),
                  Center(
                    child: Image.asset(
                      'assets/india_map.png',
                      fit: BoxFit.contain,
                      height: 300,
                      color: Colors.white.withOpacity(0.9),
                      colorBlendMode: BlendMode.modulate,
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Enter Your State',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.5,
                    ),
                  ),
                  SizedBox(height: 12),
                  DropdownButtonHideUnderline(
                    child: DropdownButton2<String>(
                      isExpanded: true,
                      hint: Row(
                        children: [
                          Expanded(
                            child: Text(
                              'Select State',
                              style: TextStyle(
                                fontFamily: 'roboto_serif',
                                fontSize: 16,
                                color: Colors.grey.shade500,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      items:
                          state.statesList.map((e) {
                            return DropdownMenuItem<String>(
                              value: e.name,
                              child: Text(
                                e.name ?? '',
                                style: TextStyle(
                                  fontFamily: 'roboto_serif',
                                  fontSize: 15,
                                  color: Colors.white,
                                ),
                              ),
                            );
                          }).toList() ??
                          [],
                      value: _selectState,
                      onChanged: (String? value) {
                        setState(() {
                          _selectState = value;
                        });
                      },
                      buttonStyleData: ButtonStyleData(
                        padding: EdgeInsets.symmetric(
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
                      iconStyleData: IconStyleData(
                        icon: Icon(Icons.keyboard_arrow_down_rounded),
                        iconSize: 26,
                        iconEnabledColor: Colors.white70,
                      ),
                      dropdownStyleData: DropdownStyleData(offset: Offset(0, -6),
                        maxHeight: 200,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.grey.shade900,
                        ),
                      ),
                      menuItemStyleData: MenuItemStyleData(
                        height: 45,
                        padding: EdgeInsets.symmetric(horizontal: 20),
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
                  ),
                ],
              ),
            );
          } else {
            return Center(child: Text("Something went wrong"));
          }
        },
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
