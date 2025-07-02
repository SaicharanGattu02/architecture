import 'dart:io';
import 'package:http/http.dart' as http; // For http.get
import 'package:path_provider/path_provider.dart';
import 'package:architect/utils/color_constants.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:go_router/go_router.dart';
import 'package:path/path.dart' as path;
import 'package:http/http.dart' as http;
import '../bloc/ArchitechAditionalInfo/architech_aditional_info_cubit.dart';
import '../bloc/ArchitechAditionalInfo/architech_aditional_info_state.dart';
import '../bloc/ArchitechProfileDetails/architech_profile_details_cubit.dart';
import '../bloc/ArchitechProfileDetails/architech_profile_details_state.dart';
import '../utils/ImageUtils.dart';
import '../utils/ShakeWidget.dart';
import 'Components/CustomAppButton.dart';
import 'Components/CustomSnackBar.dart';
import 'Components/CutomAppBar.dart';

class ArchitectProfileSetup extends StatefulWidget {
  final int id;
  final String type;
  const ArchitectProfileSetup({
    super.key,
    required this.id,
    required this.type,
  });

  @override
  State<ArchitectProfileSetup> createState() => _ArchitectProfileSetupState();
}

class _ArchitectProfileSetupState extends State<ArchitectProfileSetup> {
  @override
  void initState() {
    super.initState();
    if (widget.type == "Edit") {
      context.read<ArchitechProfileDetailsCubit>().getArchitechProfileDetails(
        widget.id,
      );
    }
  }

  Future<List<File>> downloadExistingPortfolioFiles(List<String> urls) async {
    List<File> files = [];
    final tempDir = await getTemporaryDirectory();

    for (String url in urls) {
      final filename = url.split('/').last;
      final filePath = '${tempDir.path}/$filename';
      final response = await http.get(Uri.parse(url));
      final file = File(filePath);
      await file.writeAsBytes(response.bodyBytes);
      files.add(file);
    }

    return files;
  }

  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _experienceController = TextEditingController();
  final TextEditingController _projectsController = TextEditingController();
  final TextEditingController _contactController = TextEditingController();
  final TextEditingController _whatsappController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  List<File> _portfolioFiles = [];
  List<String> _portfolioUrls = [];

  File? _documentFile;
  String? _selectedIndustryType;
  bool sameAsContact = false;
  bool _showDescriptionError = false;
  bool _showExperienceError = false;
  bool _showProjectsError = false;
  bool _showContactError = false;
  bool _showWhatsAppError = false;
  bool _whatsappTouched = false;
  bool _showPortfolioError = false;
  // bool _showDocumentError = false;
  bool _showSpecializationError = false;

  bool _validateSpecializations() {
    _showSpecializationError = !selectedSpecs.contains(true);
    return !_showSpecializationError;
  }

  String _descriptionErrorMessage = '';
  String _experienceErrorMessage = '';
  String _projectsErrorMessage = '';
  String _contactErrorMessage = '';
  String _whatsAppErrorMessage = '';
  String _portfolioErrorMessage = '';
  String _documentErrorMessage = '';
  final List<String> _industryTypes = [
    'Residential',
    'Commercial',
    'Industrial',
  ];
  bool _showtypes = false;
  final List<String> specializations = [
    'Sustainable Design',
    'Residential',
    'Commercial',
    'Urban Planning',
  ];
  List<bool> selectedSpecs = [false, false, false, false];
  bool _showAllPortfolioSlots = false;

  @override
  void dispose() {
    _descriptionController.dispose();
    _experienceController.dispose();
    _projectsController.dispose();
    _contactController.dispose();
    _whatsappController.dispose();
    super.dispose();
  }

  bool _validatePortfolio() {
    if (_portfolioFiles.isEmpty && _portfolioUrls.isEmpty) {
      _portfolioErrorMessage = 'Please upload at least one portfolio item';
      _showPortfolioError = true;
      return false;
    }
    _portfolioErrorMessage = '';
    _showPortfolioError = false;
    return true;
  }

  bool _validateDescription() {
    final text = _descriptionController.text.trim();
    if (text.isEmpty) {
      _descriptionErrorMessage = 'Company description is required';
      _showDescriptionError = true;
      return false;
    } else if (text.length < 20) {
      _descriptionErrorMessage = 'Description must be at least 20 characters';
      _showDescriptionError = true;
      return false;
    }
    _showDescriptionError = false;
    return true;
  }

  bool _validateIndustryType() {
    if (_selectedIndustryType == null) {
      _showtypes = true;
      return false;
    }
    _showtypes = false;
    return true;
  }

