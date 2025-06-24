import 'package:architect/Components/CustomAppButton.dart';
import 'package:architect/Components/CustomSnackBar.dart';
import 'package:architect/bloc/CreateProfile/create_profile_cubit.dart';
import 'package:architect/bloc/CreateProfile/create_profile_state.dart';
import 'package:architect/bloc/login/login_cubit.dart';
import 'package:architect/bloc/login/login_state.dart';
import 'package:architect/utils/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../Components/CutomAppBar.dart';
import '../../Components/ShakeWidget.dart';
import '../../bloc/login/login_state.dart';
import '../../services/AuthService.dart';

class Otp extends StatefulWidget {
  final String mailId;
  final String type;
  const Otp({Key? key, required this.mailId, required this.type})
    : super(key: key);
  @override
  State<Otp> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<Otp> {
  TextEditingController otpController = TextEditingController();
  int countdown = 30;
  bool _showOtpError = false;

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

  void _onVerifyTap() {
    final String otp = otpController.text.trim();
    setState(() {
      _showOtpError = otp.length != 6 || !RegExp(r'^\d{6}$').hasMatch(otp);
    });

    if (!_showOtpError) {
      final Map<String, dynamic> data = {
        "company_email": widget.mailId,
        "otp": otp.toString(),
      };
      if (widget.type == "LogInVerify") {
        context.read<LoginOTPCubit>().logInVerifyOtpApi(data);
      } else {
        context.read<CreateProfileCubit>().createProfileVerifyOtpApi(data);
      }
    }
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
              const Text(
                '2 of 4',
                style: TextStyle(
                  fontFamily: 'Inter',
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
              ),
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

              Text(
                'Enter the 6-digit code sent to your registered\nMail id ${widget.mailId}',
                style: const TextStyle(color: Colors.grey, fontSize: 14),
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
                onChanged: (_) {
                  setState(() {
                    _showOtpError = false;
                  });
                },
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

              if (_showOtpError)
                Padding(
                  padding: const EdgeInsets.only(top: 6),
                  child: ShakeWidget(
                    key: const Key('otp_error'),
                    duration: const Duration(milliseconds: 700),
                    child: const Text(
                      'Please enter a valid 6-digit OTP',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 12,
                        color: Colors.redAccent,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
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
              _buildBlocConsumer(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBlocConsumer() {
    if (widget.type == "LogInVerify") {
      return BlocConsumer<LoginOTPCubit, LoginOtpState>(
        listener: (context, state) async {
          if (state is LoginVerifyOtpSucess) {
            final int currentTimestamp =
                DateTime.now().millisecondsSinceEpoch ~/ 1000;
            final int expiryTimestamp =
                currentTimestamp + (state.successModel.expiresIn ?? 0);

            await AuthService.saveTokens(
              state.successModel.accessToken ?? "",
               "",
              expiryTimestamp,
            );
            context.pushReplacement('/user_posts');
          } else if (state is LoginOtpError) {
            CustomSnackBar.show(context, state.message);
          } else if (state is LoginOtpError) {
            CustomSnackBar.show(context, state.message);
          }
        },
        builder: (context, state) {
          return CustomAppButton1(
            text: "Verify Otp",
            isLoading: state is LoginVerifyOtpLoading,
            onPlusTap: _onVerifyTap,
          );
        },
      );
    } else {
      return BlocConsumer<CreateProfileCubit, CreateProfileState>(
        listener: (context, state) {
          if (state is CreateProfileVerifyOTPSucess) {
            context.pushReplacement(
              '/subscription?id=${state.successModel.companyId}',
            );
          } else if (state is CreateProfileError) {
            CustomSnackBar.show(context, state.message);
          }
        },
        builder: (context, state) {
          return CustomAppButton1(
            text: "Verify & View Plans",
            isLoading: state is CreateProfileVerifyOtpLoading,
            onPlusTap: _onVerifyTap,
          );
        },
      );
    }
  }
}
