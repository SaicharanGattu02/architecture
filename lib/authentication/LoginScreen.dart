import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';


import '../utils/color_constants.dart';
import '../utils/constants.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool obscurePassword = true;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF64171c), Color(0xFF64171c0f)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: size.width < 500 ? 24 : size.width * 0.2,
                vertical: size.height * 0.1,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.apartment, size: 60, color: Colors.white),
                  const SizedBox(height: 20),
                  const Text(
                    "Hotel Staff Portal",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontFamily: "roboto_serif",
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "Sign in to manage your hotel",
                    style: TextStyle(
                      color: Colors.white70,
                      fontFamily: "roboto_serif",
                    ),
                  ),
                   SizedBox(height: 30),
                  TextField(
                    controller: usernameController,
                    decoration:  InputDecorationUtils.inputDecoration(
                     "Username",'Enter user name',Icons.email,
                    ),
                  ),
                   SizedBox(height: 16),
                  TextField(
                    controller: passwordController,
                    obscureText: obscurePassword,
                    decoration: InputDecorationUtils.inputDecoration(
                      'Password',
                      'Enter password',
                      Icons.lock,
                      IconButton(
                        icon: Icon(
                          obscurePassword ? Icons.visibility_off : Icons.visibility,
                        ),
                        onPressed: () {
                          setState(() {
                            obscurePassword = !obscurePassword;
                          });
                        },
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),
                  const Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "Forgot Password?",
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 12,
                        fontFamily: "roboto_serif",
                      ),
                    ),
                  ),
                  SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primarycolor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                      onPressed: () {
                        context.push("/main");
                      },
                      child: const Text(
                        "Login",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: "roboto_serif",
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    "Demo credentials: staff / password",
                    style: TextStyle(
                      color: Colors.white60,
                      fontSize: 12,
                      fontFamily: "roboto_serif",
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