  bool _validateExperience() {
    final text = _experienceController.text.trim();
    if (text.isEmpty) {
      _experienceErrorMessage = 'Years of experience is required';
      _showExperienceError = true;
      return false;
    }
    final years = int.tryParse(text);
    if (years == null || years < 0 || years > 100) {
      _experienceErrorMessage = 'Enter a valid number (0-100)';
      _showExperienceError = true;
      return false;
    }
    _showExperienceError = false;
    return true;
  }

  bool _validateProjects() {
    final text = _projectsController.text.trim();
    if (text.isEmpty) {
      _projectsErrorMessage = 'Number of projects is required';
      _showProjectsError = true;
      return false;
    }
    final projects = int.tryParse(text);
    if (projects == null || projects < 0) {
      _projectsErrorMessage = 'Enter a valid number';
      _showProjectsError = true;
      return false;
    }
    _showProjectsError = false;
    return true;
  }

  bool _validateContact() {
    final text = _contactController.text.trim();
    if (text.isEmpty) {
      _contactErrorMessage = 'Contact number is required';
      _showContactError = true;
      return false;
    }

    if (!RegExp(r'^\+?\d{10,}$').hasMatch(text.replaceAll(' ', ''))) {
      _contactErrorMessage =
          'Enter a valid phone number (e.g., +1234567890 or 1234567890)';
      _showContactError = true;
      return false;
    }
    _showContactError = false;
    return true;
  }

  bool _validateWhatsApp() {
    if (sameAsContact) {
      _whatsappController.text = _contactController.text.trim();
    }
    final text = _whatsappController.text.trim();
    if (text.isEmpty) {
      _whatsAppErrorMessage = 'WhatsApp number is required';
      _showWhatsAppError = true;
      return false;
    }
    // Allow country code (+ followed by 9+ digits) or exactly 10 digits without country code
    if (!RegExp(r'^\+?\d{10,}$').hasMatch(text.replaceAll(' ', ''))) {
      _whatsAppErrorMessage =
          'Enter a valid phone number (e.g., +1234567890 or 1234567890)';
      _showWhatsAppError = true;
      return false;
    }
    _showWhatsAppError = false;
    return true;
  }

  Future<bool> _validateForm() async {
    print("Validating form...");

    final descriptionValid = _validateDescription();
    final experienceValid = _validateExperience();
    final projectsValid = _validateProjects();
    final contactValid = _validateContact();
    final whatsappValid = _validateWhatsApp();
    final portfolioValid = _validatePortfolio();
    final specializationValid = _validateSpecializations();
    final industryTypeValid = _validateIndustryType();

    final isValid =
        descriptionValid &&
        experienceValid &&
        projectsValid &&
        contactValid &&
        whatsappValid &&
        portfolioValid &&
        specializationValid &&
        industryTypeValid;

    setState(() {});

    if (isValid) {
      final selectedSpecializations = <String>[];
      for (int i = 0; i < specializations.length; i++) {
        if (selectedSpecs[i]) {
          selectedSpecializations.add(specializations[i]);
        }
      }

      if (selectedSpecializations.isEmpty) {
        print("Error: No specializations selected despite validation");
        setState(() {
          _showSpecializationError = true;
        });
        return false;
      }

      final Map<String, dynamic> data = {
        'company_id': widget.id,
        'about_company': _descriptionController.text.trim(),
        'years_of_experience': _experienceController.text.trim(),
        'number_of_projects': _projectsController.text.trim(),
        'contact_number': _contactController.text.trim(),
        'whatsapp_number': _whatsappController.text.trim(),
        'document': _documentFile,
        'industry_type': _selectedIndustryType!.toLowerCase(),
      };

      for (int i = 0; i < selectedSpecializations.length; i++) {
        data['specializations[$i]'] = selectedSpecializations[i];
      }

      if (widget.type == "New") {
        for (int i = 0; i < _portfolioFiles.length; i++) {
          data['portfolio[$i]'] = _portfolioFiles[i];
        }
      } else {
        List<File> allPortfolioFiles = [];

        if (_portfolioUrls.isNotEmpty) {
          final downloadedFiles = await downloadExistingPortfolioFiles(
            _portfolioUrls,
          );
          allPortfolioFiles.addAll(downloadedFiles);
        }
        allPortfolioFiles.addAll(_portfolioFiles);

        for (int i = 0; i < allPortfolioFiles.length; i++) {
          data['portfolio[$i]'] = allPortfolioFiles[i];
        }
      }

      // if (widget.type == "New") {
      //   for (int i = 0; i < _portfolioFiles.length; i++) {
      //     data['portfolio[$i]'] = _portfolioFiles[i];
      //   }
      // }
      // else {
      //   int portfolioIndex = 0;
      //   for (int i = 0; i < _portfolioUrls.length; i++) {
      //     data['portfolio[$portfolioIndex]'] = _portfolioUrls[i];
      //     portfolioIndex++;
      //   }
      //   for (int i = 0; i < _portfolioFiles.length; i++) {
      //     data['portfolio[$portfolioIndex]'] = _portfolioFiles[i];
      //     portfolioIndex++;
      //   }
      // }

      if (widget.type == "New") {
        debugPrint('create Data: $data');
        context
            .read<ArchitechAditionalInfoCubit>()
            .createArchitechAditionalInfo(data);
      } else {
        debugPrint('create Edit Data: $data');
        context
            .read<ArchitechAditionalInfoCubit>()
            .createArchitechAditionalInfoUpdate(data);
      }
    } else {
      print("Form validation failed");
    }

    return isValid;
  }

