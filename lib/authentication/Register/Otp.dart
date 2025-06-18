import 'package:architect/utils/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../Components/CutomAppBar.dart';

class Otp extends StatefulWidget {
  final String mailId;
  const Otp({Key? key, required this.mailId}) : super(key: key);
  @override
  State<Otp> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<Otp> {
  TextEditingController otpController = TextEditingController();
  int countdown = 30;

  @override
  void initState() {
    super.initState();
    startCountdown();
  }

  void startCountdown() {
    Future.delayed(const Duration(seconds: 1), () {
      if (countdown > 0) {
        setState(() {
          countdown--;
        });
        startCountdown();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primarycolor,
      appBar: CustomAppBar1(title: 'Create Profile', actions: []),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('2 of 4',  style: TextStyle(
                fontFamily: 'Inter',
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),),
              const SizedBox(height: 4),
              LinearProgressIndicator(
                minHeight: 8,
                value: 0.5,
                backgroundColor: const Color(0xff4D4D4D),
                valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
                borderRadius: BorderRadius.circular(8),
              ),
              const SizedBox(height: 30),

              const Text(
                'OTP verification',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),

              // Subtext
              const Text(
                'Enter the 6-digit code sent to your registered\nMail id Company@gmail.com',
                style: TextStyle(color: Colors.grey, fontSize: 14),
              ),
              const SizedBox(height: 20),
              PinCodeTextField(
                appContext: context,
                length: 6,
                controller: otpController,
                autoFocus: true,
                keyboardType: TextInputType.number,
                animationType: AnimationType.fade,
                animationDuration: const Duration(milliseconds: 300),
                backgroundColor: primarycolor,
                enableActiveFill: true,
                textStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: textPrimaryColor,
                  fontFamily: "Inter",
                  fontWeight: FontWeight.w400,
                ),
                onChanged: (value) {},
                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.box,
                  borderRadius: BorderRadius.circular(8),
                  fieldHeight: 50,
                  fieldWidth: 40,
                  activeColor: Colors.grey,
                  inactiveColor: Colors.grey,
                  selectedColor: Colors.white,
                  activeFillColor: Colors.grey,
                  inactiveFillColor: Colors.grey,
                  selectedFillColor: Colors.grey,
                ),
              ),

              const SizedBox(height: 10),

              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "Resend OTP in $countdown sec",
                    style: const TextStyle(color: Colors.grey, fontSize: 14),
                  ),
                ],
              ),
              const SizedBox(height: 30),

              // Verify button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  onPressed: () {
                    context.push('/subscription');
                  },

                  child: const Text(
                    "Verify & View Plans",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
