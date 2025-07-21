import 'package:flutter/material.dart';

class UpcomingEventsScreen extends StatelessWidget {
  const UpcomingEventsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final featuredEvent = {
      'title': 'Vision Festival 2025',
      'date': 'May 1, 2025 @ 6:00 PM',
      'venue': 'Fellowship Church Venue',
      'desc': 'Celebrate with us in our annual gathering!',
      'image': 'assets/images/vision_festival.jpg', // Placeholder path
    };

    final events = [
      {
        'title': 'Men’s Fellowship',
        'date': 'May 5, 2025',
        'type': 'Fellowship',
      },
      {
        'title': 'Women’s Fellowship',
        'date': 'May 9, 2025',
        'type': 'Fellowship',
      },
      {
        'title': 'Cottage Prayer Meeting',
        'date': 'May 16, 2025',
        'type': 'Prayer Meeting',
      },
      {
        'title': 'Fasting Prayer Meeting',
        'date': 'May 20, 2025',
        'type': 'Prayer Meeting',
      },
      {
        'title': 'Preparation Day Meeting',
        'date': 'May 25, 2025',
        'type': 'Special Service',
      },
      // Add more events as needed
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Upcoming Events — WCM Ministry',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0.5,
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          children: [
            const SizedBox(height: 8),
            const Text(
              'Mark your calendar and be part of what God is doing!',
              style: TextStyle(fontSize: 16, color: Colors.black87),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            // Featured Event Card
            _FeaturedEventCard(event: featuredEvent),
            const SizedBox(height: 18),
            // Event List
            ...events.map((e) => _EventListTile(event: e)).toList(),
            const SizedBox(height: 24),
            // View Archives Button
            Center(
              child: OutlinedButton.icon(
                icon: const Icon(Icons.archive_outlined),
                label: const Text('View Event Archives'),
                onPressed: () {
                  // TODO: Navigate to event archives
                },
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.deepPurple,
                  textStyle: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

class _FeaturedEventCard extends StatelessWidget {
  final Map<String, String> event;
  const _FeaturedEventCard({required this.event});
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Event Image/Poster
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Container(
                color: Colors.grey[300],
                width: 80,
                height: 90,
                child: event['image'] != null
                    ? Image.asset(event['image']!, fit: BoxFit.cover)
                    : const Icon(Icons.event, size: 40, color: Colors.deepPurple),
              ),
            ),
            const SizedBox(width: 14),
            // Event Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(event['title'] ?? '',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 18)),
                  const SizedBox(height: 4),
                  Text(event['date'] ?? '',
                      style: const TextStyle(
                          color: Colors.black87, fontWeight: FontWeight.w500)),
                  Text(event['venue'] ?? '',
                      style: const TextStyle(color: Colors.black54)),
                  const SizedBox(height: 8),
                  Text(event['desc'] ?? '',
                      style: const TextStyle(fontSize: 14)),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      OutlinedButton(
                        onPressed: () {
                          // TODO: View more details
                        },
                        child: const Text('View More'),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.deepPurple,
                          textStyle: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.share, color: Colors.deepPurple),
                        onPressed: () {
                          // TODO: Share event
                        },
                        tooltip: 'Share',
                      ),
                      IconButton(
                        icon: const Icon(Icons.event_available, color: Colors.deepPurple),
                        onPressed: () {
                          // TODO: Add to calendar
                        },
                        tooltip: 'Add to Calendar',
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _EventListTile extends StatelessWidget {
  final Map<String, String> event;
  const _EventListTile({required this.event});
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      elevation: 1,
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
        title: Text(
          event['title'] ?? '',
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        subtitle: Text(
          event['date'] ?? '',
          style: const TextStyle(fontSize: 14, color: Colors.black87),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.share, color: Colors.deepPurple),
              onPressed: () {
                // TODO: Share event
              },
              tooltip: 'Share',
            ),
            IconButton(
              icon: const Icon(Icons.event_available, color: Colors.deepPurple),
              onPressed: () {
                // TODO: Add to calendar
              },
              tooltip: 'Add to Calendar',
            ),
            const Icon(Icons.chevron_right, color: Colors.black45),
          ],
        ),
        onTap: () {
          // TODO: Navigate to event details
        },
      ),
    );
  }
} 