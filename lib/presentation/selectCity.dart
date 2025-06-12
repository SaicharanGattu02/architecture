import 'package:architect/utils/color_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../Components/CutomAppBar.dart';

class SelectCity extends StatefulWidget {
  @override
  State<SelectCity> createState() => _SelectCityState();
}

class _SelectCityState extends State<SelectCity> {
  final List<String> cities = [
    'Hyderabad',
    'Warangal',
    'Nizamabad',
    'Pune',
    'Karimnagar',
    'Khammam',
    'Nalgonda',
    'Mahbubnagar',
    'Mancherial',
    'Siddipet',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primarycolor,
      appBar: CustomAppBar1(title: 'Select City', actions: []),
      body: ListView.builder(
        itemCount: cities.length,
        itemBuilder: (context, index) {
          return Container(
            decoration: BoxDecoration(
              color: Colors.grey[800],
              borderRadius: BorderRadius.circular(16),
            ),
            margin: EdgeInsets.symmetric(vertical: 6, horizontal: 16),
            child: ListTile(
              contentPadding: EdgeInsets.symmetric(
                horizontal: 24,

              ),
              title: Text(
                cities[index],
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              trailing: Icon(Icons.arrow_forward_ios, color: Colors.white,size: 20,),

              onTap: () {
                context.push('/select_type');
              },
            ),
          );
        },
      ),
    );
  }
}
