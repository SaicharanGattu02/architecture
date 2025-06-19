import 'package:architect/Components/CutomAppBar.dart';
import 'package:architect/utils/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ArchitechProfile extends StatefulWidget {
  const ArchitechProfile({super.key});

  @override
  State<ArchitechProfile> createState() => _ArchitechProfileState();
}

class _ArchitechProfileState extends State<ArchitechProfile> {
  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: primarycolor,
      appBar: CustomAppBar1(title: 'Profile', actions: []),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                color: Colors.grey[900],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                spacing: 16,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 100,
                        width: w * 0.25,
                        decoration: BoxDecoration(
                          color: Color(0xff010101),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: const Icon(
                          Icons.image,
                          size: 48,
                          color: Colors.white30,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Sarah Johnson',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 4),
                            const Text(
                              'Modern Spaces Architecture',
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 4,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.star,
                                        color: Colors.yellow,
                                        size: 16,
                                      ),
                                      SizedBox(width: 2),
                                      Text(
                                        '4.9',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                SizedBox(width: 16),
                                Icon(
                                  Icons.apartment,
                                  color: Colors.white70,
                                  size: 16,
                                ),
                                SizedBox(width: 4),
                                Text(
                                  'Est. 2015',
                                  style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: const [
                                Icon(
                                  Icons.location_on,
                                  color: Colors.white70,
                                  size: 16,
                                ),
                                SizedBox(width: 4),
                                Expanded(
                                  child: Text(
                                    'Hyderabad, India',
                                    style: TextStyle(
                                      color: Colors.white70,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: [
                        TextButton.icon(
                          onPressed: () {
                         context.push('/architecture_details');
                          },
                          icon: Icon(
                            Icons.remove_red_eye,
                            color: Colors.white,
                            size: 20,
                          ),
                          label: Text(
                            'View Profile',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 12,
                            ),
                          ),
                        ),
                        Spacer(),
                        TextButton.icon(
                          onPressed: () {
                            context.push('/architect_profile_setup');
                          },
                          icon: Icon(Icons.edit, color: Colors.white, size: 20),
                          label: Text(
                            'Edit Profile',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 32, vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    spacing: 12,
                    children: [
                      Container(
                        padding: EdgeInsets.all(26),
                        decoration: BoxDecoration(
                          color: Color(0xff363636),
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: Image.asset('assets/subscription.png', scale: 5),
                      ),
                      Text(
                        'Renew the plan',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Color(0xffCCCCCC),
                        ),
                      ),
                    ],
                  ),

                  Column(
                    spacing: 12,
                    children: [
                      Container(
                        padding: EdgeInsets.all(26),
                        decoration: BoxDecoration(
                          color: Color(0xff363636),
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: Image.asset('assets/logout.png', scale: 5),
                      ),
                      Text(
                        'Log Out',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Color(0xffCCCCCC),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
