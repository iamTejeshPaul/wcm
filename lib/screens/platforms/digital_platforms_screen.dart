import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DigitalPlatformsScreen extends StatefulWidget {
  const DigitalPlatformsScreen({Key? key}) : super(key: key);

  @override
  State<DigitalPlatformsScreen> createState() => _DigitalPlatformsScreenState();
}

class _DigitalPlatformsScreenState extends State<DigitalPlatformsScreen> {
  static const List<String> languages = [
    'All', 'English', 'Telugu', 'Tamil', 'Hindi', 'Kannada', 'Malayalam'
  ];
  String selectedLanguage = 'All';

  final List<Map<String, dynamic>> platforms = [
    {
      'name': 'YouTube',
      'icon': FontAwesomeIcons.youtube,
      'color': Color(0xFFFF0000),
      'channels': [
        {
          'label': 'WCM Ministries Official',
          'language': 'English',
          'description': 'Watch latest sermons and worship sessions',
          'url': 'https://youtube.com/@wcmministries',
        },
        {
          'label': 'WCM Telugu Channel',
          'language': 'Telugu',
          'description': 'Latest Telugu messages and worship',
          'url': 'https://youtube.com/@wcmministriestelugu',
        },
        {
          'label': 'WCM Tamil Channel',
          'language': 'Tamil',
          'description': 'Latest Tamil messages and worship',
          'url': 'https://youtube.com/@wcmministriestamil',
        },
      ],
    },
    {
      'name': 'Facebook',
      'icon': FontAwesomeIcons.facebook,
      'color': Color(0xFF1877F3),
      'channels': [
        {
          'label': '@wcmministries',
          'language': 'English',
          'description': 'Connect and get updates',
          'url': 'https://facebook.com/wcmministries',
        },
      ],
    },
    {
      'name': 'Instagram',
      'icon': FontAwesomeIcons.instagram,
      'color': Color(0xFFE1306C),
      'channels': [
        {
          'label': '@wcmministries',
          'language': 'English',
          'description': 'Photos, reels, and stories',
          'url': 'https://instagram.com/wcmministries',
        },
      ],
    },
    {
      'name': 'WhatsApp',
      'icon': FontAwesomeIcons.whatsapp,
      'color': Color(0xFF25D366),
      'channels': [
        {
          'label': 'WhatsApp Broadcast',
          'language': 'English',
          'description': 'Join our WhatsApp Broadcasts',
          'url': 'https://wa.me/1234567890',
        },
        {
          'label': 'WhatsApp Broadcast',
          'language': 'Telugu',
          'description': 'Join our WhatsApp Broadcasts',
          'url': 'https://wa.me/1234567891',
        },
        {
          'label': 'WhatsApp Broadcast',
          'language': 'Tamil',
          'description': 'Join our WhatsApp Broadcasts',
          'url': 'https://wa.me/1234567892',
        },
        {
          'label': 'WhatsApp Broadcast',
          'language': 'Hindi',
          'description': 'Join our WhatsApp Broadcasts',
          'url': 'https://wa.me/1234567893',
        },
      ],
    },
    {
      'name': 'Telegram',
      'icon': FontAwesomeIcons.telegram,
      'color': Color(0xFF0088CC),
      'channels': [
        {
          'label': '@wcmministries',
          'language': 'English',
          'description': 'Join our Telegram Channel',
          'url': 'https://t.me/wcmministries',
        },
      ],
    },
    {
      'name': 'Podcast',
      'icon': FontAwesomeIcons.podcast,
      'color': Color(0xFF9146FF),
      'channels': [
        {
          'label': 'Spotify',
          'language': 'English',
          'description': 'Listen to our podcast on Spotify',
          'url': 'https://spotify.com/wcmministries',
        },
      ],
    },
  ];

  final _suggestionController = TextEditingController();
  final _nameController = TextEditingController();

