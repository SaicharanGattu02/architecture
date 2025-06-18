import 'package:dropdown_button2/dropdown_button2.dart';
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
      context: context,
      isScrollControlled: false,
      isDismissible: true,
      backgroundColor: const Color(0xff2E2E2E),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return SafeArea(
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 40,
                      height: 4,
                      decoration: BoxDecoration(
                        color: Colors.white30,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    const SizedBox(height: 20),
                    ListTile(
                      leading: const Icon(Icons.photo_library, color: Colors.white),
                      title: const Text(
                        'Choose from Gallery',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      onTap: () => _pickImage(ImageSource.gallery),
                    ),
                    ListTile(
                      leading: const Icon(Icons.camera_alt, color: Colors.white),
                      title: const Text(
                        'Take Photo',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      onTap: () => _pickImage(ImageSource.camera),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 10,
                right: 10,
                child: IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(Icons.close, color: Colors.white),
                  tooltip: 'Close',
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
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w400,
            fontSize: 16,
            fontFamily: "Inter",
          ),
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
                fontFamily: 'Inter',
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 12),
            LinearProgressIndicator(
              minHeight: 8,
              value: 0.25,
              backgroundColor: const Color(0xff4D4D4D),
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
              borderRadius: BorderRadius.circular(8),
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
                DropdownButtonFormField2<String>(
                  value: _selectedYear,
                  isExpanded: true,
                  decoration: InputDecoration(
                    isDense: true,
                    filled: true,
                    fillColor: const Color(0xff363636),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  hint: const Text(
                    'Select year',
                    style: TextStyle(color: Colors.white38),
                  ),
                  items: List.generate(
                    100,
                        (index) => (DateTime.now().year - index).toString(),
                  ).map((year) {
                    return DropdownMenuItem<String>(
                      value: year,
                      child: Text(
                        year,
                        style: const TextStyle(color: Colors.white),
                      ),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedYear = value;
                      _showYearError = !_validateYear();
                    });
                  },
                  dropdownStyleData: DropdownStyleData(useSafeArea: true,
                    offset: const Offset(0,-8),
                    maxHeight: 200,
                    decoration: BoxDecoration(
                      color: const Color(0xff363636),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  iconStyleData: const IconStyleData(
                    icon: Icon(Icons.arrow_drop_down, color: Colors.white),
                  ),
                  menuItemStyleData: const MenuItemStyleData(
                    overlayColor: MaterialStatePropertyAll(Colors.transparent),
                  ),
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
                    color: Color(0xFFD8D8D8),
                    fontSize: 16,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 10),

                // Upload Container
                GestureDetector(
                  onTap: _showImageSourceSelection,
                  child: Container(
                    width: double.infinity,
                    height: 120,
                    decoration: BoxDecoration(
                      color: const Color(0xFF2E2E2E),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: _logoImage != null ? Colors.green : Colors.grey.withOpacity(0.4),
                        width: 1.5,
                      ),
                    ),
                    child: _logoImage == null
                        ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.upload_file_rounded, color: Colors.white70),
                        const SizedBox(width: 10),
                        const Text(
                          'Tap to Upload Logo',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    )
                        : Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.file(
                            _logoImage!,
                            width: double.infinity,
                            height: 120,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Positioned(
                          top: 8,
                          right: 8,
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                _logoImage = null;
                                _showLogoError = false; // Optional reset
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.black54,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.close,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Error Text
                if (_showLogoError)
                  Padding(
                    padding: const EdgeInsets.only(top: 6),
                    child: ShakeWidget(
                      key: const Key('logo_error'),
                      duration: const Duration(milliseconds: 700),
                      child: const Text(
                        'Please upload a logo',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 12,
                          color: Colors.redAccent,
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
