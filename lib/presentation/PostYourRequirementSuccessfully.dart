import 'package:architect/utils/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import '../Components/CustomAppButton.dart';

class PostYourRequiremntSuccessfully extends StatefulWidget {
  const PostYourRequiremntSuccessfully({super.key});

  @override
  State<PostYourRequiremntSuccessfully> createState() =>
      _PostYourRequiremntSuccessfullyState();
}

class _PostYourRequiremntSuccessfullyState
    extends State<PostYourRequiremntSuccessfully> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primarycolor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Lottie.asset(
            'assets/lottie/successfully.json',
            height: 150,
            width: 150,
            repeat: true,
          ),
          const SizedBox(height: 24),
          Text(
            'Thank you! Your requirement has been sent to the best architects. You will get a call back shortly.',
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: CustomAppButton1(
            text: 'Done',
            onPlusTap: () {
              // context.pushReplacement('/post_your_requirement_success');
            },
          ),
        ),
      ),
    );
  }
}