  @override
  void dispose() {
    _suggestionController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('WCM Ministries'),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0.5,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(18)),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        children: [
          Row(
            children: [
              const Expanded(
                child: Text(
                  'Digital Platforms',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                ),
              ),
              DropdownButton<String>(
                value: selectedLanguage,
                borderRadius: BorderRadius.circular(10),
                items: languages.map((lang) => DropdownMenuItem(
                  value: lang,
                  child: Text('Language: $lang'),
                )).toList(),
                onChanged: (val) {
                  if (val != null) setState(() => selectedLanguage = val);
                },
              ),
            ],
          ),
          const SizedBox(height: 4),
          const Text(
            'Stay Connected to Our Latest Updates in All Languages',
            style: TextStyle(fontSize: 15, color: Colors.black87),
          ),
          const SizedBox(height: 18),
          ..._buildPlatformCards(),
          const SizedBox(height: 24),
          _buildSuggestionForm(),
          const SizedBox(height: 18),
          const Divider(),
          const SizedBox(height: 10),
          const Text(
            'Follow us and share the Word. Stay blessed with daily updates from WCM Ministries.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 18),
        ],
      ),
    );
  }

  List<Widget> _buildPlatformCards() {
    final filtered = selectedLanguage == 'All'
        ? platforms
        : platforms
            .map((p) => {
                  ...p,
                  'channels': (p['channels'] as List)
                      .where((c) => c['language'] == selectedLanguage)
                      .toList(),
                })
            .where((p) => (p['channels'] as List).isNotEmpty)
            .toList();
    return filtered.map((platform) {
      return Card(
        color: (platform['color'] as Color).withOpacity(0.08),
        elevation: 2,
        margin: const EdgeInsets.symmetric(vertical: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: platform['color'] as Color,
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.all(12),
                child: FaIcon(platform['icon'] as IconData, color: Colors.white, size: 32),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      platform['name'],
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                    ),
                    ...List<Widget>.from((platform['channels'] as List).map((channel) => Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: _buildChannelRow(platform['color'], channel),
                        ))),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }).toList();
  }

  Widget _buildChannelRow(Color color, Map channel) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    channel['language'],
                    style: TextStyle(color: color, fontWeight: FontWeight.w600, fontSize: 12),
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  channel['label'],
                  style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
                ),
              ],
            ),
            const SizedBox(height: 2),
            Text(
              channel['description'],
              style: const TextStyle(fontSize: 13, color: Colors.black87),
            ),
          ],
        ),
        const Spacer(),
        ElevatedButton(
          onPressed: () {
            // TODO: Launch URL
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: color,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            elevation: 0,
          ),
          child: Text(
            _getChannelButtonLabel(channel),
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
          ),
        ),
      ],
    );
  }

  String _getChannelButtonLabel(Map channel) {
    if (channel['label'].toString().toLowerCase().contains('whatsapp')) {
      return 'Join Now';
    }
    if (channel['label'].toString().toLowerCase().contains('facebook')) {
      return 'Visit Facebook Page';
    }
    if (channel['label'].toString().toLowerCase().contains('youtube')) {
      return 'Visit YouTube Channel';
    }
    if (channel['label'].toString().toLowerCase().contains('instagram')) {
      return 'Visit Instagram';
    }
    if (channel['label'].toString().toLowerCase().contains('telegram')) {
      return 'Join Channel';
    }
    if (channel['label'].toString().toLowerCase().contains('spotify')) {
      return 'Listen on Spotify';
    }
    return 'Visit';
  }

  Widget _buildSuggestionForm() {
    return Card(
      color: Colors.grey.shade50,
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Suggest a Platform or Report an Issue', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 10),
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Your Name (optional)',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _suggestionController,
              minLines: 2,
              maxLines: 4,
              decoration: InputDecoration(
                labelText: 'Platform Suggestion or Issue',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              ),
            ),
            const SizedBox(height: 12),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: () {
                  // TODO: Send suggestion/report to backend
                  _suggestionController.clear();
                  _nameController.clear();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Thank you for your feedback!')),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                  elevation: 0,
                ),
                child: const Text('Submit', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
              ),
            ),
          ],
        ),
      ),
    );
  }
} 