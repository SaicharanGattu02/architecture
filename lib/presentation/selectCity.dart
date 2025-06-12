import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context); // Navigate back on pressing arrow
          },
        ),
        title: Text('Select City', style: TextStyle(color: Colors.white)),
      ),
      body: ListView.builder(
        itemCount: cities.length,
        itemBuilder: (context, index) {
          return ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            title: Text(
              cities[index],
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
            trailing: Icon(Icons.arrow_forward_ios, color: Colors.white),
            tileColor: Colors.grey[800],
            onTap: () {
              context.push('/select_type');
            },
          );
        },
      ),
    );
  }
}
