import 'package:animate_do/animate_do.dart';
import 'package:architect/services/SecureStorageService.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';

import '../services/AuthService.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    _initialize();
  }

  Future<void> _initialize() async {
    final token = await AuthService.getAccessToken();
    bool? subscriber = await SecureStorageService.instance.getBool(
      'subscriber',
    );
    int? companyId = await SecureStorageService.instance.getInt('companyId');
    Future.delayed(Duration(seconds: 4), () {
      if (token == null || token.isEmpty) {
        context.pushReplacement('/onboarding');
      } else if (subscriber == true) {
        context.pushReplacement('/user_posts');
      } else {
        context.go('/subscription?id=${companyId}&type=${"New"}');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Lottie animation with zoomIn
              ZoomIn(
                duration: const Duration(milliseconds: 1600),
                child: Lottie.asset(
                  'assets/lottie/building.json',
                  width: 350,
                  height: 350,
                ),
              ),

              const SizedBox(height: 16),

              BounceInDown(
                duration: const Duration(milliseconds: 1400),
                child: Text(
                  'Arkitek',
                  style: const TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                    fontFamily: 'general_sans',
                    color: Colors.white,
                  ),
                ),
              ),

              const SizedBox(height: 6),

              // FadeIn Divider
              FadeIn(
                duration: const Duration(milliseconds: 1000),
                child: Container(height: 2, width: 60, color: Colors.white30),
              ),

              const SizedBox(height: 12),

              // Tagline with slideInUp
              SlideInUp(
                duration: const Duration(milliseconds: 1000),
                child: const Text(
                  'Architecting the Future',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white70,
                    fontFamily: 'general_sans',
                    letterSpacing: 1.2,
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
