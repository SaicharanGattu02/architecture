import 'package:architect/Components/CustomSnackBar.dart';
import 'package:architect/Components/CutomAppBar.dart';
import 'package:architect/Components/CustomAppButton.dart';
import 'package:architect/bloc/create_posted/create_post_cubit.dart';
import 'package:architect/bloc/create_posted/create_post_state.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../Components/ShakeWidget.dart';
import '../bloc/city/city_cubit.dart';
import '../bloc/city/city_states.dart';
import '../bloc/state/state_cubit.dart';
import '../bloc/state/state_states.dart';
import '../utils/color_constants.dart';

class PostRequirement extends StatefulWidget {
  const PostRequirement({Key? key}) : super(key: key);

  @override
  State<PostRequirement> createState() => _PostRequirementState();
}

class _PostRequirementState extends State<PostRequirement> {
  final _nameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();
  final _locationCtrl = TextEditingController();
  final _landDetailsCtrl = TextEditingController();

  String? _selectedDuration;

  // error messages
  String _nameError = '';
  String _emailError = '';
  String _phoneError = '';
  String _locationError = '';
  String _landDetailsError = '';
  String _durationError = '';
  String? _selectState;
  String? _selectCity;


  @override
  void initState() {
    super.initState();
    context.read<StateCubit>().getState();
    _nameCtrl.addListener(() {
      if (_nameError.isNotEmpty) {
        setState(() => _nameError = '');
      }
    });

    _emailCtrl.addListener(() {
      if (_emailError.isNotEmpty) {
        setState(() => _emailError = '');
      }
    });
    _phoneCtrl.addListener(() {
      if (_phoneError.isNotEmpty) {
        setState(() => _phoneError = '');
      }
    });

    _locationCtrl.addListener(() {
      if (_locationError.isNotEmpty) {
        setState(() => _locationError = '');
      }
    });

    _landDetailsCtrl.addListener(() {
      if (_landDetailsError.isNotEmpty) {
        setState(() => _landDetailsError = '');
      }
    });
    // _selectedDuration.addListener(() {
    //   if (_durationError.isNotEmpty) {
    //     setState(() => _durationError = '');
    //   }
    // });
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _phoneCtrl.dispose();
    _locationCtrl.dispose();
    _landDetailsCtrl.dispose();
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
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            fontFamily: 'Inter',
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 6),
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          style: const TextStyle(color: Colors.white, fontFamily: 'Inter'),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(
              color: Colors.white38,
              fontFamily: 'Inter',
            ),
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

  void _validateAndSubmit() {
    setState(() {
      _nameError = _nameCtrl.text.trim().isEmpty ? 'Name is required' : '';
      _emailError = _emailCtrl.text.trim().isEmpty ? 'Email is required' : '';
      _phoneError = _phoneCtrl.text.trim().isEmpty
          ? 'Phone number is required'
          : '';
      // _locationError = _locationCtrl.text.trim().isEmpty
      //     ? 'Location is required'
      //     : '';
      _landDetailsError = _landDetailsCtrl.text.trim().isEmpty
          ? 'Land details are required'
          : '';
      _durationError = _selectedDuration == null
          ? 'Please select a timeline'
          : '';
    });

    final hasError = [
      _nameError,
      _emailError,
      _phoneError,
      _landDetailsError,
      _durationError,
    ].any((e) => e.isNotEmpty);

    if (!hasError) {
      final Map<String, dynamic> data = {
        "name": _nameCtrl.text,
        "email": _emailCtrl.text,
        "phone": _phoneCtrl.text,
        "state": _selectState,
        "location": _selectCity,
        "land_details": _landDetailsCtrl.text,
        "time_frame": _selectedDuration,
      };
      context.read<CreatePostCubit>().createPostApi(data);
    }
  }

