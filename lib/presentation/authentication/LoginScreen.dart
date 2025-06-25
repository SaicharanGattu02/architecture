import 'package:architect/utils/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../bloc/login/login_cubit.dart';
import '../../bloc/login/login_state.dart';
import '../../utils/ShakeWidget.dart';
import '../../utils/Validator.dart';
import '../Components/CustomAppButton.dart';
import '../Components/CustomSnackBar.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final Validator _validator = Validator();

  bool _showEmailError = false;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  bool _validateEmail() {
    return _validator.validateEmail(_emailController.text.trim()) == null;
  }

  Future<void> _submitForm() async {
    setState(() {
      _showEmailError = !_validateEmail();
    });

    if (_formKey.currentState!.validate() && !_showEmailError) {
      final data = {'company_email': _emailController.text.trim()};
      context.read<LoginOTPCubit>().logInOtpApi(data);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primarycolor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Form(
          key: _formKey,
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildTextField(
                    label: 'Contact Email',
                    hint: 'Enter company email',
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    showError: _showEmailError,
                    errorMessage: 'Please enter a valid email',
                    validate: () {
                      setState(() {
                        _showEmailError = !_validateEmail();
                      });
                    },
                  ),
                  const SizedBox(height: 4),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      '***OTP will be sent to above mail id',
                      style: TextStyle(
                        color: Color(0xff878686),
                        fontSize: 11,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  SizedBox(height: 24),
                  BlocConsumer<LoginOTPCubit, LoginOtpState>(
                    listener: (context, state) {
                      if (state is LoginOtpSucess) {
                        context.pushReplacement(
                          "/otp?mailId=${_emailController.text.trim()}&type=${"LogInVerify"}",
                        );
                      } else if (state is LoginOtpError) {
                        CustomSnackBar.show(context, "${state.message}");
                      }
                    },
                    builder: (context, state) {
                      return CustomAppButton1(
                        isLoading: state is LoginOtpLoading,
                        text: 'Get OTP',
                        onPlusTap: _submitForm,
                      );
                    },
                  ),
                  TextButton(
                    onPressed: () {
                      context.push('/company_details');
                    },
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Don’t have an account? Register',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required String hint,
    required TextEditingController controller,
    required bool showError,
    required String errorMessage,
    TextInputType keyboardType = TextInputType.text,
    required Function() validate,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Color(0xffD8D8D8),
            fontSize: 16,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          cursorColor: Colors.white,
          controller: controller,
          keyboardType: keyboardType,
          style: const TextStyle(color: Colors.white),
          decoration: const InputDecoration(
            hintText: 'Enter company email',
            hintStyle: TextStyle(color: Colors.white70),
          ),
          onTap: validate,
          onChanged: (_) => validate(),
        ),
        if (showError)
          Padding(
            padding: const EdgeInsets.only(top: 5),
            child: ShakeWidget(
              key: Key(errorMessage),
              duration: const Duration(milliseconds: 700),
              child: Text(
                errorMessage,
                style: const TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 12,
                  color: Colors.red,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
