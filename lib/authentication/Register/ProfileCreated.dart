import 'package:architect/utils/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import '../../Components/CustomAppButton.dart';

class ProfileCreated extends StatefulWidget {
  const ProfileCreated({Key? key}) : super(key: key);

  @override
  State<ProfileCreated> createState() => _ProfileCreatedState();
}

class _ProfileCreatedState extends State<ProfileCreated> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primarycolor,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Lottie.asset(
                  'assets/lottie/successfully.json',
                  height: 150,
                  width: 150,
                  repeat: true,
                ),
                const SizedBox(height: 24),
                const Text(
                  'Profile Created Successfully!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Welcome to Arkitek.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 14,
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: CustomAppButton1(
            text: 'Go to Profile',
            onPlusTap: () {
              context.pushReplacement('/architech_profile');
            },
          ),
        ),
      ),
    );
  }
}
