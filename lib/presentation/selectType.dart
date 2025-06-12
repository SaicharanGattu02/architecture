
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

enum PropertyType { residential, commercial, industrial }

class SelectType extends StatefulWidget {
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
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Icon(icon, size: 36, color: Colors.white),
                ),
              ),
              if (isSelected)
                Positioned(
                  top: -4,
                  right: -4,
                  child: Icon(Icons.check_circle, color: Colors.white, size: 20),
                ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(color: Colors.white),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: BackButton(color: Colors.white),
        centerTitle: true,
        title: Text('Select Type', style: TextStyle(color: Colors.white)),
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 40),
            // Row of selectable cards
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildTypeCard(PropertyType.residential, Icons.home, 'Residential'),
                _buildTypeCard(PropertyType.commercial, Icons.business, 'Commercial'),
                _buildTypeCard(PropertyType.industrial, Icons.factory, 'Industrial'),
              ],
            ),
            Spacer(),
            // Only show button once something is selected
            if (_selectedType != null)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                child: SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: StadiumBorder(),
                    ),
                    child: Text(
                      'Find Architects',
                      style: TextStyle(color: Colors.black, fontSize: 16),
                    ),
                    onPressed: () {
                     context.push('/select_architecture');
                    },
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}