import 'package:flutter/material.dart';
import 'services/firebase_service.dart';
import 'screens/splash_screen.dart';
import 'screens/auth/auth_screen.dart';
import 'screens/home/home_screen.dart';
import 'screens/forms/prayer_request_form.dart';
import 'screens/giving/helping_hands_screen.dart';
import 'screens/events/events_screen.dart';
import 'screens/contact_us_screen.dart';
import 'screens/about_us_screen.dart';
import 'screens/announcements_screen.dart';
import 'screens/ministry_wings_screen.dart';
import 'screens/upcoming_events_screen.dart';
import 'screens/resources/resources_vault_screen.dart';
import 'screens/platforms/digital_platforms_screen.dart';
import 'screens/branches/branch_locator_screen.dart';
import 'screens/books/books_screen.dart';
import 'screens/quotes/daily_quotes_screen.dart';
import 'screens/livestream/live_stream_screen.dart';
import 'screens/forms/forms_screen.dart';
import 'screens/departments/department_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Firebase
  await FirebaseService.initialize();
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'WCM Ministry App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/auth': (context) => const AuthScreen(),
        '/home': (context) => const HomeScreen(),
        '/prayer-request': (context) => const PrayerRequestForm(),
        '/helping-hands': (context) => const HelpingHandsScreen(),
        '/events': (context) => const EventsScreen(),
        '/contact': (context) => const ContactUsScreen(),
        '/about-us': (context) => const AboutUsScreen(),
        '/announcements': (context) => const AnnouncementsScreen(),
        '/ministry-wings': (context) => const MinistryWingsScreen(),
        '/upcoming-events': (context) => const UpcomingEventsScreen(),
        '/resources': (context) => const ResourcesVaultScreen(),
        '/digital-platforms': (context) => const DigitalPlatformsScreen(),
        '/branch-locator': (context) => const BranchLocatorScreen(),
        '/books': (context) => const BooksScreen(),
        '/daily-quotes': (context) => const DailyQuotesScreen(),
        '/live-stream': (context) => const LiveStreamScreen(),
        '/forms': (context) => const FormsScreen(),
        '/departments': (context) => const DepartmentScreen(),
        // Route gospel journeys to ministry wings since gospel outreach is covered there
        '/gospel-journeys': (context) => const MinistryWingsScreen(),
      },
    );
  }
}

// Placeholder screen for routes that don't have screens yet
class PlaceholderScreen extends StatelessWidget {
  final String title;
  
  const PlaceholderScreen({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        centerTitle: true,
        backgroundColor: const Color(0xFF1E40AF),
        elevation: 0,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(18)),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF667eea), Color(0xFF764ba2)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF667eea).withOpacity(0.3),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.construction,
                    color: Colors.white,
                    size: 48,
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1F2937),
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
                Text(
                  'This feature is under development and will be available soon.',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[600],
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),
                ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1E40AF),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text('Go Back'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
