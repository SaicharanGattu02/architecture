import 'dart:io';
import 'package:architect/utils/color_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:go_router/go_router.dart';
import 'package:path/path.dart' as path;
import '../../Components/CustomAppButton.dart';
import '../../Components/CutomAppBar.dart';
import '../../Components/ShakeWidget.dart';

class CompanyProfileSetupScreen extends StatefulWidget {
  const CompanyProfileSetupScreen({super.key});

  @override
  State<CompanyProfileSetupScreen> createState() =>
      _CompanyProfileSetupScreenState();
}

class _CompanyProfileSetupScreenState extends State<CompanyProfileSetupScreen> {
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _experienceController = TextEditingController();
  final TextEditingController _projectsController = TextEditingController();
  final TextEditingController _contactController = TextEditingController();
  final TextEditingController _whatsappController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  List<File> _portfolioFiles = [];
  File? _documentFile;

  bool sameAsContact = false;
  bool _showDescriptionError = false;
  bool _showExperienceError = false;
  bool _showProjectsError = false;
  bool _showContactError = false;
  bool _showWhatsAppError = false;
  bool _whatsappTouched = false;
  bool _showPortfolioError = false;
  bool _showDocumentError = false;

  String _descriptionErrorMessage = '';
  String _experienceErrorMessage = '';
  String _projectsErrorMessage = '';
  String _contactErrorMessage = '';
  String _whatsAppErrorMessage = '';
  String _portfolioErrorMessage = '';
  String _documentErrorMessage = '';

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

  bool _validateDescription() {
    if (_descriptionController.text.isEmpty) {
      _descriptionErrorMessage = 'Company description is required';
      _showDescriptionError = true;
      _showDescriptionError = true;
      return false;
    } else if (_descriptionController.text.length < 20) {
      _descriptionErrorMessage = 'Description must be at least 20 characters';
      _showDescriptionError = true;
      return false;
    }
    _showDescriptionError = false;
    return true;
  }

  bool _validateExperience() {
    if (_experienceController.text.isEmpty) {
      _experienceErrorMessage = 'Years of experience is required';
      _showExperienceError = true;
      return false;
    }
    final years = int.tryParse(_experienceController.text);
    if (years == null || years < 0 || years > 100) {
      _experienceErrorMessage = 'Enter a valid number (0-100)';
      _showExperienceError = true;
      return false;
    }
    _showExperienceError = false;
    return true;
  }

