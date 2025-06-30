import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../bloc/internet_status/internet_status_bloc.dart';
import 'Components/CustomAppButton.dart';

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
      body: BlocListener<InternetStatusBloc, InternetStatusState>(
        listener: (context, state) {
          if (state is InternetStatusLostState) {
            context.push('/no_internet');
          } else if (state is InternetStatusBackState) {
            context.pop();
          }
        },
        child: Column(
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
                      context.push('/select_city');
                    },
                  ),
                  CustomAppButton(
                    textcolor: Colors.white,
                    color: Color(0xff363636),
                    text: 'Post Your Requirement',
                    onPlusTap: () {
                      context.push('/post_your_requirement');
                    },
                  ),

                  SizedBox(height: 20),
                  TextButton(
                    onPressed: () {
                      context.push('/login');
                    },
                    child: Text(
                      'Are you an architect? Login',
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
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
