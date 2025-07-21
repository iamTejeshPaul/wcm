import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DailyQuotesScreen extends StatefulWidget {
  const DailyQuotesScreen({Key? key}) : super(key: key);

  @override
  State<DailyQuotesScreen> createState() => _DailyQuotesScreenState();
}

class _DailyQuotesScreenState extends State<DailyQuotesScreen> {
  // Ministry blue palette
  static const Color primaryBlue = Color(0xFF1E3A8A);
  static const Color secondaryBlue = Color(0xFF3B82F6);
  static const Color cardColor = Color(0xFFFFFFFF);
  static const Color textPrimary = Color(0xFF1E293B);
  static const Color textSecondary = Color(0xFF64748B);
  static const Color accent = Color(0xFF60A5FA);

  final List<String> languages = [
    'English', 'Tamil', 'Hindi', 'Telugu', 'Malayalam', 'Kannada'
  ];
  String selectedLanguage = 'English';

  // Mock data for demonstration
  final List<Map<String, dynamic>> quotes = [
    {
      'date': DateTime(2025, 6, 23),
      'text': 'Faith is not a feeling. It is a decision to trust God even when the road ahead is uncertain.',
      'author': 'Kiran Paul',
      'role': 'Founder & Chairman, WCM Ministry',
      'audio': null, // or provide a URL
      'background': null, // or provide an asset path
      'translations': {
        'English': 'Faith is not a feeling. It is a decision to trust God even when the road ahead is uncertain.',
        'Tamil': 'நம்பிக்கை ஒரு உணர்வு அல்ல. எதிர்காலம் தெரியாதபோதும் தேவனை நம்ப முடிவு செய்வதே நம்பிக்கை.',
        'Hindi': 'विश्वास एक भावना नहीं है। यह एक निर्णय है कि जब आगे का रास्ता अनिश्चित हो तब भी परमेश्वर पर भरोसा करें।',
        'Telugu': 'విశ్వాసం అనేది ఒక భావోద్వేగం కాదు. ముందున్న మార్గం అనిశ్చితమైనప్పుడు కూడా దేవుని నమ్మే నిర్ధಾరం.',
        'Malayalam': 'വിശ്വാസം ഒരു അനുഭവം അല്ല. മുന്നിലുള്ള വഴി അനിശ്ചിതമായിരിക്കുമ്പോഴും ദൈവത്തിൽ വിശ്വസിക്കാൻ എടുത്ത തീരുമാനമാണ്.',
        'Kannada': 'ವಿಶ್ವಾಸವು ಒಂದು ಭಾವನೆ ಅಲ್ಲ. ಮುಂದె ಏನು ಎಂಬುದು ಗೊತ್ತಿಲ್ಲದಿದ್ದರೂ ದೇವರನ್ನು ನಂಬುವ ನಿರ్ಧಾರ.'
      }
    },
    // Add more quotes as needed
  ];

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final quote = quotes[currentIndex];
    final quoteText = quote['translations'][selectedLanguage] ?? quote['text'];
    final date = DateFormat.yMMMMd().format(quote['date']);
    final hasAudio = quote['audio'] != null;
    final background = quote['background'];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: primaryBlue),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
        title: const Text(
          'Daily Quotes — Kiran Paul',
          style: TextStyle(
            color: primaryBlue,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(18)),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
              child: Text(
                'Spirit-filled thoughts to guide your day, spoken from a heart for God’s people.',
                style: const TextStyle(
                  color: textSecondary,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 4),
              child: Row(
                children: [
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      value: selectedLanguage,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      items: languages.map((lang) => DropdownMenuItem(
                        value: lang,
                        child: Text(lang),
                      )).toList(),
                      onChanged: (val) {
                        if (val != null) setState(() => selectedLanguage = val);
                      },
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: PageView.builder(
                controller: PageController(initialPage: currentIndex),
                onPageChanged: (idx) => setState(() => currentIndex = idx),
                itemCount: quotes.length,
                itemBuilder: (context, idx) {
                  final q = quotes[idx];
                  final qText = q['translations'][selectedLanguage] ?? q['text'];
                  final qDate = DateFormat.yMMMMd().format(q['date']);
                  return Center(
                    child: Card(
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                      color: cardColor,
                      child: Container(
                        width: double.infinity,
                        margin: const EdgeInsets.all(8),
                        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 24),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(18),
                          image: background != null
                              ? DecorationImage(
                                  image: AssetImage(background),
                                  fit: BoxFit.cover,
                                  colorFilter: ColorFilter.mode(
                                    Colors.white.withOpacity(0.85),
                                    BlendMode.lighten,
                                  ),
                                )
                              : null,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            if (hasAudio) ...[
                              // TODO: Implement audio player
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CircleAvatar(
                                    backgroundColor: accent,
                                    child: Icon(Icons.play_arrow, color: Colors.white),
                                  ),
                                  const SizedBox(width: 8),
                                  Text('Listen to today’s quote', style: TextStyle(color: accent, fontWeight: FontWeight.w600)),
                                ],
                              ),
                              const SizedBox(height: 16),
                            ],
                            Text(
                              '“$qText”',
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: textPrimary,
                                height: 1.3,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 18),
                            Text(
                              '— ${q['author']},\n${q['role']}',
                              style: const TextStyle(
                                fontSize: 16,
                                color: textSecondary,
                                fontWeight: FontWeight.w500,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 10),
                            Text(
                              qDate,
                              style: const TextStyle(
                                fontSize: 14,
                                color: textSecondary,
                              ),
                            ),
                            const SizedBox(height: 18),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton.icon(
                                  onPressed: idx > 0 ? () => setState(() => currentIndex = idx - 1) : null,
                                  icon: const Icon(Icons.fast_rewind),
                                  label: const Text('Previous'),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: primaryBlue,
                                    foregroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                  ),
                                ),
                                const SizedBox(width: 16),
                                ElevatedButton.icon(
                                  onPressed: idx < quotes.length - 1 ? () => setState(() => currentIndex = idx + 1) : null,
                                  icon: const Icon(Icons.fast_forward),
                                  label: const Text('Next'),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: primaryBlue,
                                    foregroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 18),
                            Wrap(
                              alignment: WrapAlignment.center,
                              spacing: 12,
                              children: [
                                IconButton(
                                  icon: const FaIcon(FontAwesomeIcons.whatsapp, color: Color(0xFF25D366)),
                                  tooltip: 'Share on WhatsApp',
                                  onPressed: () {/* TODO: Implement WhatsApp share */},
                                ),
                                IconButton(
                                  icon: const FaIcon(FontAwesomeIcons.facebook, color: Color(0xFF1877F3)),
                                  tooltip: 'Post to Facebook',
                                  onPressed: () {/* TODO: Implement Facebook share */},
                                ),
                                IconButton(
                                  icon: const Icon(Icons.image, color: accent),
                                  tooltip: 'Download as Image',
                                  onPressed: () {/* TODO: Implement download as image */},
                                ),
                                IconButton(
                                  icon: const Icon(Icons.copy, color: accent),
                                  tooltip: 'Copy Text',
                                  onPressed: () {/* TODO: Implement copy text */},
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
              child: Column(
                children: [
                  const Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _ctaButton('Read His Books', Icons.menu_book, () {/* TODO: Read Books */}),
                      _ctaButton('Watch His Messages', Icons.ondemand_video, () {/* TODO: Watch Messages */}),
                      _ctaButton('Submit a Testimony', Icons.edit, () {/* TODO: Submit Testimony */}),
                    ],
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _ctaButton(String label, IconData icon, VoidCallback onTap) {
    return TextButton.icon(
      onPressed: onTap,
      icon: Icon(icon, color: primaryBlue, size: 20),
      label: Text(
        label,
        style: const TextStyle(
          color: primaryBlue,
          fontWeight: FontWeight.w600,
          fontSize: 13,
        ),
      ),
      style: TextButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      ),
    );
  }
}
