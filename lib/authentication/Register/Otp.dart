import 'dart:io';

import 'package:architect/utils/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../../Components/CustomAppButton.dart';
import '../../services/AuthService.dart';
import '../../utils/Preferances.dart';
import '../../utils/media_query_helper.dart';

class Otp extends StatefulWidget {
  String mailId;
  Otp({super.key, required this.mailId});
  @override
  State<Otp> createState() => _OtpState();
}

class _OtpState extends State<Otp> {
  final TextEditingController _otpController = TextEditingController();
  final FocusNode _otpFocusNode = FocusNode();

  bool _isOtpValid = false;
  String fbToken = "";

  @override
  void initState() {
    super.initState();
  }

  String? _validateOtp(String otp) {
    if (otp.length < 6) {
      return 'Please enter a 6-digit OTP';
    }
    if (!RegExp(r'^\d{6}$').hasMatch(otp)) {
      return 'OTP must contain only digits';
    }
    return null;
  }

  void _onOtpChanged(String otp) {
    bool isValid = _validateOtp(otp) == null;
    if (isValid) {
      _otpFocusNode.unfocus();
    }
    setState(() {
      _isOtpValid = isValid;
    });
  }

  void _verifyOtp() {
    Map<String, dynamic> data = {
      "mail": widget.mailId,
      "otp": _otpController.text,
      if (Platform.isAndroid) ...{
        "token_type": "android_token",
        "fcm_token": fbToken,
      } else ...{
        "token_type": " ios_token",
        "fcm_token": fbToken,
      },
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primarycolor,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // SizedBox(height: SizeConfig.screenHeight * 0.1),
            Text(
              'OTP Verification',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontFamily: 'Inter',
                fontSize: 20,
              ),
            ),
            SizedBox(height: 16),
            RichText(
              text: TextSpan(
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Inter',
                ),
                children: [
                  TextSpan(
                    text:
                        'Enter the 6-digit code sent to your registered Mail Id ',
                    style: TextStyle(
                      fontWeight: FontWeight.w300,
                      color: Color(0xff898989),
                      fontSize: 14,
                    ),
                  ),
                  TextSpan(
                    text: '${widget.mailId}',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                  WidgetSpan(
                    alignment: PlaceholderAlignment.middle,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 4),
                      child: IconButton(
                        onPressed: () {
                          context.pushReplacement(
                            '/login_mobile',
                            extra: widget.mailId,
                          );
                        },
                        icon: Image.asset("assets/edit1.png", scale: 35),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            PinCodeTextField(
              autoUnfocus: true,
              appContext: context,
              pastedTextStyle: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
              length: 6,
              blinkWhenObscuring: true,
              autoFocus: true,
              autoDismissKeyboard: false,
              showCursor: true,
              animationType: AnimationType.fade,
              focusNode: _otpFocusNode,
              hapticFeedbackTypes: HapticFeedbackTypes.heavy,
              controller: _otpController,
              onTap: () {},
              onChanged: _onOtpChanged,
              pinTheme: PinTheme(
                shape: PinCodeFieldShape.box,
                borderRadius: BorderRadius.circular(5),
                fieldHeight: 48,
                fieldWidth: 48,
                fieldOuterPadding: EdgeInsets.only(left: 0, right: 3),
                activeFillColor: Color(0xFF636363),
                activeColor: Color(0xFF636363),
                selectedColor: Color(0xFF636363),
                selectedFillColor: Color(0xFFF4F4F4),
                inactiveFillColor: Color(0xFFF4F4F4),
                inactiveColor: Color(0xFFD2D2D2),
                inactiveBorderWidth: 1,
                selectedBorderWidth: 1.5,
                activeBorderWidth: 1.5,
              ),
              textStyle: TextStyle(
                fontFamily: "Inter",
                fontSize: 17,
                fontWeight: FontWeight.w400,
              ),
              cursorColor: Colors.white,
              enableActiveFill: true,
              keyboardType: TextInputType.numberWithOptions(),
              textInputAction: (Platform.isAndroid)
                  ? TextInputAction.none
                  : TextInputAction.done,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly,
              ],
              enablePinAutofill: true,
              useExternalAutoFillGroup: true,
              beforeTextPaste: (text) {
                return true;
              },
            ),
            SizedBox(height: 24),
            CustomAppButton1(text: 'Log-In', onPlusTap: () {}),
          ],
        ),
      ),
    );
  }
}
