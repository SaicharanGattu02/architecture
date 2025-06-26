import 'package:architect/bloc/CreateProfile/create_profile_cubit.dart';
import 'package:architect/bloc/CreateProfile/create_profile_state.dart';
import 'package:architect/bloc/city/city_cubit.dart';
import 'package:architect/bloc/city/city_states.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../../../bloc/ArchitechProfile/architech_profile_cubit.dart';
import '../../../bloc/ArchitechProfile/architech_profile_state.dart';
import '../../../bloc/state/state_cubit.dart';
import '../../../bloc/state/state_states.dart';
import '../../../utils/ImageUtils.dart';
import '../../../utils/ShakeWidget.dart';
import '../../../utils/color_constants.dart';
import '../../Components/CustomAppButton.dart';
import '../../Components/CustomSnackBar.dart';
import '../../Components/CutomAppBar.dart';

class CompanyDetails extends StatefulWidget {
  final int? id;
  const CompanyDetails({Key? key, this.id}) : super(key: key);

  @override
  _CompanyDetailsState createState() => _CompanyDetailsState();
}

class _CompanyDetailsState extends State<CompanyDetails> {
  @override
  void initState() {
    super.initState();

    context.read<StateCubit>().getState();

    final int? companyId = widget.id;
    if (companyId != null && companyId != 0) {
      context.read<ArchitechProfileCubit>().getArchitechProfile();
    }
  }

  final _companyController = TextEditingController();
  final _contactPersonController = TextEditingController();
  final _locationController = TextEditingController();

  final _emailController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  String? _selectedYear;
  File? _logoImage;
  File? _coverImage;
  String? _logoUrl;
  String? _coverPhotoUrl;
  bool _showCompanyError = false;
  bool _showContactPersonError = false;
  bool _showEmailError = false;
  bool _showYearError = false;
  bool _showLogoError = false;
  String? _selectState;
  String? _selectCity;
  bool _isInitialized = false;

  @override
  void dispose() {
    _companyController.dispose();
    _contactPersonController.dispose();
    _locationController.dispose();

    _emailController.dispose();
    super.dispose();
  }

  bool _validateCompany() => _companyController.text.trim().isNotEmpty;
  bool _validateContactPerson() =>
      _contactPersonController.text.trim().isNotEmpty;
  bool _validateLocation() => _selectCity != null && _selectCity!.isNotEmpty;

  bool _validateEmail() => RegExp(
    r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
  ).hasMatch(_emailController.text.trim());
  bool _validateYear() => _selectedYear != null;
  bool _validateLogo() => _logoImage != null;

