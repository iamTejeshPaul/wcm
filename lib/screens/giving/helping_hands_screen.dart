import 'package:flutter/material.dart';

class HelpingHandsScreen extends StatefulWidget {
  const HelpingHandsScreen({Key? key}) : super(key: key);

  @override
  State<HelpingHandsScreen> createState() => _HelpingHandsScreenState();
}

class _HelpingHandsScreenState extends State<HelpingHandsScreen> {
  // Mock login state
  final bool isLoggedIn = false; // TODO: Replace with real auth

  // Mock data
  final List<Map<String, String>> impactGallery = [
    {
      'title': 'Serving Widows',
      'subtitle': 'Galatians 6:2',
      'image': '', // TODO: Add asset or network image
    },
    {
      'title': 'Caring for Orphans',
      'subtitle': 'James 1:27',
      'image': '',
    },
    {
      'title': 'Medical Camps',
      'subtitle': 'Healing & Hope',
      'image': '',
    },
    {
      'title': 'Food Distribution',
      'subtitle': 'Feeding the Hungry',
      'image': '',
    },
  ];

  final List<Map<String, dynamic>> donationCauses = [
    {
      'icon': Icons.favorite,
      'title': 'Support Daily Needs',
      'desc': 'Widows, orphans, poor',
      'target': null,
      'progress': null,
    },
    {
      'icon': Icons.tv,
      'title': 'Sponsor a Gospel Meeting',
      'desc': '₹25,000 per meeting',
      'target': 25000,
      'progress': 0.4,
    },
    {
      'icon': Icons.video_call,
      'title': 'Sponsor Video Messages',
      'desc': 'on TV',
      'target': null,
      'progress': null,
    },
    {
      'icon': Icons.menu_book,
      'title': 'Fund Books & Tracts',
      'desc': 'Publication',
      'target': null,
      'progress': null,
    },
    {
      'icon': Icons.local_hospital,
      'title': 'Medical/Charity Work',
      'desc': 'Camps & Rehab',
      'target': null,
      'progress': null,
    },
    {
      'icon': Icons.account_balance,
      'title': 'Build Churches',
      'desc': 'Infrastructure',
      'target': null,
      'progress': null,
    },
    {
      'icon': Icons.school,
      'title': 'Sponsor Apologetics Debates',
      'desc': '',
      'target': null,
      'progress': null,
    },
  ];

  final List<Map<String, dynamic>> campaignHighlights = [
    {
      'title': 'Bless 100 Families This Christmas',
      'desc': 'Help us reach our goal!',
      'progress': 0.7,
      'target': 100,
      'current': 70,
    },
  ];

