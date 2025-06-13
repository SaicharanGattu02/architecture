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
  final _validator = Validator();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      final data = {
        'email': _emailController.text.trim(),
        'password': _passwordController.text.trim(),
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
                mainAxisAlignment: MainAxisAlignment
                    .center, // center vertically inside scroll view
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Remove these SizedBoxes or reduce if needed
                  // const SizedBox(height: 20),
                  // const SizedBox(height: 24),
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      hintText: 'Enter email',
                      hintStyle: TextStyle(color: Colors.grey[500]),
                      filled: true,
                      fillColor: Colors.grey[800],
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 14,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: _validator.validateEmail,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 14,
                      ),
                      filled: true,
                      fillColor: Colors.grey[800],
                      hintText: 'Enter password',
                      hintStyle: TextStyle(color: Colors.grey[500]),
                      prefixIcon: const Icon(Icons.lock),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscurePassword
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscurePassword = !_obscurePassword;
                          });
                        },
                      ),
                    ),
                    obscureText: _obscurePassword,
                    validator: _validator.validatePassword,
                  ),
                  const SizedBox(height: 16),
                  Center(
                    child: TextButton(
                      onPressed: () {
                        context.push('/company_details');
                      },
                      child: const Text(
                        'Don’t have an account? Register',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),

      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: BlocConsumer<LoginCubit, LoginState>(
            listener: (context, state) {
              if (state is LoginSucess) {
                context.pushReplacement("/");
              }
            },
            builder: (context, state) {
              return CustomAppButton1(
                isLoading: state is LoginLoading,
                text: 'Login',
                onPlusTap: _submitForm,
              );
            },
          ),
        ),
      ),
    );
  }
}
