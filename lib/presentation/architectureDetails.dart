import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ArchitectureDetails extends StatefulWidget {
  const ArchitectureDetails({Key? key}) : super(key: key);

  @override
  State<ArchitectureDetails> createState() => _ArchitectureDetailsState();
}

class _ArchitectureDetailsState extends State<ArchitectureDetails> {

  Widget _buildPortfolioCard() {
    return Container(
      width: 240,
      margin: const EdgeInsets.only(right: 16),
      decoration: BoxDecoration(
        color: Colors.grey[850],
        borderRadius: BorderRadius.circular(12),
      ),
      child: AspectRatio(
        aspectRatio: 16 / 9,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.asset(
            'assets/portfolio_placeholder.jpg',
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  // Dummy review card
  Widget _buildReviewCard() {
    return Container(
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
            child: Text('S', style: TextStyle(color: Colors.white)),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Sarah Johnson',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
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
                Text(
                  'When giving permission to use their work, some copyright holders ask that you do this. In some cases, you may also need to credit the copyright holder if you plan to use their work in a way that you consider appropriate.',
                  style: TextStyle(fontSize: 14, height: 1.4, color: Colors.white70),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Info tile
  Widget _buildInfoTile(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 18, color: Colors.white70),
        const SizedBox(width: 8),
        Expanded(
          child: Text(text, style: TextStyle(fontSize: 14, color: Colors.white70)),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: SizedBox(
          height: 50,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              shape: StadiumBorder(),
            ),
            onPressed: () {
              // Contact action
            },
            child: Text(
              'Contact Architect',
              style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Top cover + avatar + actions
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    height: 200,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/cover_placeholder.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 16,
                    bottom: -40,
                    child: CircleAvatar(
                      radius: 40,
                      backgroundColor: Colors.white,
                      backgroundImage: AssetImage('assets/avatar_placeholder.jpg'),
                    ),
                  ),
                  Positioned(
                    right: 16,
                    top: 16,
                    child: Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.call, color: Colors.white),
                          onPressed: () {},
                        ),
                        // IconButton(
                        //   icon: Icon(Icons.whatsapp, color: Colors.green),
                        //   onPressed: () {},
                        // ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 56),
              // Name, firm, verified
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Sarah Johnson',
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Modern Spaces Architecture',
                            style: TextStyle(fontSize: 14, color: Colors.white70),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Icon(Icons.star, size: 16, color: Colors.yellow),
                              const SizedBox(width: 4),
                              Text('4.0', style: TextStyle(fontSize: 14)),
                              const SizedBox(width: 4),
                              Text('(5 reviews)', style: TextStyle(fontSize: 14, color: Colors.white70)),
                              const SizedBox(width: 16),
                              Icon(Icons.location_on, size: 16, color: Colors.white70),
                              const SizedBox(width: 4),
                              Text('Hyderabad, India', style: TextStyle(fontSize: 14, color: Colors.white70)),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text('Verified', style: TextStyle(color: Colors.white, fontSize: 12)),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              // Stats row
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.grey[850],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          children: [
                            Text('12', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
                            const SizedBox(height: 4),
                            Text('Year Exp.', style: TextStyle(fontSize: 14, color: Colors.white70)),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.grey[850],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          children: [
                            Text('78', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
                            const SizedBox(height: 4),
                            Text('Projects', style: TextStyle(fontSize: 14, color: Colors.white70)),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.grey[850],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          children: [
                            Text('98%', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
                            const SizedBox(height: 4),
                            Text('Response', style: TextStyle(fontSize: 14, color: Colors.white70)),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              // About
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('About', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
                    const SizedBox(height: 8),
                    Text(
                      'When giving permission to use their work, some copyright holders ask that you do this. In some cases, you may also need to credit the copyright holder if you plan to use their work in a way that you consider.',
                      style: TextStyle(fontSize: 14, height: 1.4, color: Colors.white70),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              // Specializations
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    'Sustainable Design',
                    'Residential',
                    'Commercial',
                    'Urban Planning',
                  ].map((s) {
                    return Chip(
                      label: Text(s, style: TextStyle(fontSize: 12)),
                      backgroundColor: Colors.grey[850],
                      labelPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(height: 24),
              // Portfolio
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Portfolio', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
                    const SizedBox(height: 12),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate(2, (_) => _buildPortfolioCard()),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              // Reviews
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text('Reviews', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
              ),
              const SizedBox(height: 8),
              _buildReviewCard(),
              _buildReviewCard(),
              const SizedBox(height: 24),
              // Contact Info
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    _buildInfoTile(Icons.phone, '+91 8787878788'),
                    const SizedBox(height: 8),
                    _buildInfoTile(Icons.email, 'email@gmail.com'),
                    const SizedBox(height: 8),
                    _buildInfoTile(Icons.location_on, 'A-Block, The Platina, 303, Jayabheri Enclave,\nGachibowli, Hyderabad, Telangana 500032'),
                  ],
                ),
              ),
              const SizedBox(height: 80),
            ],
          ),
        ),
      ),
    );
  }
}