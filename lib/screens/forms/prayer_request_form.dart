import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PrayerRequestForm extends StatefulWidget {
  const PrayerRequestForm({Key? key}) : super(key: key);

  @override
  State<PrayerRequestForm> createState() => _PrayerRequestFormState();
}

class _PrayerRequestFormState extends State<PrayerRequestForm> {
  final _formKey = GlobalKey<FormState>();
  final _scrollController = ScrollController();

  // Form fields
  String? fullName;
  String gender = 'Male';
  int? age;
  String? contactNumber;
  String? email;
  String? location;
  String? subject;
  String category = 'Healing';
  String? otherCategory;
  String? description;
  bool confidential = false;
  bool followUp = false;
  String? preferredContactTime;
  bool wantCall = false;
  DateTime? preferredPrayerDate;

  // Urgent Prayer Line
  bool urgentConfidential = false;
  bool urgentFollowUp = false;

  final List<String> genders = ['Male', 'Female', 'Prefer not to say'];
  final List<String> categories = [
    'Healing',
    'Family/Relationships',
    'Financial Breakthrough',
    'Deliverance',
    'Job/Career',
    'Studies/Exams',
    'Spiritual Growth',
    'Others',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text('Prayer Request', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        centerTitle: true,
        backgroundColor: const Color(0xFF1E40AF),
        elevation: 0,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(18)),
        ),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 140),
            child: SingleChildScrollView(
              controller: _scrollController,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Header Card
                    _buildHeaderCard(),
                    const SizedBox(height: 20),
                    
                    // Personal Information Section
                    _buildSectionHeader('Personal Information'),
                    const SizedBox(height: 12),
                    _buildTextField('Full Name', onSaved: (v) => fullName = v, validator: _requiredValidator),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: _buildDropdownField('Gender', genders, gender, (v) => setState(() => gender = v!)),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _buildTextField('Age',
                            keyboardType: TextInputType.number,
                            onSaved: (v) => age = int.tryParse(v ?? ''),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    _buildTextField('Contact Number',
                      keyboardType: TextInputType.phone,
                      onSaved: (v) => contactNumber = v,
                      validator: _requiredValidator,
                    ),
                    const SizedBox(height: 12),
                    _buildTextField('Email Address (optional)',
                      keyboardType: TextInputType.emailAddress,
                      onSaved: (v) => email = v,
                    ),
                    const SizedBox(height: 12),
                    _buildTextField('Location / City', onSaved: (v) => location = v),
                    
                    const SizedBox(height: 20),
                    
                    // Prayer Details Section
                    _buildSectionHeader('Prayer Details'),
                    const SizedBox(height: 12),
                    _buildTextField('Subject / Prayer Title', onSaved: (v) => subject = v, validator: _requiredValidator),
                    const SizedBox(height: 12),
                    _buildDropdownField('Prayer Category', categories, category, (v) => setState(() => category = v!)),
                    if (category == 'Others')
                      Padding(
                        padding: const EdgeInsets.only(top: 12),
                        child: _buildTextField('Other Category', onSaved: (v) => otherCategory = v),
                      ),
                    const SizedBox(height: 12),
                    _buildTextField('Prayer Request Description',
                      onSaved: (v) => description = v,
                      validator: _requiredValidator,
                      maxLines: 4,
                    ),
                    
                    const SizedBox(height: 20),
                    
                    // Preferences Section
                    _buildSectionHeader('Preferences'),
                    const SizedBox(height: 12),
                    _buildCheckboxTile(
                      'Confidential Request',
                      'Only pastoral team can view',
                      confidential,
                      (value) => setState(() => confidential = value ?? false),
                    ),
                    _buildSwitchTile(
                      'Follow-Up Request',
                      'Do you want a follow-up?',
                      followUp,
                      (value) => setState(() => followUp = value),
                    ),
                    if (followUp)
                      Padding(
                        padding: const EdgeInsets.only(top: 12),
                        child: _buildTextField('Preferred Contact Time', onSaved: (v) => preferredContactTime = v),
                      ),
                    _buildSwitchTile(
                      'Prayer Team Call',
                      'Do you want a prayer team member to call you?',
                      wantCall,
                      (value) => setState(() => wantCall = value),
                    ),
                    const SizedBox(height: 12),
                    _buildDateField('Preferred Prayer Date', preferredPrayerDate, (date) => setState(() => preferredPrayerDate = date)),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ),
          // Sticky Urgent Prayer Line
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: _buildUrgentPrayerLine(context),
          ),
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
                  Icons.self_improvement,
                  color: Colors.white,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Text(
                  'Submit Your Prayer Request',
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
            'We are here to pray with you. Share your prayer request and our team will intercede on your behalf.',
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

  Widget _buildTextField(String label, {TextInputType? keyboardType, void Function(String?)? onSaved, String? Function(String?)? validator, int maxLines = 1}) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: label,
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
        fillColor: Colors.white,
      ),
      keyboardType: keyboardType,
      onSaved: onSaved,
      validator: validator,
      maxLines: maxLines,
    );
  }

  Widget _buildDropdownField(String label, List<String> items, String value, void Function(String?)? onChanged) {
    return DropdownButtonFormField<String>(
      value: value,
      decoration: InputDecoration(
        labelText: label,
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
        fillColor: Colors.white,
      ),
      items: items.map((e) => DropdownMenuItem(
        value: e,
        child: Text(
          e,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontSize: 14),
        ),
      )).toList(),
      onChanged: onChanged,
      isExpanded: true,
      menuMaxHeight: 200,
    );
  }

  Widget _buildCheckboxTile(String title, String subtitle, bool value, void Function(bool?)? onChanged) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: CheckboxListTile(
        value: value,
        onChanged: onChanged,
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
        subtitle: Text(subtitle, style: TextStyle(color: Colors.grey.shade600, fontSize: 12)),
        controlAffinity: ListTileControlAffinity.leading,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        activeColor: const Color(0xFF1E40AF),
      ),
    );
  }

  Widget _buildSwitchTile(String title, String subtitle, bool value, void Function(bool)? onChanged) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: SwitchListTile(
        value: value,
        onChanged: onChanged,
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
        subtitle: Text(subtitle, style: TextStyle(color: Colors.grey.shade600, fontSize: 12)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        activeColor: const Color(0xFF1E40AF),
      ),
    );
  }

  Widget _buildDateField(String label, DateTime? value, void Function(DateTime) onChanged) {
    return GestureDetector(
      onTap: () async {
        final picked = await showDatePicker(
          context: context,
          initialDate: value ?? DateTime.now(),
          firstDate: DateTime.now().subtract(const Duration(days: 1)),
          lastDate: DateTime.now().add(const Duration(days: 365)),
        );
        if (picked != null) onChanged(picked);
      },
      child: AbsorbPointer(
        child: TextFormField(
          decoration: InputDecoration(
            labelText: label,
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
            fillColor: Colors.white,
            suffixIcon: const Icon(Icons.calendar_today, color: Color(0xFF1E40AF)),
          ),
          controller: TextEditingController(text: value != null ? DateFormat.yMMMMd().format(value) : ''),
        ),
      ),
    );
  }

  Widget _buildUrgentPrayerLine(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.red.shade50,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(Icons.emergency, color: Colors.red.shade600, size: 20),
                ),
                const SizedBox(width: 12),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Urgent Prayer Line',
                        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red, fontSize: 16),
                      ),
                      Text(
                        'Need immediate prayer support?',
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildCheckboxTile(
                    'Confidential',
                    'Keep request private',
                    urgentConfidential,
                    (value) => setState(() => urgentConfidential = value ?? false),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildSwitchTile(
                    'Follow-Up',
                    'Request follow-up call',
                    urgentFollowUp,
                    (value) => setState(() => urgentFollowUp = value),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _submitForm,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1E40AF),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                elevation: 2,
              ),
              child: const Text(
                'Submit Prayer Request',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String? _requiredValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'This field is required';
    }
    return null;
  }

  void _submitForm() {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: Row(
            children: [
              Icon(Icons.check_circle, color: Colors.green.shade600, size: 24),
              const SizedBox(width: 8),
              const Text('Prayer Request Submitted'),
            ],
          ),
          content: const Text(
            'Your prayer request has been received. Our team will pray and follow up as needed.',
            style: TextStyle(fontSize: 14),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK', style: TextStyle(color: Color(0xFF1E40AF))),
            ),
          ],
        ),
      );
      // TODO: Send data to backend/admin workflow
    }
  }
} 