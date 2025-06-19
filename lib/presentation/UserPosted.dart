import 'package:architect/Components/CutomAppBar.dart';
import 'package:architect/utils/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:icons_plus/icons_plus.dart';

class UserPosted extends StatefulWidget {
  const UserPosted({super.key});

  @override
  State<UserPosted> createState() => _UserPostedState();
}

class _UserPostedState extends State<UserPosted> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primarycolor,
      appBar: CustomAppBar1(title: 'UserPosted', actions: []),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Posted Requirements',
              style: TextStyle(
                color: Color(0xff808080),
                fontSize: 20,
                fontWeight: FontWeight.w700,
                fontFamily: 'Inter',
              ),
            ),
            SingleChildScrollView(
              child: ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: 2,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      context.push('/user_posted_details');
                    },
                    child: Container(
                      margin: EdgeInsets.only(bottom: 12),
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Color(0xff191919),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        spacing: 8,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Sarah Johnson',
                                style: TextStyle(
                                  color: Color(0xffFAFAFA),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'Inter',
                                ),
                              ),
                              Text(
                                'In 1- 2 Months',
                                style: TextStyle(
                                  color: Color(0xffFAFAFA).withOpacity(0.8),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'Inter',
                                ),
                              ),
                            ],
                          ),

                          Text(
                            'Land details typically include information about ownership, boundaries, area, and usage.....',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Color(0xffA3A2A2),
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                              fontFamily: 'Inter',
                            ),
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.email,
                                    size: 16,
                                    color: Color(0xff888787),
                                  ),
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
                                ],
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.phone,
                                    size: 16,
                                    color: Color(0xff888787),
                                  ),
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
                            ],
                          ),
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
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