  bool _validateForm() {
    setState(() {
      _showCompanyError = !_validateCompany();
      _showContactPersonError = !_validateContactPerson();
      _showEmailError = !_validateEmail();
      _showYearError = !_validateYear();
      _showLogoError = !_validateLogo();
    });

    return _validateCompany() &&
        _validateContactPerson() &&
        _validateLocation() &&
        _validateEmail() &&
        _validateYear() &&
        _validateLogo();
  }
  Future<void> _pickImage(ImageSource source, {bool isLogo = true}) async {
    try {
      final XFile? pickedFile = await _picker.pickImage(source: source);
      if (pickedFile != null) {
        // Compress the picked image using your utility
        File? compressedFile = await ImageUtils.compressImage(File(pickedFile.path));

        if (compressedFile != null) {
          setState(() {
            if (isLogo) {
              _logoImage = compressedFile;
              _showLogoError = !_validateLogo();
            } else {
              _coverImage = compressedFile;
            }
          });
        } else {
          // If compression failed, fall back to original file
          setState(() {
            if (isLogo) {
              _logoImage = File(pickedFile.path);
              _showLogoError = !_validateLogo();
            } else {
              _coverImage = File(pickedFile.path);
            }
          });
        }
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error picking image: $e')));
    }

    context.pop(); // assuming this closes a modal or bottom sheet
  }


  void _showImageSourceSelection({bool isLogo = true}) {
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
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 24,
                ),
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
                      leading: const Icon(
                        Icons.photo_library,
                        color: Colors.white,
                      ),
                      title: const Text(
                        'Choose from Gallery',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      onTap: () =>
                          _pickImage(ImageSource.gallery, isLogo: isLogo),
                    ),
                    ListTile(
                      leading: const Icon(
                        Icons.camera_alt,
                        color: Colors.white,
                      ),
                      title: const Text(
                        'Take Photo',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      onTap: () =>
                          _pickImage(ImageSource.camera, isLogo: isLogo),
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
          onTap: () => setState(() => validate()),
          onChanged: (_) => setState(() => validate()),
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
      appBar: CustomAppBar1(
        title: (widget.id != null && widget.id != 0)
            ? 'Update Profile'
            : 'Create Profile',
        actions: [],
      ),
      body: BlocBuilder<StateCubit, StateStates>(
        builder: (context, stateState) {
          return BlocBuilder<CityCubit, CityStates>(
            builder: (context, cityState) {
              return BlocBuilder<ArchitechProfileCubit, ArchitechProfileState>(
                builder: (context, profileState) {
                  if (stateState is StateLoading || cityState is CityLoading) {
                    return const Center(
                      child: CircularProgressIndicator(color: Colors.white),
                    );
                  }

                  if (widget.id == null || widget.id == 0) {
                    return _buildForm(context, stateState, cityState);
                  }
                  if (profileState is ArchitechProfileLoading) {
                    return const Center(
                      child: CircularProgressIndicator(color: Colors.white),
                    );
                  } else if (profileState is ArchitechProfileLoaded) {
                    if (!_isInitialized) {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        setState(() {
                          _isInitialized = true;
                          final profile =
                              profileState.architechProfileModel.data;
                          _companyController.text = profile?.companyName ?? "";
                          _contactPersonController.text =
                              profile?.contactPersonName ?? "";
                          _emailController.text = profile?.companyEmail ?? "";
                          _selectState = profile?.state ?? "";
                          _selectCity = profile?.location ?? "";
                          _selectedYear = profile?.establishedYear ?? "";
                          _logoUrl = profile?.logo ?? "";
                          _coverPhotoUrl = profile?.coverPhoto ?? "";
                          if (_selectState != null &&
                              _selectState!.isNotEmpty) {
                            context.read<CityCubit>().getCity(_selectState!);
                          }

                        });
                      });
                    }
                    return _buildForm(context, stateState, cityState);
                  } else if (profileState is ArchitechProfileError) {
                    return Center(
                      child: Text(
                        profileState.message,
                        style: const TextStyle(
                          color: Colors.redAccent,
                          fontSize: 16,
                        ),
                      ),
                    );
                  }
                  return Center(
                    child: CircularProgressIndicator(color: Colors.white),
                  );
                },
              );
            },
          );
        },
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              BlocConsumer<CreateProfileCubit, CreateProfileState>(
                listener: (context, state) {
                  if (state is CreateProfileSucess) {
                    context.push(
                      "/otp?mailId=${_emailController.text.trim()}&type=${"ProfileVerify"}",
                    );
                  } else if (state is UpdateCompanyProfileSucess) {
                    context.push(
                      '/architect_profile_setup?id=${widget.id}&type=${"Edit"}',
                    );
                  } else if (state is CreateProfileError) {
                    CustomSnackBar.show(context, state.message);
                  }
                },
                builder: (context, state) {
                  return CustomAppButton1(
                    isLoading: state is CreateProfileLoading,
                    text: widget.id != null && widget.id != 0
                        ? 'Next'
                        : 'Get OTP',
                    onPlusTap: () {
                      if (_validateForm()) {
                        final Map<String, dynamic> data = {
                          "company_name": _companyController.text.trim(),
                          "company_email": _emailController.text.trim(),
                          "contact_person_name": _contactPersonController.text
                              .trim(),
                          "established_year": _selectedYear,
                          "state": _selectState,
                          "location": _selectCity,
                          "logo": _logoImage,
                          "cover_photo": _coverImage,
                        };
                        if (widget.id != null && widget.id != 0) {
                          data['company_id'] = widget.id;
                          context
                              .read<CreateProfileCubit>()
                              .updateComapnyProfileApi(data);
                        } else {
                          context.read<CreateProfileCubit>().createProfileApi(
                            data,
                          );
                        }
                      }
                    },
                  );
                },
              ),
              if (widget.id == null || widget.id == 0) ...[
                const SizedBox(height: 12),
                GestureDetector(
                  onTap: () => context.push('/login'),
                  child: RichText(
                    text: const TextSpan(
                      text: "Already have an account? ",
                      style: TextStyle(
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
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildForm(
    BuildContext context,
    StateStates stateState,
    CityStates cityState,
  ) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.id == null || widget.id == 0) ...[
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
          ],
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
            validate: () => _showContactPersonError = !_validateContactPerson(),
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
          _buildStateDropdown(stateState),
          const SizedBox(height: 16),
          if (_selectState != null && _selectState!.isNotEmpty)
            _buildCityDropdown(cityState),
          const SizedBox(height: 16),
          _buildYearDropdown(),
          const SizedBox(height: 16),
          _buildImagePicker(
            label: 'Logo',
            image: _logoImage,
            showError: _showLogoError,
            errorMessage: 'Please upload a logo',
            onTap: () => _showImageSourceSelection(isLogo: true),
            onRemove: () => setState(() {
              _logoImage = null;
              _logoUrl = '';
              _showLogoError = false;
            }),
          ),
          const SizedBox(height: 16),
          _buildImagePicker(
            label: 'Cover Photo',
            image: _coverImage,
            showError: false,
            errorMessage: 'Please upload a cover photo',
            onTap: () => _showImageSourceSelection(isLogo: false),
            onRemove: () => setState(() {
              _coverImage = null;
              _coverPhotoUrl="";
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildStateDropdown(StateStates stateState) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Select State',
          style: TextStyle(
            color: Color(0xffD8D8D8),
            fontSize: 16,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        if (stateState is StateLoaded)
          DropdownButtonHideUnderline(
            child: DropdownButton2<String>(
              isExpanded: true,
              hint: const Text(
                'Select State',
                style: TextStyle(
                  fontFamily: 'roboto_serif',
                  fontSize: 16,
                  color: Colors.grey,
                ),
                overflow: TextOverflow.ellipsis,
              ),
              items: stateState.statesList.map((e) {
                return DropdownMenuItem<String>(
                  value: e.name,
                  child: Text(
                    e.name ?? "",
                    style: const TextStyle(
                      fontFamily: 'roboto_serif',
                      fontSize: 15,
                      color: Colors.white,
                    ),
                  ),
                );
              }).toList(),
              value: _selectState,
              onChanged: (String? value) {
                setState(() {
                  _selectState = value;
                  _selectCity = null; // Reset city when state changes
                  if (_selectState != null && _selectState!.isNotEmpty) {
                    context.read<CityCubit>().getCity(_selectState!);
                  }
                });
              },
              buttonStyleData: ButtonStyleData(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: formfieldColor, width: 0.5),
                  color: formfieldColor,
                ),
              ),
              iconStyleData: const IconStyleData(
                icon: Icon(Icons.keyboard_arrow_down_rounded),
                iconSize: 26,
                iconEnabledColor: Colors.white70,
              ),
              dropdownStyleData: DropdownStyleData(
                offset: const Offset(0, -6),
                maxHeight: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: formfieldColor,
                ),
              ),
              menuItemStyleData: const MenuItemStyleData(
                height: 45,
                padding: EdgeInsets.symmetric(horizontal: 20),
              ),
            ),
          )
        else
          const Center(
            child: Text(
              'Failed to load states',
              style: TextStyle(color: Colors.redAccent),
            ),
          ),
      ],
    );
  }

  Widget _buildCityDropdown(CityStates cityState) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Select City',
          style: TextStyle(
            color: Color(0xffD8D8D8),
            fontSize: 16,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        if (cityState is CityLoaded)
          DropdownButtonHideUnderline(
            child: DropdownButton2<String>(
              isExpanded: true,
              hint: const Text(
                'Select City',
                style: TextStyle(
                  fontFamily: 'roboto_serif',
                  fontSize: 16,
                  color: Colors.grey,
                ),
                overflow: TextOverflow.ellipsis,
              ),
              items: cityState.cityList.map((e) {
                return DropdownMenuItem<String>(
                  value: e.name,
                  child: Text(
                    e.name ?? "",
                    style: const TextStyle(
                      fontFamily: 'roboto_serif',
                      fontSize: 15,
                      color: Colors.white,
                    ),
                  ),
                );
              }).toList(),
              value: _selectCity,
              onChanged: (String? value) {
                setState(() {
                  _selectCity = value;
                });
              },
              buttonStyleData: ButtonStyleData(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: formfieldColor, width: 0.5),
                  color: formfieldColor,
                ),
              ),
              iconStyleData: const IconStyleData(
                icon: Icon(Icons.keyboard_arrow_down_rounded),
                iconSize: 26,
                iconEnabledColor: Colors.white70,
              ),
              dropdownStyleData: DropdownStyleData(
                offset: const Offset(0, -6),
                maxHeight: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: formfieldColor,
                ),
              ),
              menuItemStyleData: const MenuItemStyleData(
                height: 45,
                padding: EdgeInsets.symmetric(horizontal: 20),
              ),
            ),
          )
        else
          const Center(
            child: Text(
              'Failed to load cities',
              style: TextStyle(color: Colors.redAccent),
            ),
          ),
      ],
    );
  }

  Widget _buildYearDropdown() {
    return Column(
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
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
          ),
          hint: const Text(
            'Select year',
            style: TextStyle(color: Colors.white38),
          ),
          items:
              List.generate(
                    100,
                    (index) => (DateTime.now().year - index).toString(),
                  )
                  .map(
                    (year) => DropdownMenuItem<String>(
                      value: year,
                      child: Text(
                        year,
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  )
                  .toList(),
          onChanged: (value) {
            setState(() {
              _selectedYear = value;
              _showYearError = !_validateYear();
            });
          },
          dropdownStyleData: DropdownStyleData(
            useSafeArea: true,
            offset: const Offset(0, -8),
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
    );
  }
  Widget _buildImagePicker({
    required String label,
    required File? image,
    required bool showError,
    required String errorMessage,
    required VoidCallback onTap,
    required VoidCallback onRemove,
    bool isLogo = true, // Add parameter to determine if it's logo or cover photo
  }) {
    final String? networkImageUrl = isLogo ? _logoUrl : _coverPhotoUrl;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Color(0xFFD8D8D8),
            fontSize: 16,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 10),
        GestureDetector(
          onTap: onTap,
          child: Container(
            width: double.infinity,
            height: 120,
            decoration: BoxDecoration(
              color: const Color(0xFF2E2E2E),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: image != null || (networkImageUrl != null && networkImageUrl.isNotEmpty)
                    ? Colors.green
                    : Colors.grey.withOpacity(0.4),
                width: 1.5,
              ),
            ),
            child: image == null && (networkImageUrl == null || networkImageUrl.isEmpty)
                ? Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.upload_file_rounded, color: Colors.white70),
                SizedBox(width: 10),
                Text(
                  'Tap to Upload',
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
                  child: image != null
                      ? Image.file(
                    image,
                    width: double.infinity,
                    height: 120,
                    fit: BoxFit.cover,
                  )
                      : CachedNetworkImage(
                    imageUrl: networkImageUrl!,
                    width: double.infinity,
                    height: 120,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => const Center(
                      child: CircularProgressIndicator(
                        color: Colors.white70,
                      ),
                    ),
                    errorWidget: (context, url, error) => const Icon(
                      Icons.error,
                      color: Colors.redAccent,
                      size: 40,
                    ),
                  ),
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: GestureDetector(
                    onTap: onRemove,
                    child: Container(
                      decoration: const BoxDecoration(
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
        if (showError)
          Padding(
            padding: const EdgeInsets.only(top: 6),
            child: ShakeWidget(
              key: Key('${label.toLowerCase()}_error'),
              duration: const Duration(milliseconds: 700),
              child: Text(
                errorMessage,
                style: const TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 12,
                  color: Colors.redAccent,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
      ],
    );
  }

}