  Widget _errorText(String msg, String key) {
    if (msg.isEmpty) return const SizedBox(height: 15);
    return Container(
      alignment: Alignment.topLeft,
      margin: const EdgeInsets.only(bottom: 10, top: 5),
      child: ShakeWidget(
        key: Key(key),
        duration: const Duration(milliseconds: 700),
        child: Text(
          msg,
          style: const TextStyle(
            fontFamily: 'Inter',
            fontSize: 12,
            color: Colors.red,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: CustomAppBar1(title: 'Get Started', actions: []),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocBuilder<StateCubit, StateStates>(
          builder: (context, stateState) {
            return BlocBuilder<CityCubit, CityStates>(
              builder: (context, cityState) {
                if (stateState is StateLoading || cityState is CityLoading) {
                  return const Center(
                    child: CircularProgressIndicator(color: Colors.white),
                  );
                }
                return SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildTextField(
                        label: 'Name',
                        hint: 'Enter your name',
                        controller: _nameCtrl,
                      ),
                      _errorText(_nameError, 'nameError'),

                      // Email
                      _buildTextField(
                        label: 'Email',
                        hint: 'Enter your email',
                        controller: _emailCtrl,
                        keyboardType: TextInputType.emailAddress,
                      ),
                      _errorText(_emailError, 'emailError'),

                      // Phone
                      _buildTextField(
                        label: 'Phone Number',
                        hint: 'Enter your phone number',
                        controller: _phoneCtrl,
                        keyboardType: TextInputType.phone,
                      ),
                      _errorText(_phoneError, 'phoneError'),

                      const SizedBox(height: 16),
                      BlocBuilder<StateCubit, StateStates>(
                        builder: (context, state) {
                          if (state is StateLoading) {
                            return Center(
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              ),
                            );
                          } else if (state is StateLoaded) {
                            return DropdownButtonHideUnderline(
                              child: DropdownButton2<String>(
                                isExpanded: true,
                                hint: Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        'Select State',
                                        style: TextStyle(
                                          fontFamily: 'roboto_serif',
                                          fontSize: 16,
                                          color: Colors.grey.shade500,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                                items: state.statesList.map((e) {
                                  return DropdownMenuItem<String>(
                                    value: e.name,
                                    child: Text(
                                      e.name ?? "",
                                      style: TextStyle(
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
                                    context.read<CityCubit>().getCity(
                                      _selectState ?? "",
                                    );
                                  });
                                },
                                buttonStyleData: ButtonStyleData(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 6,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                      color: formfieldColor,
                                      width: 0.5,
                                    ),
                                    color: formfieldColor,
                                  ),
                                ),
                                iconStyleData: IconStyleData(
                                  icon: Icon(Icons.keyboard_arrow_down_rounded),
                                  iconSize: 26,
                                  iconEnabledColor: Colors.white70,
                                ),
                                dropdownStyleData: DropdownStyleData(
                                  offset: Offset(0, -6),
                                  maxHeight: 200,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    color: formfieldColor,
                                  ),
                                ),
                                menuItemStyleData: MenuItemStyleData(
                                  height: 45,
                                  padding: EdgeInsets.symmetric(horizontal: 20),
                                  overlayColor:
                                      MaterialStateProperty.resolveWith<Color?>(
                                        (Set<MaterialState> states) {
                                          if (states.contains(
                                            MaterialState.hovered,
                                          )) {
                                            return Colors.white.withOpacity(
                                              0.12,
                                            );
                                          }
                                          if (states.contains(
                                            MaterialState.pressed,
                                          )) {
                                            return Colors.white.withOpacity(
                                              0.2,
                                            );
                                          }
                                          return null;
                                        },
                                      ),
                                ),
                              ),
                            );
                          } else {
                            return Center(
                              child: Text(
                                'Failed to load state',
                                style: TextStyle(color: Colors.redAccent),
                              ),
                            );
                          }
                        },
                      ),
                      const SizedBox(height: 16),
                      if (_selectState != null && _selectState!.isNotEmpty) ...[
                        BlocBuilder<CityCubit, CityStates>(
                          builder: (context, state) {
                            if (state is CityLoading) {
                              return Center(
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                ),
                              );
                            } else if (state is CityLoaded) {
                              return DropdownButtonHideUnderline(
                                child: DropdownButton2<String>(
                                  isExpanded: true,
                                  hint: Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          'Select City',
                                          style: TextStyle(
                                            fontFamily: 'roboto_serif',
                                            fontSize: 16,
                                            color: Colors.grey.shade500,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                  items: state.cityList.map((e) {
                                    return DropdownMenuItem<String>(
                                      value: e.name,
                                      child: Text(
                                        e.name ?? "",
                                        style: TextStyle(
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
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 16,
                                      vertical: 6,
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                        color: formfieldColor,
                                        width: 0.5,
                                      ),
                                      color: formfieldColor,
                                    ),
                                  ),
                                  iconStyleData: IconStyleData(
                                    icon: Icon(
                                      Icons.keyboard_arrow_down_rounded,
                                    ),
                                    iconSize: 26,
                                    iconEnabledColor: Colors.white70,
                                  ),
                                  dropdownStyleData: DropdownStyleData(
                                    offset: Offset(0, -6),
                                    maxHeight: 200,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      color: formfieldColor,
                                    ),
                                  ),
                                  menuItemStyleData: MenuItemStyleData(
                                    height: 45,
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 20,
                                    ),
                                    overlayColor:
                                        MaterialStateProperty.resolveWith<
                                          Color?
                                        >((Set<MaterialState> states) {
                                          if (states.contains(
                                            MaterialState.hovered,
                                          )) {
                                            return Colors.white.withOpacity(
                                              0.12,
                                            );
                                          }
                                          if (states.contains(
                                            MaterialState.pressed,
                                          )) {
                                            return Colors.white.withOpacity(
                                              0.2,
                                            );
                                          }
                                          return null;
                                        }),
                                  ),
                                ),
                              );
                            } else {
                              return Center(
                                child: Text(
                                  'Failed to load states',
                                  style: TextStyle(color: Colors.redAccent),
                                ),
                              );
                            }
                          },
                        ),
                        const SizedBox(height: 16),
                      ],

                      // Land Details
                      _buildTextField(
                        label: 'Land Details',
                        hint: 'Enter land details',
                        controller: _landDetailsCtrl,
                        keyboardType: TextInputType.multiline,
                      ),
                      _errorText(_landDetailsError, 'landError'),

                      Text(
                        'Timeline',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Inter',
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 6),
                      DropdownButtonHideUnderline(
                        child: DropdownButton2<String>(
                          isExpanded: true,
                          hint: Text(
                            'Select timeline',
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 16,
                              color: Colors.grey.shade500,
                            ),
                          ),
                          items: ['1-3 months', '3-6 months', '6+ months']
                              .map(
                                (e) => DropdownMenuItem(
                                  value: e,
                                  child: Text(
                                    e,
                                    style: const TextStyle(
                                      fontFamily: 'Inter',
                                      fontSize: 15,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              )
                              .toList(),
                          value: _selectedDuration,
                          onChanged: (val) =>
                              setState(() => _selectedDuration = val),
                          buttonStyleData: ButtonStyleData(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: Colors.grey.shade800),
                              color: Colors.grey.shade900,
                            ),
                          ),
                          iconStyleData: const IconStyleData(
                            icon: Icon(Icons.keyboard_arrow_down_rounded),
                            iconSize: 24,
                            iconEnabledColor: Colors.white70,
                          ),
                          dropdownStyleData: DropdownStyleData(
                            maxHeight: 180,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.grey.shade900,
                            ),
                          ),
                        ),
                      ),
                      _errorText(_durationError, 'durationError'),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: BlocConsumer<CreatePostCubit, CreatePostState>(
            listener: (context, state) {
              if (state is CreatePostSucess) {
                context.pushReplacement('/post_your_requirement_success');
              } else if (state is CreatePostError) {
                CustomSnackBar.show(context, state.message);
              }
            },
            builder: (context, state) {
              return CustomAppButton1(
                isLoading: state is CreatePostLoading,
                text: 'Submit',
                onPlusTap: _validateAndSubmit,
              );
            },
          ),
        ),
      ),
    );
  }
}
