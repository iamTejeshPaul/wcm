import 'package:flutter/material.dart';

class ResourcesVaultScreen extends StatefulWidget {
  const ResourcesVaultScreen({super.key});

  @override
  State<ResourcesVaultScreen> createState() => _ResourcesVaultScreenState();
}

class _ResourcesVaultScreenState extends State<ResourcesVaultScreen> {
  final Color primaryColor = const Color(0xFF0A1D37);
  final List<String> categories = ['Testimonies', 'Devotionals', 'PDFs', 'Video Messages'];
  String selectedCategory = 'Testimonies';
  String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: const Text('Resources Vault', style: TextStyle(color: Colors.white)),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            DropdownButtonFormField<String>(
              value: selectedCategory,
              decoration: InputDecoration(
                labelText: 'Category',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
              ),
              items: categories.map((cat) {
                return DropdownMenuItem(
                  value: cat,
                  child: Text(cat),
                );
              }).toList(),
              onChanged: (value) => setState(() => selectedCategory = value!),
            ),
            const SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                labelText: 'Search by Topic or Date',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
              onChanged: (value) => setState(() => searchQuery = value),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: ListView.builder(
                itemCount: 5,
                itemBuilder: (context, index) {
                  IconData icon;
                  Color iconColor;

                  switch (selectedCategory) {
                    case 'PDFs':
                      icon = Icons.picture_as_pdf;
                      iconColor = Colors.redAccent;
                      break;
                    case 'Video Messages':
                      icon = Icons.video_library;
                      iconColor = Colors.deepPurple;
                      break;
                    case 'Devotionals':
                      icon = Icons.book;
                      iconColor = Colors.green;
                      break;
                    default:
                      icon = Icons.record_voice_over;
                      iconColor = Colors.blue;
                  }

                  return Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    elevation: 3,
                    margin: const EdgeInsets.only(bottom: 16),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: iconColor.withOpacity(0.1),
                        child: Icon(icon, color: iconColor),
                      ),
                      title: Text('$selectedCategory Item ${index + 1}'),
                      subtitle: const Text('Topic: Faith • Date: June 2025'),
                      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                      onTap: () {},
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
