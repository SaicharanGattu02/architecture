import 'package:architect/utils/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

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
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Back arrow and title
              Row(
                children: [
                  const Icon(Icons.arrow_back, color: Colors.white),
                  const SizedBox(width: 8),
                  const Text(
                    'Create Profile',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Step progress
              const Text('2 of 4', style: TextStyle(color: Colors.white)),
              const SizedBox(height: 4),
              LinearProgressIndicator(

                value: 0.5,
                color: Colors.white,
                backgroundColor: Colors.grey.shade800,
              ),
              const SizedBox(height: 30),

              // OTP verification title
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
                backgroundColor: Colors.black,
                appContext: context,
                length: 6,
                controller: otpController,
                autoFocus: true,
                animationType: AnimationType.fade,
                keyboardType: TextInputType.number,
                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.box,
                  borderRadius: BorderRadius.circular(8),
                  fieldHeight: 50,
                  fieldWidth: 40,
                  activeFillColor: Colors.white,
                  inactiveFillColor: Colors.white,
                  selectedFillColor: Colors.white,
                  activeColor: Colors.white,
                  inactiveColor: Colors.grey,
                  selectedColor: Colors.white,
                ),
                animationDuration: const Duration(milliseconds: 300),
                enableActiveFill: true,
                onChanged: (value) {},
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
