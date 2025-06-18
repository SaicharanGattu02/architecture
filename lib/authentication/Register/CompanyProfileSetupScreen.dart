import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CompanyProfileSetupScreen extends StatefulWidget {
  const CompanyProfileSetupScreen({super.key});

  @override
  State<CompanyProfileSetupScreen> createState() => _CompanyProfileSetupScreenState();
}

class _CompanyProfileSetupScreenState extends State<CompanyProfileSetupScreen> {
  final TextEditingController _contactController = TextEditingController();
  final TextEditingController _whatsappController = TextEditingController();
  bool sameAsContact = false;

  final List<String> specializations = [
    'Sustainable Design',
    'Residential',
    'Commercial',
    'Urban Planning',
  ];

  List<bool> selectedSpecs = [false, false, false, false];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: const Icon(Icons.arrow_back, color: Colors.white),
        title: const Text(
          'Full Company Profile Setup',
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('4 of 4', style: TextStyle(color: Colors.white)),
            const SizedBox(height: 4),
            LinearProgressIndicator(
              value: 1.0,
              backgroundColor: Colors.grey.shade800,
              color: Colors.white,
            ),
            const SizedBox(height: 20),

            // Company Description
            _buildLabel("Describe about your company"),
            _buildTextField(hint: "Tell about your company", maxLines: 4),

            const SizedBox(height: 16),

            _buildLabel("Year of Experience"),
            _buildTextField(hint: "Enter industry experience"),

            const SizedBox(height: 16),

            _buildLabel("No of Projects"),
            _buildTextField(hint: "Enter no of projects completed"),

            const SizedBox(height: 16),

            _buildLabel("Contact No"),
            _buildTextField(
              hint: "Enter contact no",
              controller: _contactController,
              keyboardType: TextInputType.phone,
              onChanged: (val) {
                if (sameAsContact) {
                  _whatsappController.text = val;
                }
              },
            ),

            const SizedBox(height: 16),

            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildLabel("What's App no"),
                      _buildTextField(
                        hint: "Enter what's no",
                        controller: _whatsappController,
                        keyboardType: TextInputType.phone,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Column(
                  children: [
                    const SizedBox(height: 30),
                    Row(
                      children: [
                        const Text("same as contact no", style: TextStyle(color: Colors.white70, fontSize: 11)),
                        Switch(
                          value: sameAsContact,
                          onChanged: (val) {
                            setState(() {
                              sameAsContact = val;
                              if (val) {
                                _whatsappController.text = _contactController.text;
                              } else {
                                _whatsappController.clear();
                              }
                            });
                          },
                        )
                      ],
                    ),
                  ],
                )
              ],
            ),

            const SizedBox(height: 16),

            _buildLabel("Specializations"),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: List.generate(specializations.length, (index) {
                return ChoiceChip(
                  label: Text(specializations[index]),
                  selected: selectedSpecs[index],
                  onSelected: (val) {
                    setState(() {
                      selectedSpecs[index] = val;
                    });
                  },
                  labelStyle: const TextStyle(color: Colors.white),
                  selectedColor: Colors.white24,
                  backgroundColor: Colors.grey.shade800,
                );
              }),
            ),

            const SizedBox(height: 24),

            _buildLabel("Upload Portfolio"),
            const SizedBox(height: 12),
            for (int i = 0; i < 3; i++)
              Container(
                margin: const EdgeInsets.only(bottom: 12),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade700),
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      'Upload cover image/ Portfolio',
                      style: TextStyle(color: Colors.white70, fontSize: 13),
                    ),
                    Icon(Icons.upload, color: Colors.white70),
                  ],
                ),
              ),

            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                ),
                onPressed: () {
                  // Done action
                },
                child: const Text('Done', style: TextStyle(color: Colors.black)),
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Text(text, style: const TextStyle(color: Colors.white, fontSize: 14));
  }

  Widget _buildTextField({
    String? hint,
    int maxLines = 1,
    TextEditingController? controller,
    TextInputType? keyboardType,
    void Function(String)? onChanged,
  }) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      keyboardType: keyboardType,
      onChanged: onChanged,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.white70),
        filled: true,
        fillColor: Colors.grey[850],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      ),
    );
  }
}
