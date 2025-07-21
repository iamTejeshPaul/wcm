import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DailyQuoteCard extends StatefulWidget {
  final VoidCallback? onTap;
  const DailyQuoteCard({Key? key, this.onTap}) : super(key: key);

  @override
  State<DailyQuoteCard> createState() => _DailyQuoteCardState();
}

class _DailyQuoteCardState extends State<DailyQuoteCard> {
  static const Color primaryBlue = Color(0xFF1E3A8A);
  static const Color cardColor = Color(0xFFFFFFFF);
  static const Color textPrimary = Color(0xFF1E293B);
  static const Color textSecondary = Color(0xFF64748B);

  final List<String> languages = [
    'English', 'Tamil', 'Hindi', 'Telugu', 'Malayalam', 'Kannada'
  ];
  String selectedLanguage = 'English';

  final Map<String, dynamic> quote = {
    'date': DateTime(2025, 6, 23),
    'text': 'Faith is not a feeling. It is a decision to trust God even when the road ahead is uncertain.',
    'author': 'Kiran Paul',
    'role': 'Founder & Chairman, WCM Ministry',
    'translations': {
      'English': 'Faith is not a feeling. It is a decision to trust God even when the road ahead is uncertain.',
      'Tamil': 'நம்பிக்கை ஒரு உணர்வு அல்ல. எதிர்காலம் தெரியாதபோதும் தேவனை நம்ப முடிவு செய்வதே நம்பிக்கை.',
      'Hindi': 'विश्वास एक भावना नहीं है। यह एक निर्णय है कि जब आगे का रास्ता अनिश्चित हो तब भी परमेश्वर पर भरोसा करें।',
      'Telugu': 'విశ్వాసం అనేది ఒక భావోద్వేగం కాదు. ముందున్న మార్గం అనిశ్చితమైనప్పుడు కూడా దేవుని నమ్మే నిర్ధారం.',
      'Malayalam': 'വിശ്വാസം ഒരു അനുഭവം അല്ല. മുന്നിലുള്ള വഴി അനിശ്ചിതമായിരിക്കുമ്പോഴും ദൈവത്തിൽ വിശ്വസിക്കാൻ എടുത്ത തീരുമാനമാണ്.',
      'Kannada': 'ವಿಶ್ವಾಸವು ಒಂದು ಭಾವನೆ ಅಲ್ಲ. ಮುಂದె ಏನು ಎಂಬುದು ಗೊತ್ತಿಲ್ಲದಿದ್ದರೂ ದೇವರನ್ನು ನಂಬುವ ನಿರ್ಧಾರ.'
    }
  };

  @override
  Widget build(BuildContext context) {
    final quoteText = quote['translations'][selectedLanguage] ?? quote['text'];
    final date = DateFormat.yMMMMd().format(quote['date']);
    return GestureDetector(
      onTap: widget.onTap,
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        color: cardColor,
        margin: const EdgeInsets.symmetric(vertical: 8),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(Icons.format_quote, color: primaryBlue, size: 22),
                  const SizedBox(width: 8),
                  Expanded(
                    child: DropdownButton<String>(
                      value: selectedLanguage,
                      underline: const SizedBox(),
                      isDense: true,
                      items: languages.map((lang) => DropdownMenuItem(
                        value: lang,
                        child: Text(lang, style: const TextStyle(fontSize: 13)),
                      )).toList(),
                      onChanged: (val) {
                        if (val != null) setState(() => selectedLanguage = val);
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text(
                '“$quoteText”',
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: textPrimary,
                  height: 1.3,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                '— ${quote['author']}, ${quote['role']}',
                style: const TextStyle(
                  fontSize: 13,
                  color: textSecondary,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                date,
                style: const TextStyle(
                  fontSize: 12,
                  color: textSecondary,
                ),
              ),
              const SizedBox(height: 6),
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  'Tap for more',
                  style: TextStyle(
                    color: primaryBlue.withOpacity(0.7),
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
} 