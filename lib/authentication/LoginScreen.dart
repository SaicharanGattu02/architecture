import 'package:architect/Components/CustomAppButton.dart';
import 'package:architect/utils/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../bloc/login/login_cubit.dart';
import '../bloc/login/login_state.dart';
import '../utils/Validator.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final Validator _validator = Validator();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      final data = {
        'email': _emailController.text.trim(),
      };
      context.read<LoginCubit>().loginApi(data);
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
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    controller: _emailController,
                    style: TextStyle(

                    ),
                    decoration: const InputDecoration(
                      hintText: 'Enter email',
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: _validator.validateEmail,
                  ),
                  const SizedBox(height: 24),
                  BlocConsumer<LoginCubit, LoginState>(
                    listener: (context, state) {
                      if (state is LoginSucess) {
                        context.pushReplacement("/");
                      }
                    },
                    builder: (context, state) {
                      return CustomAppButton1(
                        isLoading: state is LoginLoading,
                        text: 'Get OTP',
                        onPlusTap: _submitForm,
                      );
                    },
                  ),
                  TextButton(
                    onPressed: () {
                      context.push('/company_details');
                    },
                    child: const Text(
                      'Don’t have an account? Register',
                      style: TextStyle(color: Colors.white),
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
}
