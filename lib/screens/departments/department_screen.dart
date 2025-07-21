import 'package:flutter/material.dart';

class DepartmentScreen extends StatelessWidget {
  const DepartmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = const Color(0xFF0A1D37); // Dark Navy

    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        iconTheme: const IconThemeData(color: Colors.white), // Make back arrow white
        title: const Text(
          'Departments',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(primaryColor),
            const SizedBox(height: 20),
            _buildMission(),
            const SizedBox(height: 20),
            _buildLeadershipSection(),
            const SizedBox(height: 20),
            _buildUpdatesFeed(),
            const SizedBox(height: 20),
            _buildButtons(context, primaryColor),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(Color color) {
    return Row(
      children: [
        Icon(Icons.apartment, size: 40, color: color),
        const SizedBox(width: 12),
        Text(
          'Department Name',
          style: TextStyle(
            color: color,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildMission() {
    return const Text(
      'Mission: To serve the community with dedication and excellence. '
      'Description: This department handles various community outreach programs and initiatives.',
      style: TextStyle(fontSize: 16, height: 1.5),
    );
  }

  Widget _buildLeadershipSection() {
    final colors = [Colors.blue, Colors.green, Colors.orange];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Leadership',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: List.generate(3, (index) {
            return SizedBox(
              width: 150,
              child: Card(
                elevation: 3,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundColor: colors[index % colors.length],
                        child: const Icon(Icons.person, color: Colors.white, size: 30),
                      ),
                      const SizedBox(height: 8),
                      Text('Leader ${index + 1}',
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                      const Text('Role'),
                      const SizedBox(height: 4),
                      const Text('📞 123-456-7890', style: TextStyle(fontSize: 12)),
                    ],
                  ),
                ),
              ),
            );
          }),
        ),
      ],
    );
  }

  Widget _buildUpdatesFeed() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Updates',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 2,
          itemBuilder: (context, index) {
            return Card(
              elevation: 2,
              margin: const EdgeInsets.only(bottom: 10),
              child: ListTile(
                leading: const Icon(Icons.article, color: Colors.blue),
                title: Text('Update ${index + 1}'),
                subtitle: const Text('Brief news or activity report here.'),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildButtons(BuildContext context, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            backgroundColor: color,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 16),
          ),
          icon: const Icon(Icons.check_circle_outline, color: Colors.white),
          onPressed: () {
            // Staff action
          },
          label: const Text('Submit Daily Work Logs',
              style: TextStyle(color: Colors.white)),
        ),
        const SizedBox(height: 12),
        ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            backgroundColor: color,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 16),
          ),
          icon: const Icon(Icons.assignment, color: Colors.white),
          onPressed: () {
            // Leader action
          },
          label: const Text('Submit Monthly Reports',
              style: TextStyle(color: Colors.white)),
        ),
      ],
    );
  }
}
