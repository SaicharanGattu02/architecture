import 'package:architect/utils/color_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

class EnterState extends StatefulWidget {
  @override
  State<EnterState> createState() => _EnterStateScreenState();
}

class _EnterStateScreenState extends State<EnterState> {
  String? _selectState;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primarycolor, // Changed background to black
      body: Container(
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
                    [
                          "Andhra Pradesh",
                          "Arunachal Pradesh",
                          "Assam",
                          "Bihar",
                          "Chhattisgarh",
                          "Goa",
                          "Gujarat",
                          "Haryana",
                          "Himachal Pradesh",
                          "Jharkhand",
                          "Karnataka",
                          "Kerala",
                          "Madhya Pradesh",
                          "Maharashtra",
                          "Manipur",
                          "Meghalaya",
                          "Mizoram",
                          "Nagaland",
                          "Odisha",
                          "Punjab",
                          "Rajasthan",
                          "Sikkim",
                          "Tamil Nadu",
                          "Telangana",
                          "Tripura",
                          "Uttar Pradesh",
                          "Uttarakhand",
                          "West Bengal",
                        ]
                        .map(
                          (e) => DropdownMenuItem<String>(
                            value: e,
                            child: Text(
                              e,
                              style: TextStyle(
                                fontFamily: 'roboto_serif',
                                fontSize: 15,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        )
                        .toList(),
                value: _selectState,
                onChanged: (String? value) {
                  setState(() {
                    _selectState = value;
                  });
                },
                buttonStyleData: ButtonStyleData(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey.shade800, width: 0.5),
                    color: Colors.grey.shade900,
                  ),
                ),
                iconStyleData: IconStyleData(
                  icon: Icon(Icons.keyboard_arrow_down_rounded),
                  iconSize: 26,
                  iconEnabledColor: Colors.white70,
                ),
                dropdownStyleData: DropdownStyleData(
                  maxHeight: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.grey.shade900,
                  ),
                ),
                menuItemStyleData: MenuItemStyleData(
                  height: 45,
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  overlayColor: MaterialStateProperty.resolveWith<Color?>((
                    Set<MaterialState> states,
                  ) {
                    if (states.contains(MaterialState.hovered)) {
                      return Colors.white.withOpacity(0.12);
                    }
                    if (states.contains(MaterialState.pressed)) {
                      return Colors.white.withOpacity(0.2);
                    }
                    return null;
                  }),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: SizedBox(
            width: double.infinity,
            height: 52,
            child: ElevatedButton(
              onPressed: _selectState == null
                  ? null
                  : () {
                      context.push('/select_city');
                    },
              style: ElevatedButton.styleFrom(
                backgroundColor: _selectState == null
                    ? Colors.grey.shade700
                    : Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                elevation: 0,
              ),
              child: Text(
                'Next',
                style: TextStyle(
                  color: _selectState == null
                      ? Colors.grey.shade400
                      : Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
