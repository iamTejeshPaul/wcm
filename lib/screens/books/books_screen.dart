import 'package:flutter/material.dart';

class BooksScreen extends StatefulWidget {
  const BooksScreen({super.key});

  @override
  State<BooksScreen> createState() => _BooksScreenState();
}

class _BooksScreenState extends State<BooksScreen> with SingleTickerProviderStateMixin {
  final Color primaryColor = const Color(0xFF0A1D37); // Dark Navy
  late TabController _tabController;

  final List<Map<String, dynamic>> books = [
    {
      'title': 'Faith & Life',
      'author': 'John Doe',
      'icon': Icons.menu_book,
      'color': Colors.blue
    },
    {
      'title': 'Spiritual Growth',
      'author': 'Jane Smith',
      'icon': Icons.auto_stories,
      'color': Colors.green
    },
    {
      'title': 'Community Service',
      'author': 'Alex Brown',
      'icon': Icons.volunteer_activism,
      'color': Colors.orange
    },
    {
      'title': 'Leadership Guide',
      'author': 'Mary Johnson',
      'icon': Icons.leaderboard,
      'color': Colors.purple
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'Books & Reports',
          style: TextStyle(color: Colors.white),
        ),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          labelStyle: const TextStyle(fontWeight: FontWeight.bold),
          tabs: const [
            Tab(text: 'Books'),
            Tab(text: 'Sales Reports'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildBooksTab(),
          _buildReportsTab(),
        ],
      ),
    );
  }

  Widget _buildBooksTab() {
    return LayoutBuilder(
      builder: (context, constraints) {
        return GridView.builder(
          padding: const EdgeInsets.all(20),
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 300, // adapt width automatically
            mainAxisSpacing: 20,
            crossAxisSpacing: 20,
          ),
          itemCount: books.length,
          itemBuilder: (context, index) {
            final book = books[index];
            return Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              elevation: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min, // natural height
                children: [
                  Container(
                    height: 120,
                    decoration: BoxDecoration(
                      color: book['color'].withOpacity(0.2),
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                    ),
                    child: Center(
                      child: Icon(book['icon'], size: 50, color: book['color']),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          book['title'],
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          book['author'],
                          style: const TextStyle(fontSize: 14),
                        ),
                        const SizedBox(height: 4),
                        const Text('Price: \$10.00'),
                        const Text('Available'),
                        const SizedBox(height: 10),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: primaryColor,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            onPressed: () {},
                            child: const Text('Order/Request'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildReportsTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryColor,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
            ),
            onPressed: () {},
            icon: const Icon(Icons.download),
            label: const Text('Download Sales Report PDF'),
          ),
          const SizedBox(height: 24),
          const Text(
            'Monthly Sales Summary',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              headingRowColor: MaterialStateColor.resolveWith(
                (states) => primaryColor.withOpacity(0.1),
              ),
              headingTextStyle: TextStyle(
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
              columns: const [
                DataColumn(label: Text('Month')),
                DataColumn(label: Text('Books Sold')),
                DataColumn(label: Text('Total Sales')),
              ],
              rows: List.generate(3, (index) {
                return DataRow(cells: [
                  DataCell(Text('Month ${index + 1}')),
                  const DataCell(Text('50')),
                  const DataCell(Text('\$500.00')),
                ]);
              }),
            ),
          ),
        ],
      ),
    );
  }
}
