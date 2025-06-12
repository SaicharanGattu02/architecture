import 'package:architect/utils/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  String userId = "";
  String Status = '';

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  Future<void> _initialize() async {
    // final token = await AuthService.getAccessToken();
    Future.delayed(Duration(seconds: 2), () {
      // if(token == null || token.isEmpty) {
      context.pushReplacement('/onboarding');
      // }else{
      //   context.pushReplacement('/assigned_hostels');
      // }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primarycolor,
      body: Center(
        child: Text(
          'Arkitek',
          style: TextStyle(fontSize: 22, color: Colors.white),
        ),
      ),
    );
  }
}