  bool _validateProjects() {
    if (_projectsController.text.isEmpty) {
      _projectsErrorMessage = 'Number of projects is required';
      _showProjectsError = true;
      return false;
    }
    final projects = int.tryParse(_projectsController.text);
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
    } else if (!text.startsWith('+') && text.length != 10) {
      // If no country code, expect exactly 10 digits
      _contactErrorMessage =
          'Enter a valid 10-digit phone number or include country code (e.g., +1234567890)';
      _showContactError = true;
      return false;
    } else if (text.startsWith('+') && text.length < 10) {
      // If country code is included, expect at least 9 more characters
      _contactErrorMessage =
          'Enter a valid phone number with country code (e.g., +1234567890)';
      _showContactError = true;
      return false;
    }
    _showContactError = false;
    return true;
  }

  bool _validateWhatsApp() {
    final text = _whatsappController.text.trim();
    if (text.isEmpty) {
      _whatsAppErrorMessage = 'WhatsApp number is required';
      _showWhatsAppError = true;
      return false;
    } else if (!text.startsWith('+') && text.length != 10) {
      // If no country code, expect exactly 10 digits
      _whatsAppErrorMessage =
          'Enter a valid 10-digit phone number or include country code (e.g., +1234567890)';
      _showWhatsAppError = true;
      return false;
    } else if (text.startsWith('+') && text.length < 10) {
      // If country code is included, expect at least 9 more characters
      _whatsAppErrorMessage =
          'Enter a valid phone number with country code (e.g., +1234567890)';
      _showWhatsAppError = true;
      return false;
    }
    _showWhatsAppError = false;
    return true;
  }

  bool _validatePortfolio() {
    if (_portfolioFiles.isEmpty) {
      _portfolioErrorMessage = 'Please upload at least 1 portfolio file';
      _showPortfolioError = true;
    } else {
      _portfolioErrorMessage = '';
      _showPortfolioError = false;
    }
    _showPortfolioError = false;
    return true;
  }

  bool _validateDocument() {
    if (_documentFile == null) {
      _documentErrorMessage = 'Please upload a document';
      _showDocumentError = true;
      return false;
    } else if (path.extension(_documentFile!.path).toLowerCase() != '.pdf') {
      _documentErrorMessage = 'Only PDF files are allowed';
      _showDocumentError = true;
      return false;
    }
    _showDocumentError = false;
    return true;
  }

  bool _validateSpecializations() {
    return selectedSpecs.contains(true);
  }

  bool _validateForm() {
    final isValid =
        _validateDescription() &&
        _validateExperience() &&
        _validateProjects() &&
        _validateContact() &&
        _validateWhatsApp() &&
        _validatePortfolio() &&
        _validateDocument() &&
        _validateSpecializations();
    setState(() {}); // Trigger UI update to show errors
    return isValid;
  }

  Future<void> _pickImage(ImageSource source) async {
    try {
      final XFile? pickedFile = await _picker.pickImage(source: source);
      if (pickedFile != null) {
        setState(() {
          _portfolioFiles.add(File(pickedFile.path));
          _showAllPortfolioSlots = true; // Show files after adding
        });
      }
    } catch (e) {
      setState(() {
        _portfolioErrorMessage = 'Error picking image';
        _showPortfolioError = true;
      });
    }
    if (mounted) {
      _validatePortfolio();
      context.pop();
    }
  }

  Future<void> _pickFile({bool isDocument = false}) async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: isDocument ? ['pdf'] : ['pdf', 'jpg', 'jpeg', 'png'],
      );
      if (result != null && result.files.single.path != null) {
        setState(() {
          if (isDocument) {
            _documentFile = File(result.files.single.path!);
            _validateDocument();
          } else {
            _portfolioFiles.add(File(result.files.single.path!));
            _showAllPortfolioSlots = true; // Show files after adding
            _validatePortfolio();
          }
        });
      }
    } catch (e) {
      setState(() {
        if (isDocument) {
          _documentErrorMessage = 'Error picking file';
          _showDocumentError = true;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: CustomAppBar1(title: 'Company Profile Setup', actions: []),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20),
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
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
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
                          scale: 0.75, // smaller switch size
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
                                      _contactController.text;
                                  _validateWhatsApp();
                                } else {
                                  _whatsappController.clear();
                                  _showWhatsAppError = false;
                                }
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
                      maxLines:
                          1, // fix maxLines: phone input should only be one line
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                        fontFamily: 'Inter',
                      ),
                      decoration: InputDecoration(
                        hintText: 'Enter WhatsApp number (e.g., +1234567890)',
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
                      onTap: () {
                        if (!_whatsappTouched) {
                          setState(() {
                            _whatsappTouched = true;
                          });
                        }
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
                          children: List.generate(specializations.length, (
                            index,
                          ) {
                            return ChoiceChip(
                              label: Text(specializations[index]),
                              selected: selectedSpecs[index],
                              onSelected: (val) {
                                setState(() {
                                  selectedSpecs[index] = val;
                                });
                              },
                              labelStyle: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Inter',
                                fontSize: 14,
                              ),
                              selectedColor: primarycolor.withOpacity(0.5),
                              backgroundColor: Colors.grey.shade800,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            );
                          }),
                        ),
                        if (!_validateSpecializations())
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
                            _showFileSourceSelection(); // Show file picker on tap
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
                                    mainAxisAlignment: MainAxisAlignment.center,
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
                              children: List.generate(_portfolioFiles.length, (
                                index,
                              ) {
                                final file = _portfolioFiles[index];
                                final isImage = ['.jpg', '.jpeg', '.png']
                                    .contains(
                                      path.extension(file.path).toLowerCase(),
                                    );
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 8),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF2E2E2E),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: ListTile(
                                      leading: isImage
                                          ? ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(8),
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
                                            _portfolioFiles.removeAt(index);
                                            _validatePortfolio();
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                );
                              }),
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
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: Column(
            spacing: 12,
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomAppButton1(
                text: 'Done',
                onPlusTap: () {
                  context.push('/profile_created');
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
