import 'package:flutter/material.dart';

class MinistryWingsScreen extends StatefulWidget {
  const MinistryWingsScreen({Key? key}) : super(key: key);

  @override
  State<MinistryWingsScreen> createState() => _MinistryWingsScreenState();
}

class _MinistryWingsScreenState extends State<MinistryWingsScreen> {
  final Color primaryColor = const Color(0xFF0A1D37);
  final Color accentColor = const Color(0xFF4CAF50);

  final List<Map<String, dynamic>> wings = [
    {
      'name': 'Gospel Outreach',
      'desc': 'Spreading the Gospel through various outreach programs',
      'category': 'Outreach',
      'icon': Icons.volunteer_activism,
      'gradient': [Color(0xFF667eea), Color(0xFF764ba2)],
    },
    {
      'name': 'Youth Ministry',
      'desc': 'Empowering young people in their faith journey',
      'category': 'Youth',
      'icon': Icons.people,
      'gradient': [Color(0xFFf093fb), Color(0xFFf5576c)],
    },
    {
      'name': 'Media & TV Ministry',
      'desc': 'Broadcasting God\'s message through media',
      'category': 'Media',
      'icon': Icons.tv,
      'gradient': [Color(0xFF4facfe), Color(0xFF00f2fe)],
    },
    {
      'name': 'Choir & Worship',
      'desc': 'Leading worship through music and praise',
      'category': 'Worship',
      'icon': Icons.music_note,
      'gradient': [Color(0xFF43e97b), Color(0xFF38f9d7)],
    },
    {
      'name': 'Prayer Tower',
      'desc': 'Intercessory prayer and spiritual warfare',
      'category': 'Prayer',
      'icon': Icons.self_improvement,
      'gradient': [Color(0xFFfa709a), Color(0xFFfee140)],
    },
    {
      'name': 'Medical & Charity',
      'desc': 'Serving the community through healthcare and charity',
      'category': 'Charity',
      'icon': Icons.medical_services,
      'gradient': [Color(0xFFa8edea), Color(0xFFfed6e3)],
    },
    {
      'name': 'Men\'s Fellowship',
      'desc': 'Building strong men of God',
      'category': 'Fellowship',
      'icon': Icons.group,
      'gradient': [Color(0xFFffecd2), Color(0xFFfcb69f)],
    },
    {
      'name': 'Women\'s Fellowship',
      'desc': 'Empowering women in faith and leadership',
      'category': 'Fellowship',
      'icon': Icons.people_outline,
      'gradient': [Color(0xFFff9a9e), Color(0xFFfecfef)],
    },
    {
      'name': 'Church Admin',
      'desc': 'Managing church operations and decisions',
      'category': 'Admin',
      'icon': Icons.admin_panel_settings,
      'gradient': [Color(0xFFa8caba), Color(0xFF5d4e75)],
    },
    {
      'name': 'Digital Communication',
      'desc': 'Connecting through technology and digital platforms',
      'category': 'Digital',
      'icon': Icons.computer,
      'gradient': [Color(0xFFd299c2), Color(0xFFfef9d7)],
    },
  ];

  String search = '';
  String selectedCategory = 'All';

  List<String> get categories =>
      ['All', ...{for (var w in wings) w['category']!}];

  @override
  Widget build(BuildContext context) {
    final filtered = wings.where((w) {
      final matchesSearch = search.isEmpty ||
          w['name']!.toLowerCase().contains(search.toLowerCase());
      final matchesCategory =
          selectedCategory == 'All' || w['category'] == selectedCategory;
      return matchesSearch && matchesCategory;
    }).toList();

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'Ministry Wings',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildWelcomeCard(),
              const SizedBox(height: 24),
              _buildSearchAndFilter(),
              const SizedBox(height: 24),
              _buildWingsGrid(filtered),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWelcomeCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [primaryColor, primaryColor.withOpacity(0.8)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: primaryColor.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.church,
                  color: Colors.white,
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Ministry Wings',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Discover how God is working through each department',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.9),
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSearchAndFilter() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.search, color: primaryColor, size: 20),
              const SizedBox(width: 8),
              Text(
                'Search & Filter',
                style: TextStyle(
                  color: primaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          TextField(
            decoration: InputDecoration(
              hintText: 'Search ministry wings...',
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            ),
            onChanged: (value) => setState(() => search = value),
          ),
          const SizedBox(height: 16),
          DropdownButtonFormField<String>(
            value: selectedCategory,
            decoration: InputDecoration(
              labelText: 'Category',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            ),
            items: categories.map((category) => DropdownMenuItem<String>(
              value: category,
              child: Text(category),
            )).toList(),
            onChanged: (value) {
              if (value != null) {
                setState(() => selectedCategory = value);
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildWingsGrid(List<Map<String, dynamic>> filteredWings) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Ministry Departments',
          style: TextStyle(
            color: primaryColor,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        const SizedBox(height: 16),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 0.85,
          ),
          itemCount: filteredWings.length,
          itemBuilder: (context, index) {
            final wing = filteredWings[index];
            return _buildWingCard(wing);
          },
        ),
      ],
    );
  }

  Widget _buildWingCard(Map<String, dynamic> wing) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: wing['gradient'],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: wing['gradient'][0].withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () {
            // Navigate to wing details
          },
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  wing['icon'],
                  color: Colors.white,
                  size: 32,
                ),
                const SizedBox(height: 12),
                Flexible(
                  child: Text(
                    wing['name'],
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(height: 8),
                Flexible(
                  child: Text(
                    wing['desc'],
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.9),
                      fontSize: 12,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    wing['category'],
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MinistryWingDetailsScreen extends StatelessWidget {
  final Map<String, String> wing;

  const MinistryWingDetailsScreen({Key? key, required this.wing}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(wing['name']!),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0.5,
      ),
      body: const Center(
        child: Text('Ministry Wing Details - Coming Soon'),
      ),
    );
  }
} 