import 'package:flutter/material.dart';

class about_us extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About Us'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSectionTitle('Our Mission'),
              _buildSectionContent(
                'At L&F, we strive to create a community of trust where people can find and return lost items. Our goal is to simplify the process of reporting and recovering lost belongings.',
              ),
              _buildSectionTitle('How It Works'),
              _buildSectionContent(
                '1. Post a Lost or Found Item\n2. Browse Listings\n3. Contact the Owner',
              ),
              _buildSectionTitle('Our Features'),
              _buildFeatures(),
              SizedBox(height: 40),
              _buildSectionTitle('Get in Touch'),
              _buildSectionContent(
                'Have questions or suggestions? Reach out to us at  lostfound@gmail.com.',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: Colors.blueAccent,
        ),
      ),
    );
  }

  Widget _buildSectionContent(String content) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Text(
        content,
        style: TextStyle(fontSize: 16, color: Colors.black54),
      ),
    );
  }

  Widget _buildFeatures() {
    return Column(
      children: [
        _buildFeatureItem('Easy Search', Icons.search),
        _buildFeatureItem('Secure Messaging', Icons.lock),
        _buildFeatureItem('Location Tracking', Icons.location_on),
      ],
    );
  }

  Widget _buildFeatureItem(String title, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.blueAccent, size: 30),
          SizedBox(width: 10),
          Text(title, style: TextStyle(fontSize: 18, color: Colors.black87)),
        ],
      ),
    );
  }
}
