
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileCreated extends StatefulWidget {
  const ProfileCreated({Key? key}) : super(key: key);

  @override
  State<ProfileCreated> createState() => _ProfileCreatedState();
}

class _ProfileCreatedState extends State<ProfileCreated> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: BackButton(color: Colors.white),
        centerTitle: true,
        title: Text('Profile', style: TextStyle(fontFamily: 'Inter')),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.check_circle, size: 96, color: Colors.green),
          const SizedBox(height: 24),
          Text(
            'Profile Created Successfully!',
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            'Welcome to Arkitek.',
            style: TextStyle(fontFamily: 'Inter', fontSize: 14, color: Colors.white70),
          ),
          const SizedBox(height: 48),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  shape: const StadiumBorder(),
                ),
                onPressed: () {
                  // TODO: Navigate to profile
                },
                child: Text('Go to Profile', style: TextStyle(fontFamily: 'Inter', color: Colors.black, fontSize: 16)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}