  Future<void> _pickImage(ImageSource source) async {
    try {
      final XFile? pickedFile = await _picker.pickImage(source: source);
      if (pickedFile != null) {
        // Attempt to compress the image
        File? compressedFile = await ImageUtils.compressImage(
          File(pickedFile.path),
        );

        // Use compressed image if available, otherwise fallback to original
        File finalFile = compressedFile ?? File(pickedFile.path);

        setState(() {
          _portfolioFiles.add(finalFile);
          _showAllPortfolioSlots = true;
          _validatePortfolio();
          _showPortfolioError = false;
        });
      }
    } catch (e) {
      setState(() {
        _portfolioErrorMessage = 'Error picking image: $e';
        _showPortfolioError = true;
      });
    }

    if (mounted) {
      context.pop(); // Close modal or sheet
    }
  }

  Future<void> _pickFile({bool isDocument = false}) async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'jpg', 'jpeg', 'png'],
      );
      if (result != null && result.files.single.path != null) {
        setState(() {
          if (isDocument) {
            _documentFile = File(result.files.single.path!);
            // _validateDocument();
          } else {
            _portfolioFiles.add(File(result.files.single.path!));
            _showAllPortfolioSlots = true;
            _validatePortfolio();
          }
        });
      }
    } catch (e) {
      setState(() {
        if (isDocument) {
          _documentErrorMessage = 'Error picking file';
          // _showDocumentError = true;
        } else {
          _portfolioErrorMessage = 'Error picking file';
          _showPortfolioError = true;
        }
      });
    }
    if (mounted) context.pop();
  }

  void _showFileSourceSelection({bool isDocument = false}) {
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
                    if (!isDocument) ...[
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
                        onTap: () => _pickImage(ImageSource.gallery),
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
                        onTap: () => _pickImage(ImageSource.camera),
                      ),
                    ],
                    ListTile(
                      leading: const Icon(Icons.folder, color: Colors.white),
                      title: Text(
                        isDocument ? 'Choose PDF File' : 'Choose File',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      onTap: () => _pickFile(isDocument: isDocument),
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

  bool _isInitialized = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: CustomAppBar1(
        title: (widget.type == "New")
            ? 'Company Profile Setup'
            : 'Company Profile Update',
        actions: [],
      ),
      body: (widget.type == "New")
          ? Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    '4 of 4',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 8),
                  LinearProgressIndicator(
                    minHeight: 8,
                    value: 1,
                    backgroundColor: const Color(0xff4D4D4D),
                    valueColor: const AlwaysStoppedAnimation<Color>(
                      Colors.white,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),

                  SizedBox(height: 20),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildTextField(
                            label: 'Company Description',
                            hint: 'Tell about your company',
                            controller: _descriptionController,
                            showError: _showDescriptionError,
                            errorMessage: _descriptionErrorMessage,
                            validate: _validateDescription,
                            keyboardType: TextInputType.multiline,
                          ),
                          const SizedBox(height: 20),
                          _buildTextField(
                            label: 'Year of Experience',
                            hint: 'Enter industry experience',
                            controller: _experienceController,
                            showError: _showExperienceError,
                            errorMessage: _experienceErrorMessage,
                            validate: _validateExperience,
                            keyboardType: TextInputType.number,
                          ),
                          const SizedBox(height: 20),
                          _buildTextField(
                            label: 'Number of Projects',
                            hint: 'Enter number of projects completed',
                            controller: _projectsController,
                            showError: _showProjectsError,
                            errorMessage: _projectsErrorMessage,
                            validate: _validateProjects,
                            keyboardType: TextInputType.number,
                          ),
                          const SizedBox(height: 20),
                          _buildTextField(
                            label: 'Contact Number',
                            hint: 'Enter contact number (e.g., +1234567890)',
                            controller: _contactController,
                            showError: _showContactError,
                            errorMessage: _contactErrorMessage,
                            validate: _validateContact,
                            keyboardType: TextInputType.phone,
                          ),
                          const SizedBox(height: 20),
                          Row(
                            children: [
                              Text(
                                'WhatsApp Number',
                                style: const TextStyle(
                                  color: Color(0xFFD8D8D8),
                                  fontSize: 16,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Spacer(),
                              Text(
                                'same as contact no',
                                style: const TextStyle(
                                  color: Color(0xFFD8D8D8),
                                  fontSize: 10,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(width: 5),
                              Transform.scale(
                                scale: 0.75,
                                child: Switch(
                                  inactiveTrackColor: Colors.grey.shade800,
                                  activeColor: Colors.greenAccent,
                                  activeTrackColor: Colors.green.shade700,
                                  value: sameAsContact,
                                  onChanged: (bool val) {
                                    setState(() {
                                      sameAsContact = val;
                                      if (val) {
                                        _whatsappController.text =
                                            _contactController.text.trim();
                                      } else {
                                        _whatsappController.clear();
                                      }
                                      _validateWhatsApp();
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 8),
                          TextField(
                            cursorColor: Colors.white,
                            controller: _whatsappController,
                            keyboardType: TextInputType.phone,
                            maxLines: 1,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                              fontFamily: 'Inter',
                            ),
                            decoration: InputDecoration(
                              hintText:
                                  'Enter WhatsApp number (e.g., +1234567890)',
                              hintStyle: const TextStyle(color: Colors.white70),
                              filled: true,
                              fillColor: const Color(0xFF2E2E2E),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide.none,
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 14,
                              ),
                            ),
                            enabled:
                                !sameAsContact, // Disable input when sameAsContact is true
                            onTap: () {
                              setState(() {
                                _whatsappTouched = true;
                                _validateWhatsApp();
                              });
                            },
                            onChanged: (_) {
                              if (_whatsappTouched) {
                                setState(() {
                                  _validateWhatsApp();
                                });
                              }
                            },
                            onEditingComplete: () {
                              setState(() {
                                _validateWhatsApp();
                              });
                            },
                          ),
                          if (_showWhatsAppError)
                            Padding(
                              padding: const EdgeInsets.only(top: 6),
                              child: ShakeWidget(
                                key: Key(_whatsAppErrorMessage),
                                duration: const Duration(milliseconds: 700),
                                child: Text(
                                  _whatsAppErrorMessage,
                                  style: const TextStyle(
                                    fontFamily: 'Inter',
                                    fontSize: 12,
                                    color: Colors.redAccent,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          const SizedBox(height: 20),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Specializations',
                                style: TextStyle(
                                  color: Color(0xFFD8D8D8),
                                  fontSize: 16,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Wrap(
                                spacing: 8,
                                runSpacing: 8,
                                children: List.generate(
                                  specializations.length,
                                  (index) {
                                    return ChoiceChip(
                                      label: Text(specializations[index]),
                                      selected: selectedSpecs[index],
                                      onSelected: (val) {
                                        setState(() {
                                          selectedSpecs[index] = val;
                                          _validateSpecializations();
                                        });
                                      },
                                      labelStyle: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'Inter',
                                        fontSize: 14,
                                      ),
                                      selectedColor: primarycolor.withOpacity(
                                        0.5,
                                      ),
                                      backgroundColor: Colors.grey.shade800,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              if (_showSpecializationError)
                                Padding(
                                  padding: const EdgeInsets.only(top: 6),
                                  child: ShakeWidget(
                                    key: const Key('specialization_error'),
                                    duration: const Duration(milliseconds: 700),
                                    child: const Text(
                                      'Please select at least one specialization',
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
                          const SizedBox(height: 20),
                          DropdownButtonFormField2<String>(
                            value: _selectedIndustryType,
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
                              'Select industry type',
                              style: TextStyle(color: Colors.white38),
                            ),
                            items: _industryTypes.map((String type) {
                              return DropdownMenuItem<String>(
                                value: type,
                                child: Text(
                                  type,
                                  style: const TextStyle(color: Colors.white),
                                ),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                _selectedIndustryType = value;
                                _validateIndustryType();
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
                              icon: Icon(
                                Icons.arrow_drop_down,
                                color: Colors.white,
                              ),
                            ),
                            menuItemStyleData: const MenuItemStyleData(
                              overlayColor: MaterialStatePropertyAll(
                                Colors.transparent,
                              ),
                            ),
                          ),
                          if (_showtypes)
                            const Padding(
                              padding: EdgeInsets.only(top: 5),
                              child: Text(
                                'Please select industry type',
                                style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontSize: 12,
                                  color: Colors.red,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          const SizedBox(height: 16),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Upload Portfolio',
                                style: TextStyle(
                                  color: Color(0xFFD8D8D8),
                                  fontSize: 16,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 10),
                              GestureDetector(
                                onTap: () {
                                  _showFileSourceSelection();
                                },
                                child: Container(
                                  width: double.infinity,
                                  height: 120,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF2E2E2E),
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                      color: _portfolioFiles.isNotEmpty
                                          ? Colors.green
                                          : Colors.grey.withOpacity(0.4),
                                      width: 1.5,
                                    ),
                                  ),
                                  child: _portfolioFiles.isEmpty
                                      ? Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: const [
                                            Icon(
                                              Icons.upload_file_rounded,
                                              color: Colors.white70,
                                            ),
                                            SizedBox(width: 10),
                                            Text(
                                              'Tap to Upload Portfolio',
                                              style: TextStyle(
                                                color: Colors.white70,
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500,
                                                fontFamily: 'Inter',
                                              ),
                                            ),
                                          ],
                                        )
                                      : Center(
                                          child: Text(
                                            '${_portfolioFiles.length} file(s) selected',
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500,
                                              fontFamily: 'Inter',
                                            ),
                                          ),
                                        ),
                                ),
                              ),
                              if (_portfolioFiles.isNotEmpty)
                                Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: Column(
                                    children: List.generate(
                                      _portfolioFiles.length,
                                      (index) {
                                        final file = _portfolioFiles[index];
                                        final isImage =
                                            ['.jpg', '.jpeg', '.png'].contains(
                                              path
                                                  .extension(file.path)
                                                  .toLowerCase(),
                                            );
                                        return Padding(
                                          padding: const EdgeInsets.only(
                                            bottom: 8,
                                          ),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: const Color(0xFF2E2E2E),
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                            child: ListTile(
                                              leading: isImage
                                                  ? ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            8,
                                                          ),
                                                      child: Image.file(
                                                        file,
                                                        width: 40,
                                                        height: 40,
                                                        fit: BoxFit.cover,
                                                      ),
                                                    )
                                                  : const Icon(
                                                      Icons.picture_as_pdf,
                                                      color: Colors.white70,
                                                    ),
                                              title: Text(
                                                path.basename(file.path),
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontFamily: 'Inter',
                                                  fontSize: 14,
                                                ),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              trailing: IconButton(
                                                icon: const Icon(
                                                  Icons.close,
                                                  color: Colors.white,
                                                ),
                                                onPressed: () {
                                                  setState(() {
                                                    _portfolioFiles.removeAt(
                                                      index,
                                                    );
                                                    _validatePortfolio();
                                                  });
                                                },
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              if (_showPortfolioError)
                                Padding(
                                  padding: const EdgeInsets.only(top: 6),
                                  child: ShakeWidget(
                                    key: Key(_portfolioErrorMessage),
                                    duration: const Duration(milliseconds: 700),
                                    child: Text(
                                      _portfolioErrorMessage,
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
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          : BlocBuilder<
              ArchitechProfileDetailsCubit,
              ArchitechProfileDetailsState
            >(
              builder: (context, state) {
                if (state is ArchitechProfileDetailsLoading) {
                  return const Center(
                    child: CircularProgressIndicator(color: Colors.white),
                  );
                } else if (state is ArchitechProfileDetailsLoaded) {
                  if (!_isInitialized) {
                    _descriptionController.text =
                        state.architechProfileModel.data?.aboutCompany ?? "";
                    _experienceController.text =
                        state.architechProfileModel.data?.yearsOfExperience
                            .toString() ??
                        "0";
                    _projectsController.text =
                        state.architechProfileModel.data?.numberOfProjects
                            .toString() ??
                        "0";

                    _contactController.text =
                        state.architechProfileModel.data?.contactNumber ?? "";
                    _whatsappController.text =
                        state.architechProfileModel.data?.whatsappNumber ?? "";
                    _whatsappController.text =
                        state.architechProfileModel.data?.whatsappNumber ?? "";
                    final fetchedSpecs =
                        state.architechProfileModel.data?.specializations ?? [];
                    for (int i = 0; i < specializations.length; i++) {
                      selectedSpecs[i] = fetchedSpecs.contains(
                        specializations[i],
                      );
                      _selectedIndustryType = _industryTypes.firstWhere(
                        (type) =>
                            type.toLowerCase() ==
                            state.architechProfileModel.data?.industryType
                                ?.toLowerCase(),
                        orElse: () => "",
                      );
                    }
                    _portfolioUrls = List<String>.from(
                      state.architechProfileModel.data?.portfolio ?? [],
                    );

                    _isInitialized = true;
                  }
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 20,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(height: 20),
                        Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildTextField(
                                  label: 'Company Description',
                                  hint: 'Tell about your company',
                                  controller: _descriptionController,
                                  showError: _showDescriptionError,
                                  errorMessage: _descriptionErrorMessage,
                                  validate: _validateDescription,
                                  keyboardType: TextInputType.multiline,
                                ),
                                const SizedBox(height: 20),
                                _buildTextField(
                                  label: 'Year of Experience',
                                  hint: 'Enter industry experience',
                                  controller: _experienceController,
                                  showError: _showExperienceError,
                                  errorMessage: _experienceErrorMessage,
                                  validate: _validateExperience,
                                  keyboardType: TextInputType.number,
                                ),
                                const SizedBox(height: 20),
                                _buildTextField(
                                  label: 'Number of Projects',
                                  hint: 'Enter number of projects completed',
                                  controller: _projectsController,
                                  showError: _showProjectsError,
                                  errorMessage: _projectsErrorMessage,
                                  validate: _validateProjects,
                                  keyboardType: TextInputType.number,
                                ),
                                const SizedBox(height: 20),
                                _buildTextField(
                                  label: 'Contact Number',
                                  hint:
                                      'Enter contact number (e.g., +1234567890)',
                                  controller: _contactController,
                                  showError: _showContactError,
                                  errorMessage: _contactErrorMessage,
                                  validate: _validateContact,
                                  keyboardType: TextInputType.phone,
                                ),
                                const SizedBox(height: 20),
                                Row(
                                  children: [
                                    Text(
                                      'WhatsApp Number',
                                      style: const TextStyle(
                                        color: Color(0xFFD8D8D8),
                                        fontSize: 16,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Spacer(),
                                    Text(
                                      'same as contact no',
                                      style: const TextStyle(
                                        color: Color(0xFFD8D8D8),
                                        fontSize: 10,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    const SizedBox(width: 5),
                                    Transform.scale(
                                      scale: 0.75,
                                      child: Switch(
                                        inactiveTrackColor:
                                            Colors.grey.shade800,
                                        activeColor: Colors.greenAccent,
                                        activeTrackColor: Colors.green.shade700,
                                        value: sameAsContact,
                                        onChanged: (bool val) {
                                          setState(() {
                                            sameAsContact = val;
                                            if (val) {
                                              _whatsappController.text =
                                                  _contactController.text
                                                      .trim();
                                            } else {
                                              _whatsappController.clear();
                                            }
                                            _validateWhatsApp();
                                          });
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 8),
                                TextField(
                                  cursorColor: Colors.white,
                                  controller: _whatsappController,
                                  keyboardType: TextInputType.phone,
                                  maxLines: 1,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16,
                                    fontFamily: 'Inter',
                                  ),
                                  decoration: InputDecoration(
                                    hintText:
                                        'Enter WhatsApp number (e.g., +1234567890)',
                                    hintStyle: const TextStyle(
                                      color: Colors.white70,
                                    ),
                                    filled: true,
                                    fillColor: const Color(0xFF2E2E2E),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: BorderSide.none,
                                    ),
                                    contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 14,
                                    ),
                                  ),
                                  enabled:
                                      !sameAsContact, // Disable input when sameAsContact is true
                                  onTap: () {
                                    setState(() {
                                      _whatsappTouched = true;
                                      _validateWhatsApp();
                                    });
                                  },
                                  onChanged: (_) {
                                    if (_whatsappTouched) {
                                      setState(() {
                                        _validateWhatsApp();
                                      });
                                    }
                                  },
                                  onEditingComplete: () {
                                    setState(() {
                                      _validateWhatsApp();
                                    });
                                  },
                                ),
                                if (_showWhatsAppError)
                                  Padding(
                                    padding: const EdgeInsets.only(top: 6),
                                    child: ShakeWidget(
                                      key: Key(_whatsAppErrorMessage),
                                      duration: const Duration(
                                        milliseconds: 700,
                                      ),
                                      child: Text(
                                        _whatsAppErrorMessage,
                                        style: const TextStyle(
                                          fontFamily: 'Inter',
                                          fontSize: 12,
                                          color: Colors.redAccent,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ),
                                const SizedBox(height: 20),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Specializations',
                                      style: TextStyle(
                                        color: Color(0xFFD8D8D8),
                                        fontSize: 16,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Wrap(
                                      spacing: 8,
                                      runSpacing: 8,
                                      children: List.generate(
                                        specializations.length,
                                        (index) {
                                          return ChoiceChip(
                                            label: Text(specializations[index]),
                                            selected: selectedSpecs[index],
                                            onSelected: (val) {
                                              setState(() {
                                                selectedSpecs[index] = val;
                                                _validateSpecializations();
                                              });
                                            },
                                            labelStyle: TextStyle(
                                              color: Colors.white,
                                              fontFamily: 'Inter',
                                              fontSize: 14,
                                            ),
                                            selectedColor: primarycolor
                                                .withOpacity(0.5),
                                            backgroundColor:
                                                Colors.grey.shade800,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                    if (_showSpecializationError)
                                      Padding(
                                        padding: const EdgeInsets.only(top: 6),
                                        child: ShakeWidget(
                                          key: const Key(
                                            'specialization_error',
                                          ),
                                          duration: const Duration(
                                            milliseconds: 700,
                                          ),
                                          child: const Text(
                                            'Please select at least one specialization',
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
                                const SizedBox(height: 20),
                                DropdownButtonFormField2<String>(
                                  value: _selectedIndustryType,
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
                                    'Select industry type',
                                    style: TextStyle(color: Colors.white38),
                                  ),
                                  items: _industryTypes.map((String type) {
                                    return DropdownMenuItem<String>(
                                      value: type,
                                      child: Text(
                                        type,
                                        style: const TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      _selectedIndustryType = value;
                                      _validateIndustryType();
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
                                    icon: Icon(
                                      Icons.arrow_drop_down,
                                      color: Colors.white,
                                    ),
                                  ),
                                  menuItemStyleData: const MenuItemStyleData(
                                    overlayColor: MaterialStatePropertyAll(
                                      Colors.transparent,
                                    ),
                                  ),
                                ),
                                if (_showtypes)
                                  const Padding(
                                    padding: EdgeInsets.only(top: 5),
                                    child: Text(
                                      'Please select industry type',
                                      style: TextStyle(
                                        fontFamily: 'Inter',
                                        fontSize: 12,
                                        color: Colors.red,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                const SizedBox(height: 16),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Upload Portfolio',
                                      style: TextStyle(
                                        color: Color(0xFFD8D8D8),
                                        fontSize: 16,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    GestureDetector(
                                      onTap: () {
                                        _showFileSourceSelection();
                                      },
                                      child: Container(
                                        width: double.infinity,
                                        height: 120,
                                        decoration: BoxDecoration(
                                          color: const Color(0xFF2E2E2E),
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                          border: Border.all(
                                            color:
                                                (_portfolioFiles.isNotEmpty ||
                                                    _portfolioUrls.isNotEmpty)
                                                ? Colors.green
                                                : Colors.grey.withOpacity(0.4),
                                            width: 1.5,
                                          ),
                                        ),
                                        child:
                                            (_portfolioFiles.isEmpty &&
                                                _portfolioUrls.isEmpty)
                                            ? Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: const [
                                                  Icon(
                                                    Icons.upload_file_rounded,
                                                    color: Colors.white70,
                                                  ),
                                                  SizedBox(width: 10),
                                                  Text(
                                                    'Tap to Upload Portfolio',
                                                    style: TextStyle(
                                                      color: Colors.white70,
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontFamily: 'Inter',
                                                    ),
                                                  ),
                                                ],
                                              )
                                            : Center(
                                                child: Text(
                                                  '${_portfolioFiles.length + _portfolioUrls.length} item(s) selected',
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w500,
                                                    fontFamily: 'Inter',
                                                  ),
                                                ),
                                              ),
                                      ),
                                    ),
                                    if (_portfolioFiles.isNotEmpty ||
                                        _portfolioUrls.isNotEmpty)
                                      Padding(
                                        padding: const EdgeInsets.only(top: 10),
                                        child: Column(
                                          children: [
                                            // Display existing portfolio URLs with index
                                            ...List.generate(_portfolioUrls.length, (
                                              index,
                                            ) {
                                              final url = _portfolioUrls[index];
                                              final isImage =
                                                  url.toLowerCase().endsWith(
                                                    '.jpg',
                                                  ) ||
                                                  url.toLowerCase().endsWith(
                                                    '.jpeg',
                                                  ) ||
                                                  url.toLowerCase().endsWith(
                                                    '.png',
                                                  );
                                              return Padding(
                                                padding: const EdgeInsets.only(
                                                  bottom: 8,
                                                ),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    color: const Color(
                                                      0xFF2E2E2E,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          12,
                                                        ),
                                                  ),
                                                  child: ListTile(
                                                    leading: isImage
                                                        ? ClipRRect(
                                                            borderRadius:
                                                                BorderRadius.circular(
                                                                  8,
                                                                ),
                                                            child: Image.network(
                                                              url,
                                                              width: 40,
                                                              height: 40,
                                                              fit: BoxFit.cover,
                                                              errorBuilder:
                                                                  (
                                                                    context,
                                                                    error,
                                                                    stackTrace,
                                                                  ) => const Icon(
                                                                    Icons
                                                                        .broken_image,
                                                                    color: Colors
                                                                        .white70,
                                                                  ),
                                                            ),
                                                          )
                                                        : const Icon(
                                                            Icons
                                                                .picture_as_pdf,
                                                            color:
                                                                Colors.white70,
                                                          ),
                                                    title: Text(
                                                      'portfolio[$index]: ${path.basename(url)}',
                                                      style: const TextStyle(
                                                        color: Colors.white,
                                                        fontFamily: 'Inter',
                                                        fontSize: 14,
                                                      ),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                    trailing: IconButton(
                                                      icon: const Icon(
                                                        Icons.close,
                                                        color: Colors.white,
                                                      ),
                                                      onPressed: () {
                                                        setState(() {
                                                          _portfolioUrls
                                                              .removeAt(index);
                                                          _validatePortfolio();
                                                        });
                                                      },
                                                    ),
                                                  ),
                                                ),
                                              );
                                            }),
                                            // Display new portfolio files with index continuing from URLs
                                            ...List.generate(_portfolioFiles.length, (
                                              index,
                                            ) {
                                              final file =
                                                  _portfolioFiles[index];
                                              final isImage =
                                                  [
                                                    '.jpg',
                                                    '.jpeg',
                                                    '.png',
                                                  ].contains(
                                                    path
                                                        .extension(file.path)
                                                        .toLowerCase(),
                                                  );
                                              return Padding(
                                                padding: const EdgeInsets.only(
                                                  bottom: 8,
                                                ),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    color: const Color(
                                                      0xFF2E2E2E,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          12,
                                                        ),
                                                  ),
                                                  child: ListTile(
                                                    leading: isImage
                                                        ? ClipRRect(
                                                            borderRadius:
                                                                BorderRadius.circular(
                                                                  8,
                                                                ),
                                                            child: Image.file(
                                                              file,
                                                              width: 40,
                                                              height: 40,
                                                              fit: BoxFit.cover,
                                                              errorBuilder:
                                                                  (
                                                                    context,
                                                                    error,
                                                                    stackTrace,
                                                                  ) => const Icon(
                                                                    Icons
                                                                        .broken_image,
                                                                    color: Colors
                                                                        .white70,
                                                                  ),
                                                            ),
                                                          )
                                                        : const Icon(
                                                            Icons
                                                                .picture_as_pdf,
                                                            color:
                                                                Colors.white70,
                                                          ),
                                                    title: Text(
                                                      'portfolio[${index + _portfolioUrls.length}]: ${path.basename(file.path)}',
                                                      style: const TextStyle(
                                                        color: Colors.white,
                                                        fontFamily: 'Inter',
                                                        fontSize: 14,
                                                      ),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                    trailing: IconButton(
                                                      icon: const Icon(
                                                        Icons.close,
                                                        color: Colors.white,
                                                      ),
                                                      onPressed: () {
                                                        setState(() {
                                                          _portfolioFiles
                                                              .removeAt(index);
                                                          _validatePortfolio();
                                                        });
                                                      },
                                                    ),
                                                  ),
                                                ),
                                              );
                                            }),
                                          ],
                                        ),
                                      ),
                                    if (_showPortfolioError)
                                      Padding(
                                        padding: const EdgeInsets.only(top: 6),
                                        child: ShakeWidget(
                                          key: Key(_portfolioErrorMessage),
                                          duration: const Duration(
                                            milliseconds: 700,
                                          ),
                                          child: Text(
                                            _portfolioErrorMessage,
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
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                } else if (state is ArchitechProfileDetailsError) {
                  return Center(
                    child: Text(
                      state.message,
                      style: const TextStyle(
                        color: Colors.redAccent,
                        fontSize: 16,
                      ),
                    ),
                  );
                }
                return const Center(
                  child: Text(
                    'Something went wrong',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                );
              },
            ),

      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              BlocConsumer<
                ArchitechAditionalInfoCubit,
                ArchitechAditionalInfoState
              >(
                listener: (context, state) {
                  if (state is ArchitechAditionalInfoSucess) {
                    context.go('/profile_created');
                  } else if (state is ArchitechAditionalInfoUpdateSucess) {
                    context.go('/user_posts');
                  } else if (state is ArchitechAditionalInfoError) {
                    CustomSnackBar.show(context, state.message);
                  }
                },
                builder: (context, state) {
                  return CustomAppButton1(
                    isLoading:
                        state is ArchitechAditionalInfoLoading ||
                        state is ArchitechAditionalInfoUpdateLoading,
                    text:
                        state is ArchitechAditionalInfoLoading ||
                            state is ArchitechAditionalInfoUpdateLoading
                        ? 'Submitting...'
                        : 'Done',
                    onPlusTap: state is ArchitechAditionalInfoLoading
                        ? null
                        : () => _validateForm(),
                  );
                },
              ),
            ],
          ),
        ),
      ),
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
            color: Color(0xFFD8D8D8),
            fontSize: 16,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          cursorColor: Colors.white,
          controller: controller,
          keyboardType: keyboardType,
          maxLines: keyboardType == TextInputType.multiline ? 4 : 1,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w400,
            fontSize: 16,
            fontFamily: 'Inter',
          ),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(color: Colors.white70),
            filled: true,
            fillColor: const Color(0xFF2E2E2E),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 14,
            ),
          ),
          onChanged: (_) {
            setState(() {
              validate();
            });
          },
          onEditingComplete: () {
            setState(() {
              validate();
            });
          },
        ),
        if (showError)
          Padding(
            padding: const EdgeInsets.only(top: 6),
            child: ShakeWidget(
              key: Key(errorMessage),
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
