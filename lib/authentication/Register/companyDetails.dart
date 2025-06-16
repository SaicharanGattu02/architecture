import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import '../../Components/CustomAppButton.dart';
import '../../Components/CutomAppBar.dart';
import '../../Components/ShakeWidget.dart';
import 'dart:io';

class CompanyDetails extends StatefulWidget {
  const CompanyDetails({Key? key}) : super(key: key);

  @override
  _CompanyDetailsState createState() => _CompanyDetailsState();
}

class _CompanyDetailsState extends State<CompanyDetails> {
  final _companyController = TextEditingController();
  final _contactPersonController = TextEditingController();
  final _locationController = TextEditingController();
  final _addressController = TextEditingController();
  final _emailController = TextEditingController();
  final ImagePicker _picker = ImagePicker();

  String? _selectedYear;
  File? _logoImage;
  bool _showCompanyError = false;
  bool _showContactPersonError = false;
  bool _showLocationError = false;
  bool _showAddressError = false;
  bool _showEmailError = false;
  bool _showYearError = false;
  bool _showLogoError = false;

  @override
  void dispose() {
    _companyController.dispose();
    _contactPersonController.dispose();
    _locationController.dispose();
    _addressController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  bool _validateCompany() => _companyController.text.trim().isNotEmpty;
  bool _validateContactPerson() =>
      _contactPersonController.text.trim().isNotEmpty;
  bool _validateLocation() => _locationController.text.trim().isNotEmpty;
  bool _validateAddress() => _addressController.text.trim().isNotEmpty;
  bool _validateEmail() => RegExp(
    r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
  ).hasMatch(_emailController.text.trim());
  bool _validateYear() => _selectedYear != null;
  bool _validateLogo() => _logoImage != null;

  bool _validateForm() {
    setState(() {
      _showCompanyError = !_validateCompany();
      _showContactPersonError = !_validateContactPerson();
      _showLocationError = !_validateLocation();
      _showAddressError = !_validateAddress();
      _showEmailError = !_validateEmail();
      _showYearError = !_validateYear();
      _showLogoError = !_validateLogo();
    });

    return _validateCompany() &&
        _validateContactPerson() &&
        _validateLocation() &&
        _validateAddress() &&
        _validateEmail() &&
        _validateYear() &&
        _validateLogo();
  }

  Future<void> _pickImage(ImageSource source) async {
    try {
      final XFile? pickedFile = await _picker.pickImage(source: source);
      if (pickedFile != null) {
        setState(() {
          _logoImage = File(pickedFile.path);
          _showLogoError = !_validateLogo();
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error picking image: $e')));
    }
    context.pop(context);
  }

  void _showImageSourceSelection() {
    showModalBottomSheet(
      isDismissible: false,
      context: context,
      backgroundColor: const Color(0xff363636),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return SafeArea(
          child: Stack(
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 50),
                  ListTile(
                    leading: const Icon(
                      Icons.photo_library,
                      color: Colors.white,
                    ),
                    title: const Text(
                      'Choose from Gallery',
                      style: TextStyle(color: Colors.white),
                    ),
                    onTap: () => _pickImage(ImageSource.gallery),
                  ),
                  ListTile(
                    leading: const Icon(Icons.camera_alt, color: Colors.white),
                    title: const Text(
                      'Take Photo',
                      style: TextStyle(color: Colors.white),
                    ),
                    onTap: () => _pickImage(ImageSource.camera),
                  ),
                ],
              ),
              Positioned(
                top: 5,
                right: 10,
                child: IconButton.outlined(
                  visualDensity: VisualDensity.compact,
                  onPressed: () {
                    context.pop();
                  },
                  icon: const Icon(Icons.close, color: Colors.white, size: 18),
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all(CircleBorder()),
                    side: MaterialStateProperty.all(
                      BorderSide(color: Colors.white),
                    ),
                    // Optionally, you can adjust padding to make it more compact
                    padding: MaterialStateProperty.all(EdgeInsets.all(8)),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTextField({
    required String label,
    required String hint,
    required TextEditingController controller,
    required bool showError,
    required String errorMessage,
    TextInputType keyboardType = TextInputType.text,
    required Function() validate,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Color(0xffD8D8D8),
            fontSize: 16,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          cursorColor: Colors.white,
          controller: controller,
          keyboardType: keyboardType,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(hintText: hint),
          onTap: () {
            setState(() {
              validate();
            });
          },
          onChanged: (_) {
            setState(() {
              validate();
            });
          },
        ),
        if (showError)
          Padding(
            padding: const EdgeInsets.only(top: 5),
            child: ShakeWidget(
              key: Key(errorMessage),
              duration: const Duration(milliseconds: 700),
              child: Text(
                errorMessage,
                style: const TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 12,
                  color: Colors.red,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.black,
      appBar: CustomAppBar1(title: 'Create Profile', actions: []),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Text(
              '1 of 4',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 12),
            LinearProgressIndicator(
              minHeight: 8,
              value: 0.25,
              backgroundColor: const Color(0xff4D4D4D),
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
              borderRadius: BorderRadius.circular(4),
            ),
            const SizedBox(height: 16),
            _buildTextField(
              label: 'Company Name',
              hint: 'Enter company name',
              controller: _companyController,
              showError: _showCompanyError,
              errorMessage: 'Please enter a company name',
              validate: () => _showCompanyError = !_validateCompany(),
            ),
            const SizedBox(height: 16),
            _buildTextField(
              label: 'Contact Person Name',
              hint: 'Enter contact person name',
              controller: _contactPersonController,
              showError: _showContactPersonError,
              errorMessage: 'Please enter a contact person name',
              validate: () =>
                  _showContactPersonError = !_validateContactPerson(),
            ),
            const SizedBox(height: 16),
            _buildTextField(
              label: 'Contact Email',
              hint: 'Enter company email',
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              showError: _showEmailError,
              errorMessage: 'Please enter a valid email',
              validate: () => _showEmailError = !_validateEmail(),
            ),
            const SizedBox(height: 16),
            _buildTextField(
              label: 'Location',
              hint: 'Enter company location',
              controller: _locationController,
              showError: _showLocationError,
              errorMessage: 'Please enter a location',
              validate: () => _showLocationError = !_validateLocation(),
            ),
            const SizedBox(height: 16),
            _buildTextField(
              label: 'Address',
              hint: 'Enter company address',
              controller: _addressController,
              showError: _showAddressError,
              errorMessage: 'Please enter an address',
              validate: () => _showAddressError = !_validateAddress(),
            ),
            const SizedBox(height: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Established Year',
                  style: TextStyle(
                    color: Color(0xffD8D8D8),
                    fontSize: 16,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 8),
                DropdownButtonFormField<String>(
                  menuMaxHeight: 200,
                  value: _selectedYear,
                  hint: const Text(
                    'Select year',
                    style: TextStyle(color: Colors.white38),
                  ),
                  style: const TextStyle(color: Colors.white),
                  dropdownColor: const Color(0xff363636),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color(0xff363636),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 14,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  items:
                      List.generate(
                            100,
                            (index) => (DateTime.now().year - index).toString(),
                          )
                          .map(
                            (year) => DropdownMenuItem(
                              value: year,
                              child: Text(year),
                            ),
                          )
                          .toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedYear = value;
                      _showYearError = !_validateYear();
                    });
                  },
                ),
                if (_showYearError)
                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: ShakeWidget(
                      key: const Key('year_error'),
                      duration: const Duration(milliseconds: 700),
                      child: const Text(
                        'Please select a year',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 12,
                          color: Colors.red,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Logo',
                  style: TextStyle(
                    color: Color(0xffD8D8D8),
                    fontSize: 16,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 8),
                GestureDetector(
                  onTap: _showImageSourceSelection,
                  child: Container(
                    width: double.infinity,
                    height: 60,
                    decoration: BoxDecoration(
                      color: const Color(0xff363636),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          _logoImage != null
                              ? Icons.check_circle
                              : Icons.upload_file,
                          color: _logoImage != null
                              ? Colors.green
                              : Colors.white54,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          _logoImage != null ? 'Logo Selected' : 'Upload Logo',
                          style: const TextStyle(
                            color: Colors.white54,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                if (_logoImage != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        image: DecorationImage(
                          image: FileImage(_logoImage!),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                if (_showLogoError)
                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: ShakeWidget(
                      key: const Key('logo_error'),
                      duration: const Duration(milliseconds: 700),
                      child: const Text(
                        'Please upload a logo',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 12,
                          color: Colors.red,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: Column(
            spacing: 12,
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomAppButton1(
                text: 'Get OTP',
                onPlusTap: () {
                  if (_validateForm()) {
                    context.push('/otp');
                  }
                },
              ),
              GestureDetector(
                onTap: () {
                  context.push('/login');
                },
                child: RichText(
                  text: TextSpan(
                    text: "Already have an account? ",
                    style: const TextStyle(
                      color: Color(0xffADADAD),
                      fontSize: 14,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                    ),
                    children: [
                      TextSpan(
                        text: "Login Here",
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          color: Color(0xffADADAD),
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
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
