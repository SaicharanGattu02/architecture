import 'package:flutter/material.dart';

import '../Components/CutomAppBar.dart';
import '../utils/color_constants.dart';

class UserPostedDetails extends StatefulWidget {
  const UserPostedDetails({super.key});

  @override
  State<UserPostedDetails> createState() => _UserPostedDetailsState();
}

class _UserPostedDetailsState extends State<UserPostedDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primarycolor,
      appBar: CustomAppBar1(title: 'Detail', actions: []),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(bottom: 12),
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Color(0xff191919),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Sarah Johnson',
                  style: TextStyle(
                    color: Color(0xffDDDDDD),
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Inter',
                  ),
                ),
                SizedBox(height: 16),
                Row(
                  children: [
                    Icon(
                      Icons.location_pin,
                      size: 16,
                      color: Color(0xff888787),
                    ),
                    SizedBox(width: 4),
                    Text(
                      'Hyderabad, India',
                      style: TextStyle(
                        color: Color(0xff888787),
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Inter',
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 13),
                Row(
                  children: [
                    Icon(Icons.email, size: 16, color: Color(0xff888787)),
                    SizedBox(width: 4),
                    Text(
                      'Charan@gmail.com',
                      style: TextStyle(
                        color: Color(0xff888787),
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Inter',
                      ),
                    ),
                    SizedBox(width: 12),
                    Icon(Icons.phone, size: 16, color: Color(0xff888787)),
                    SizedBox(width: 4),
                    Text(
                      '7674952516',
                      style: TextStyle(
                        color: Color(0xff888787),
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Inter',
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Text(
                  'Land details',
                  style: TextStyle(
                    color: Color(0xffDDDDDD),
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Inter',
                  ),
                ),
                SizedBox(height: 12),
                Text(
                  "Land details typically include information about ownership, boundaries, area, and usage. Key documents like the Record of Rights (ROR) and title deed provide vital information about ownership, while survey maps and property tax receipts further clarify the land's physical characteristics and legal standing",
                  style: TextStyle(
                    color: Color(0xffA3A2A2),
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Inter',
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  'Time Frame',
                  style: TextStyle(
                    color: Color(0xffDDDDDD),
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Inter',
                  ),
                ),
                SizedBox(height: 12),
                Text(
                  'In 1- 2 Months',
                  style: TextStyle(
                    color: Color(0xffFAFAFA).withOpacity(0.8),
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Inter',
                  ),
                ),
                SizedBox(height: 16),
                Align(
                  alignment: Alignment.topRight,
                  child: Text(
                    '~ 2day’s ago',
                    style: TextStyle(
                      color: Color(0xff808080),
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Inter',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
