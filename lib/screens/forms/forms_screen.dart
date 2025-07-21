import 'package:flutter/material.dart';

class FormsScreen extends StatefulWidget {
  const FormsScreen({super.key});

  @override
  State<FormsScreen> createState() => _FormsScreenState();
}

class _FormsScreenState extends State<FormsScreen> with SingleTickerProviderStateMixin {
  final Color primaryColor = const Color(0xFF0A1D37);
  late TabController _tabController;
  double feedbackRating = 3;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  InputDecoration _inputDecoration(String label) => InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      );

  Widget _submitButton({required String text, IconData? icon, required VoidCallback onPressed}) {
    return SizedBox(
      width: double.infinity,
      child: icon == null
          ? ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor,
                foregroundColor: Colors.white,
                elevation: 3,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
              onPressed: onPressed,
              child: Text(text),
            )
          : ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor,
                foregroundColor: Colors.white,
                elevation: 3,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
              onPressed: onPressed,
              icon: Icon(icon),
              label: Text(text),
            ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: const Text('Forms', style: TextStyle(color: Colors.white)),
        iconTheme: const IconThemeData(color: Colors.white),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          tabs: const [
            Tab(text: 'Feedback'),
            Tab(text: 'Zoom Membership'),
            Tab(text: 'Bible College'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildFeedbackForm(),
          _buildZoomMembershipForm(),
          _buildBibleCollegeForm(),
        ],
      ),
    );
  }

  Widget _buildFeedbackForm() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          TextField(decoration: _inputDecoration('Name')),
          const SizedBox(height: 16),
          TextField(decoration: _inputDecoration('Contact')),
          const SizedBox(height: 16),
          TextField(decoration: _inputDecoration('Department')),
          const SizedBox(height: 16),
          TextField(
            decoration: _inputDecoration('Feedback'),
            maxLines: 4,
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Rating:', style: TextStyle(fontWeight: FontWeight.bold)),
              Text(feedbackRating.toStringAsFixed(0)),
            ],
          ),
          Slider(
            value: feedbackRating,
            min: 1,
            max: 5,
            divisions: 4,
            label: feedbackRating.round().toString(),
            onChanged: (value) => setState(() => feedbackRating = value),
          ),
          const SizedBox(height: 24),
          _submitButton(text: 'Submit Feedback', onPressed: () {}),
        ],
      ),
    );
  }

  Widget _buildZoomMembershipForm() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          TextField(decoration: _inputDecoration('Name')),
          const SizedBox(height: 16),
          TextField(decoration: _inputDecoration('Church Name')),
          const SizedBox(height: 16),
          TextField(decoration: _inputDecoration('Contact Details')),
          const SizedBox(height: 16),
          TextField(
            decoration: _inputDecoration('Short Testimony'),
            maxLines: 4,
          ),
          const SizedBox(height: 16),
          TextField(decoration: _inputDecoration('Reference')),
          const SizedBox(height: 24),
          _submitButton(text: 'Submit Membership', onPressed: () {}),
        ],
      ),
    );
  }

  Widget _buildBibleCollegeForm() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          TextField(decoration: _inputDecoration('Name')),
          const SizedBox(height: 16),
          TextField(decoration: _inputDecoration('Church Affiliation')),
          const SizedBox(height: 16),
          TextField(
            decoration: _inputDecoration('Reason for Joining'),
            maxLines: 4,
          ),
          const SizedBox(height: 24),
          _submitButton(
            text: 'Upload Documents',
            icon: Icons.upload,
            onPressed: () {},
          ),
          const SizedBox(height: 16),
          _submitButton(text: 'Submit Admission Form', onPressed: () {}),
        ],
      ),
    );
  }
}
