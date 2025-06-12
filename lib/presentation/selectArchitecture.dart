import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_touch_ripple/flutter_touch_ripple.dart';
import 'package:go_router/go_router.dart';

class SelectArchitecture extends StatefulWidget {
   SelectArchitecture({Key? key}) : super(key: key);

  @override
  State<SelectArchitecture> createState() => _SelectArchitectureScreenState();
}

class _SelectArchitectureScreenState extends State<SelectArchitecture> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: const BackButton(color: Colors.white),
        centerTitle: true,
        title: const Text('Select Architecture'),
      ),
      body: ListView.builder(
        shrinkWrap: true,
        padding: const EdgeInsets.only(top: 16, bottom: 24),
        itemCount: 5,
        itemBuilder: (context, index) {
          return TouchRipple(onTap: (){
            context.push('/architecture_details');
          },
            child: Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Sarah Johnson',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Modern Spaces Architecture',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                      height: 1.2,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.yellow, size: 16),
                      const SizedBox(width: 4),
                      Text('4.9', style: const TextStyle(fontSize: 14)),
                      const SizedBox(width: 16),
                      const Icon(
                        Icons.apartment,
                        color: Colors.white70,
                        size: 16,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        'Est.${2015}',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                          height: 1.2,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on,
                        color: Colors.white70,
                        size: 16,
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          'Hyderabad, India',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 14,
                            height: 1.2,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
