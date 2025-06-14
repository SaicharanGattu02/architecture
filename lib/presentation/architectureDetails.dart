import 'package:architect/utils/color_constants.dart';
import 'package:flutter/material.dart';

import '../Components/CustomAppButton.dart';
import '../Components/CutomAppBar.dart';

class ArchitectureDetails extends StatefulWidget {
  const ArchitectureDetails({Key? key}) : super(key: key);

  @override
  State<ArchitectureDetails> createState() => _ArchitectureDetailsState();
}

class _ArchitectureDetailsState extends State<ArchitectureDetails> {
  Widget _buildPortfolioCard() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: Colors.grey[850],
        borderRadius: BorderRadius.circular(12),
      ),
      child: AspectRatio(
        aspectRatio: 16 / 9,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.asset('assets/portfolio.png', fit: BoxFit.cover),
        ),
      ),
    );
  }

  Widget _buildInfoTile(IconData icon, String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 18, color: Colors.white70),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(fontSize: 14, color: Colors.white70),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primarycolor,
      appBar: CustomAppBar1(title: 'Architecture Details', actions: []),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  height: 200,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/architecturebc.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  left: 16,
                  bottom: -50,
                  child: CircleAvatar(
                    radius: 70,
                    backgroundColor: Colors.white,
                    backgroundImage: AssetImage('assets/profile.png'),
                  ),
                ),
                Positioned(
                  right: 16,
                  bottom: -30,
                  child: Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.call, color: Colors.blue),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 56),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'Sarah Johnson',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Modern Spaces Architecture',
                          style: TextStyle(fontSize: 14, color: Colors.white70),
                        ),
                        SizedBox(height: 8),
                        Row(
                          children: [
                            Icon(Icons.star, size: 16, color: Colors.yellow),
                            SizedBox(width: 4),
                            Text(
                              '4.0',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(width: 4),
                            Text(
                              '(5 reviews)',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white70,
                              ),
                            ),
                            SizedBox(width: 16),
                            Icon(
                              Icons.location_on,
                              size: 16,
                              color: Colors.white70,
                            ),
                            SizedBox(width: 4),
                            Text(
                              'Hyderabad, India',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white70,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      'Verified',
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Stats
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  _buildStatBox('12', 'Year Exp.'),
                  const SizedBox(width: 12),
                  _buildStatBox('78', 'Projects'),
                  const SizedBox(width: 12),
                  _buildStatBox('98%', 'Response'),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // About
            _buildSectionTitle('About'),
            _buildSectionContent(
              'When giving permission to use their work, some copyright holders ask that you do this. In some cases, you may also need to credit the copyright holder if you plan to use their work in a way that you consider.',
            ),

            // Specializations
            _buildSectionTitle('Specializations'),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Wrap(
                spacing: 8,
                runSpacing: 8,
                children:
                    [
                      'Sustainable Design',
                      'Residential',
                      'Commercial',
                      'Urban Planning',
                    ].map((s) {
                      return Chip(
                        label: Text(s, style: const TextStyle(fontSize: 12)),
                        backgroundColor: Colors.grey[850],
                        labelPadding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                      );
                    }).toList(),
              ),
            ),

            const SizedBox(height: 24),
            _buildSectionTitle('Portfolio'),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: List.generate(3, (_) => _buildPortfolioCard()),
              ),
            ),

            const SizedBox(height: 24),
            _buildSectionTitle('Reviews'),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey[850],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.grey[700],
                    child: const Text(
                      'S',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Sarah Johnson',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: List.generate(5, (i) {
                            return Icon(
                              i < 4 ? Icons.star : Icons.star_border,
                              size: 16,
                              color: Colors.yellow,
                            );
                          }),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'When giving permission to use their work, some copyright holders ask that you do this. In some cases, you may also need to credit the copyright holder if you plan to use their work in a way that you consider appropriate.',
                          style: TextStyle(
                            fontSize: 14,
                            height: 1.4,
                            color: Colors.white70,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Contact Info
            _buildSectionTitle('Contact Info'),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  _buildInfoTile(Icons.phone, '+91 8787878788'),
                  const SizedBox(height: 8),
                  _buildInfoTile(Icons.email, 'email@gmail.com'),
                  const SizedBox(height: 8),
                  _buildInfoTile(
                    Icons.location_on,
                    'A-Block, The Platina, 303, Jayabheri Enclave,\nGachibowli, Hyderabad, Telangana 500032',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 80),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: CustomAppButton1(text: 'Contact Architect', onPlusTap: () {}),
        ),
      ),
    );
  }

  Widget _buildStatBox(String number, String label) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.grey[850],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Text(
              number,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: const TextStyle(fontSize: 14, color: Colors.white70),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w700,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildSectionContent(String content) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Text(
        content,
        style: const TextStyle(
          fontSize: 14,
          height: 1.4,
          color: Colors.white70,
        ),
      ),
    );
  }
}
