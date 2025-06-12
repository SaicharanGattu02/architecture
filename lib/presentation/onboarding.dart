import 'package:architect/Components/CustomAppButton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Onboarding extends StatefulWidget {
  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            flex: 1,
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/onboarding_bg.png'),
                  fit: BoxFit.cover,
                  alignment: Alignment.center,
                  colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.7),
                    BlendMode.darken,
                  ),
                ),
              ),
            ),
          ),

          Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            child: Column(
              spacing: 20,
              children: [
                CustomAppButton(
                  color: Colors.white,
                  text: 'Find My Architect',
                  onPlusTap: () {
                    context.push('/enter_state');
                  },
                ),
                CustomAppButton(textcolor: Colors.white,
                  color: Color(0xff363636),
                  text: 'Post Your Requirement',
                  onPlusTap: () {

                  },
                ),

                SizedBox(height: 20),
                TextButton(
                  onPressed: () {
                    context.push('/company_details');
                  },
                  child: Text(
                    'Are you an architect? Register',
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
