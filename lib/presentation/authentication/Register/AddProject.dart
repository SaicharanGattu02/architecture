import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

import '../../Components/CustomAppButton.dart';
import '../../Components/CutomAppBar.dart';

class AddProject extends StatefulWidget {
  const AddProject({Key? key}) : super(key: key);

  @override
  _AddProjectScreenState createState() => _AddProjectScreenState();
}

class _AddProjectScreenState extends State<AddProject> {
  String? _selectedYear;

  final List<String> _years = List.generate(11, (i) => (2015 + i).toString());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: CustomAppBar1(title: 'Add Project', actions: []),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Gallery',
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 4),
            Text(
              'Add images of your project',
              style: TextStyle(fontSize: 14, color: Colors.white70),
            ),
            SizedBox(height: 12),

            // DottedBorder(
            //   color: Colors.white38,
            //   strokeWidth: 1,
            //   dashPattern: const [6, 3],
            //   borderType: BorderType.RRect,
            //   radius: const Radius.circular(12),
            //   child: Container(
            //     width: double.infinity,
            //     height: 150,
            //     alignment: Alignment.center,
            //     child: Column(
            //       mainAxisSize: MainAxisSize.min,
            //       children: [
            //         const Text(
            //           'Drag and drop images here',
            //           style: TextStyle(color: Colors.white70),
            //         ),
            //         const SizedBox(height: 4),
            //         const Text(
            //           'Or select files from your computer',
            //           style: TextStyle(color: Colors.white70),
            //         ),
            //         const SizedBox(height: 12),
            //         ElevatedButton(
            //           style: ElevatedButton.styleFrom(
            //             backgroundColor: Colors.white,
            //             shape: RoundedRectangleBorder(
            //               borderRadius: BorderRadius.circular(8),
            //             ),
            //           ),
            //           onPressed: () {
            //             // TODO: open file picker
            //           },
            //           child: const Text(
            //             'Select Files',
            //             style: TextStyle(color: Colors.black),
            //           ),
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
            const SizedBox(height: 24),

            Text(
              'Establishment Year',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.grey[850],
                borderRadius: BorderRadius.circular(12),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton2<String>(
                  isExpanded: true,
                  hint: Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Select year',
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  items: _years
                      .map(
                        (year) =>
                            DropdownMenuItem(value: year, child: Text(year)),
                      )
                      .toList(),
                  onChanged: (val) => setState(() => _selectedYear = val),

                  iconStyleData: IconStyleData(
                    icon: Icon(Icons.keyboard_arrow_down_sharp),
                    iconSize: 24,
                    iconEnabledColor: Colors.white,
                  ),
                  dropdownStyleData: DropdownStyleData(
                    maxHeight: 250,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  menuItemStyleData: const MenuItemStyleData(
                    height: 50,
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  ),
                ),
              ),
            ),

            const Spacer(),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: CustomAppButton1(
            text: 'Next',
            onPlusTap: () {
              context.push('/subscription');
            },
          ),
        ),
      ),
    );
  }
}