  void _showDonationModal(Map<String, dynamic> cause) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            left: 20,
            right: 20,
            top: 24,
            bottom: MediaQuery.of(context).viewInsets.bottom + 24,
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Icon(cause['icon'], color: const Color(0xFF1E40AF), size: 28),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        cause['title'],
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                _buildFormField('Name', 'Enter your full name'),
                const SizedBox(height: 12),
                _buildFormField('Email or Phone', 'Enter your contact'),
                const SizedBox(height: 12),
                _buildFormField('Donation Amount', 'Min ₹50', keyboardType: TextInputType.number),
                const SizedBox(height: 12),
                _buildCheckboxTile('Give Monthly', 'Set up recurring donation'),
                const SizedBox(height: 8),
                _buildFormField('Message/Prayer Note', 'Optional', maxLines: 2),
                const SizedBox(height: 12),
                _buildCheckboxTile('Give in Honour of Someone', 'Dedicate your donation'),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.qr_code, size: 18),
                        label: const Text('Pay via QR', style: TextStyle(fontSize: 14)),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF1E40AF),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.payment, size: 18),
                        label: const Text('Other Methods', style: TextStyle(fontSize: 14)),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: const Color(0xFF1E40AF),
                          side: const BorderSide(color: Color(0xFF1E40AF)),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      _showThankYouDialog();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1E40AF),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      elevation: 2,
                    ),
                    child: const Text(
                      'Donate Now',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildFormField(String label, String hint, {TextInputType? keyboardType, int maxLines = 1}) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF1E40AF), width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        filled: true,
        fillColor: Colors.grey.shade50,
      ),
      keyboardType: keyboardType,
      maxLines: maxLines,
    );
  }

  Widget _buildCheckboxTile(String title, String subtitle) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: CheckboxListTile(
        value: false,
        onChanged: (_) {},
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
        subtitle: Text(subtitle, style: TextStyle(color: Colors.grey.shade600, fontSize: 12)),
        controlAffinity: ListTileControlAffinity.leading,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        activeColor: const Color(0xFF1E40AF),
      ),
    );
  }

  void _showThankYouDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Row(
          children: [
            Icon(Icons.check_circle, color: Colors.green.shade600, size: 24),
            const SizedBox(width: 8),
            const Text('Thank You!'),
          ],
        ),
        content: const Text(
          'Your donation was received. A receipt will be sent to your email.',
          style: TextStyle(fontSize: 14),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK', style: TextStyle(color: Color(0xFF1E40AF))),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: const Text('Helping Hands', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        centerTitle: true,
        backgroundColor: const Color(0xFF1E40AF),
        elevation: 0,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(18)),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        children: [
          // Header Card
          _buildHeaderCard(),
          const SizedBox(height: 24),
          
          // Campaign Highlights
          if (campaignHighlights.isNotEmpty) ...[
            _buildSectionHeader('Current Campaign'),
            const SizedBox(height: 12),
            ...campaignHighlights.map((c) => _buildCampaignHighlight(c)).toList(),
            const SizedBox(height: 24),
          ],
          
          // Impact Gallery
          _buildSectionHeader('Our Impact'),
          const SizedBox(height: 12),
          SizedBox(
            height: 140,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: impactGallery.length,
              separatorBuilder: (_, __) => const SizedBox(width: 12),
              itemBuilder: (context, i) {
                final item = impactGallery[i];
                return AnimatedOpacity(
                  opacity: 1.0,
                  duration: Duration(milliseconds: 400 + i * 80),
                  child: _buildImpactCard(item),
                );
              },
            ),
          ),
          const SizedBox(height: 24),
          
          // Give Generously
          _buildSectionHeader('Give Generously'),
          const SizedBox(height: 12),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 0.75,
            ),
            itemCount: donationCauses.length,
            itemBuilder: (context, i) {
              final cause = donationCauses[i];
              return AnimatedOpacity(
                opacity: 1.0,
                duration: Duration(milliseconds: 400 + i * 80),
                child: _buildCauseCard(cause),
              );
            },
          ),
          const SizedBox(height: 24),
          
          // Volunteer & Fundraiser CTAs
          _buildSectionHeader('Get Involved'),
          const SizedBox(height: 12),
          _buildVolunteerFundraiserRow(),
          const SizedBox(height: 24),
          
          // My Giving Dashboard (if logged in)
          if (isLoggedIn) ...[
            _buildSectionHeader('My Giving'),
            const SizedBox(height: 12),
            _buildGivingDashboard(),
            const SizedBox(height: 24),
          ],
          
          // Footer
          const Divider(),
          const SizedBox(height: 16),
          const Text(
            'Follow us and share the Word. Stay blessed with daily updates from WCM Ministries.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.grey),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildHeaderCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF667eea), Color(0xFF764ba2)],
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.volunteer_activism,
                  color: Colors.white,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Text(
                  'Be a Blessing',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Text(
            'Join us in touching lives and expanding God\'s Kingdom through your generous support.',
            style: TextStyle(
              fontSize: 14,
              color: Colors.white,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFF1E40AF).withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Color(0xFF1E40AF),
        ),
      ),
    );
  }

  Widget _buildImpactCard(Map<String, String> item) {
    return Container(
      width: 160,
      height: 140,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: const Color(0xFF1E40AF).withOpacity(0.1),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Icon(Icons.image, size: 20, color: const Color(0xFF1E40AF)),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item['title'] ?? '',
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    item['subtitle'] ?? '',
                    style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                  side: const BorderSide(color: Color(0xFF1E40AF)),
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                  minimumSize: const Size(0, 28),
                ),
                child: const Text(
                  'View Gallery',
                  style: TextStyle(color: Color(0xFF1E40AF), fontWeight: FontWeight.bold, fontSize: 11),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCauseCard(Map<String, dynamic> cause) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: const Color(0xFF1E40AF).withOpacity(0.1),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Icon(cause['icon'], size: 20, color: const Color(0xFF1E40AF)),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    cause['title'],
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    cause['desc'],
                    style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (cause['target'] != null) ...[
                    const SizedBox(height: 6),
                    LinearProgressIndicator(
                      value: cause['progress'] ?? 0.0,
                      backgroundColor: Colors.grey.shade200,
                      color: const Color(0xFF1E40AF),
                      minHeight: 3,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Target: ₹${cause['target']}',
                      style: TextStyle(fontSize: 9, color: Colors.grey.shade600),
                    ),
                  ],
                ],
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => _showDonationModal(cause),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1E40AF),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  elevation: 0,
                ),
                child: const Text(
                  'Give Now',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCampaignHighlight(Map<String, dynamic> c) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.orange.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.orange.shade200),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.orange.shade100,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(Icons.campaign, color: Colors.orange.shade700, size: 20),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    c['title'],
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              c['desc'],
              style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
            ),
            const SizedBox(height: 12),
            LinearProgressIndicator(
              value: c['progress'],
              backgroundColor: Colors.orange.shade100,
              color: Colors.orange,
              minHeight: 6,
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${c['current']} of ${c['target']} families blessed',
                  style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                ),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    elevation: 0,
                  ),
                  child: const Text(
                    'Give Now',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVolunteerFundraiserRow() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _buildActionButton(
                'Become a Volunteer',
                Icons.volunteer_activism,
                () {},
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildActionButton(
                'Start a Fundraiser',
                Icons.campaign,
                () {},
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        SizedBox(
          width: double.infinity,
          child: _buildActionButton(
            'Refer to a Friend',
            Icons.share,
            () {},
          ),
        ),
      ],
    );
  }

  Widget _buildActionButton(String title, IconData icon, VoidCallback onPressed) {
    return OutlinedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, color: const Color(0xFF1E40AF), size: 18),
      label: Text(
        title,
        style: const TextStyle(color: Color(0xFF1E40AF), fontWeight: FontWeight.w600, fontSize: 13),
        textAlign: TextAlign.center,
      ),
      style: OutlinedButton.styleFrom(
        side: const BorderSide(color: Color(0xFF1E40AF)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        padding: const EdgeInsets.symmetric(vertical: 12),
      ),
    );
  }

  Widget _buildGivingDashboard() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1E40AF).withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFF1E40AF).withOpacity(0.2)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.dashboard, color: const Color(0xFF1E40AF), size: 20),
                const SizedBox(width: 8),
                const Text(
                  'My Giving Dashboard',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Color(0xFF1E40AF)),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text('Total Given: ₹0 (lifetime)', style: TextStyle(fontSize: 14, color: Colors.grey.shade700)),
            Text('Causes Supported: 0', style: TextStyle(fontSize: 14, color: Colors.grey.shade700)),
            const SizedBox(height: 8),
            Text(
              'Receipts and recurring donations will appear here.',
              style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
            ),
          ],
        ),
      ),
    );
  }
} 