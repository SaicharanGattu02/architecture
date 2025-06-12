import 'package:architect/Components/CustomAppButton.dart';
import 'package:architect/Components/CutomAppBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CompanyDetails extends StatefulWidget {
  const CompanyDetails({Key? key}) : super(key: key);

  @override
  _CompanyDetailsState createState() => _CompanyDetailsState();
}

class _CompanyDetailsState extends State<CompanyDetails> {
  final _companyController = TextEditingController();
  final _contactController = TextEditingController();
  final _locationController = TextEditingController();
  final _addressController = TextEditingController();
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _companyController.dispose();
    _contactController.dispose();
    _locationController.dispose();
    _addressController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  Widget _buildTextField({
    required String label,
    required String hint,
    required TextEditingController controller,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 6),
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(color: Colors.white38),
            filled: true,
            fillColor: Colors.grey[850],
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.black,
      appBar: CustomAppBar1(title: 'Company Details', actions: []),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Column(
          children: [
            _buildTextField(
              label: 'Company Name',
              hint: 'Enter company name',
              controller: _companyController,
            ),
            const SizedBox(height: 16),
            _buildTextField(
              label: 'Contact Number',
              hint: 'Enter contact number',
              controller: _contactController,
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 16),
            _buildTextField(
              label: 'Location Preference',
              hint: 'Select location',
              controller: _locationController,
            ),
            const SizedBox(height: 16),
            _buildTextField(
              label: 'Address',
              hint: 'Enter address',
              controller: _addressController,
            ),
            const SizedBox(height: 16),
            _buildTextField(
              label: 'Email',
              hint: 'Enter email',
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 16),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Logo',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(height: 6),

            // DottedBorder(
            //   color: Colors.white54,
            //   strokeWidth: 1,
            //   dashPattern: const [6, 3],
            //   borderType: BorderType.RRect,
            //   radius: const Radius.circular(12),
            //   child: Container(
            //     width: double.infinity,
            //     height: 60,
            //     alignment: Alignment.center,
            //     child: Row(
            //       mainAxisSize: MainAxisSize.min,
            //       children: const [
            //         Icon(Icons.upload_file, color: Colors.white54),
            //         SizedBox(width: 8),
            //         Text(
            //           'Upload logo',
            //           style: TextStyle(color: Colors.white54, fontSize: 14),
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: CustomAppButton1(
              text: 'Submit', onPlusTap: () {
                context.push('/add_project');
          }),
        ),
      ),
    );
  }
}
