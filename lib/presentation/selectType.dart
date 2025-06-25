import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'Components/CustomAppButton.dart';
import 'Components/CutomAppBar.dart';

enum PropertyType { residential, commercial, industrial }

class SelectType extends StatefulWidget {
  final String city;

  const SelectType({Key? key, required this.city}) : super(key: key);

  @override
  _SelectTypeScreenState createState() => _SelectTypeScreenState();
}

class _SelectTypeScreenState extends State<SelectType> {
  PropertyType? _selectedType;

  Widget _buildTypeCard(PropertyType type, IconData icon, String label) {
    final bool isSelected = _selectedType == type;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: () => setState(() => _selectedType = type),
          child: Stack(
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.grey[850],
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Center(child: Icon(icon, size: 36, color: Colors.white)),
              ),
              if (isSelected)
                Positioned(
                  top: -4,
                  right: -4,
                  child: Icon(
                    Icons.check_circle,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Text(label, style: TextStyle(color: Colors.white)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: CustomAppBar1(title: 'Select Type', actions: []),
      body: Center(
        child: Container(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildTypeCard(
                    PropertyType.residential,
                    Icons.home,
                    'Residential',
                  ),
                  _buildTypeCard(
                    PropertyType.commercial,
                    Icons.business,
                    'Commercial',
                  ),
                  _buildTypeCard(
                    PropertyType.industrial,
                    Icons.factory,
                    'Industrial',
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _selectedType != null
          ? SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                child: CustomAppButton1(
                  text: 'Find Architects',
                  onPlusTap: () {
                    final industryType = _selectedType!.name;
                    context.push(
                      '/select_architecture?industryType=$industryType&location=$widget.city',
                    );
                  },
                ),
              ),
            )
          : SizedBox.shrink(),
    );
  }
}
