import 'package:flutter/material.dart';
import '../../services/firebase_service.dart';
import '../home/home_screen.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  
  // Form controllers
  final TextEditingController _loginEmailController = TextEditingController();
  final TextEditingController _loginPasswordController = TextEditingController();
  final TextEditingController _registerNameController = TextEditingController();
  final TextEditingController _registerEmailController = TextEditingController();
  final TextEditingController _registerPhoneController = TextEditingController();
  final TextEditingController _registerPasswordController = TextEditingController();
  final TextEditingController _registerConfirmPasswordController = TextEditingController();

  // Loading states
  bool _isLoginLoading = false;
  bool _isRegisterLoading = false;

  // International App Design Colors
  final Color primaryColor = const Color(0xFF2196F3); // Material Blue
  final Color secondaryColor = const Color(0xFF03A9F4); // Light Blue
  final Color backgroundColor = const Color(0xFFFAFAFA); // Light Background
  final Color cardColor = Colors.white;
  final Color textPrimary = const Color(0xFF212121); // Dark Text
  final Color textSecondary = const Color(0xFF757575); // Secondary Text
  final Color successColor = const Color(0xFF4CAF50); // Green
  final Color errorColor = const Color(0xFFF44336); // Red

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _loginEmailController.dispose();
    _loginPasswordController.dispose();
    _registerNameController.dispose();
    _registerEmailController.dispose();
    _registerPhoneController.dispose();
    _registerPasswordController.dispose();
    _registerConfirmPasswordController.dispose();
    super.dispose();
  }

  // Login function
  Future<void> _handleLogin() async {
    if (_loginEmailController.text.isEmpty || _loginPasswordController.text.isEmpty) {
      _showErrorDialog('Please fill in all fields');
      return;
    }

    setState(() {
      _isLoginLoading = true;
    });

    try {
      var result = await FirebaseService.signInWithEmailAndPassword(
        _loginEmailController.text.trim(),
        _loginPasswordController.text,
      );

      if (result != null) {
        // Send push notification token
        await FirebaseService.sendPushNotificationToken();
        
        if (mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const HomeScreen()),
          );
        }
      } else {
        if (mounted) {
          _showErrorDialog('Invalid email or password');
        }
      }
    } catch (e) {
      if (mounted) {
        String errorMessage = 'Login failed';
        if (e.toString().contains('FirebaseAuthException')) {
          // Handle Firebase auth exceptions
          if (e.toString().contains('user-not-found')) {
            errorMessage = 'No user found with this email';
          } else if (e.toString().contains('wrong-password')) {
            errorMessage = 'Wrong password';
          } else if (e.toString().contains('invalid-email')) {
            errorMessage = 'Invalid email address';
          } else if (e.toString().contains('user-disabled')) {
            errorMessage = 'This account has been disabled';
          } else {
            errorMessage = 'Login failed: ${e.toString()}';
          }
        }
        _showErrorDialog(errorMessage);
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoginLoading = false;
        });
      }
    }
  }

  // Register function
  Future<void> _handleRegister() async {
    if (_registerNameController.text.isEmpty ||
        _registerEmailController.text.isEmpty ||
        _registerPhoneController.text.isEmpty ||
        _registerPasswordController.text.isEmpty ||
        _registerConfirmPasswordController.text.isEmpty) {
      _showErrorDialog('Please fill in all fields');
      return;
    }

    if (_registerPasswordController.text != _registerConfirmPasswordController.text) {
      _showErrorDialog('Passwords do not match');
      return;
    }

    if (_registerPasswordController.text.length < 6) {
      _showErrorDialog('Password must be at least 6 characters');
      return;
    }

    setState(() {
      _isRegisterLoading = true;
    });

    try {
      var result = await FirebaseService.createUserWithEmailAndPassword(
        _registerEmailController.text.trim(),
        _registerPasswordController.text,
        _registerNameController.text.trim(),
        _registerPhoneController.text.trim(),
      );

      if (result != null) {
        // Send push notification token
        await FirebaseService.sendPushNotificationToken();
        
        if (mounted) {
          _showSuccessDialog('Account created successfully!');
        }
      } else {
        if (mounted) {
          _showErrorDialog('Registration failed. Please try again.');
        }
      }
    } catch (e) {
      if (mounted) {
        String errorMessage = 'Registration failed';
        if (e.toString().contains('FirebaseAuthException')) {
          // Handle Firebase auth exceptions
          if (e.toString().contains('weak-password')) {
            errorMessage = 'Password is too weak';
          } else if (e.toString().contains('email-already-in-use')) {
            errorMessage = 'An account already exists with this email';
          } else if (e.toString().contains('invalid-email')) {
            errorMessage = 'Invalid email address';
          } else if (e.toString().contains('operation-not-allowed')) {
            errorMessage = 'Email/password accounts are not enabled';
          } else {
            errorMessage = 'Registration failed: ${e.toString()}';
          }
        }
        _showErrorDialog(errorMessage);
      }
    } finally {
      if (mounted) {
        setState(() {
          _isRegisterLoading = false;
        });
      }
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          backgroundColor: cardColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Text(
            'Error',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              fontFamily: 'Inter',
              color: errorColor,
            ),
          ),
          content: Text(
            message,
            style: TextStyle(
              fontSize: 16,
              fontFamily: 'Inter',
              color: textPrimary,
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: errorColor,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 0,
              ),
              onPressed: () {
                Navigator.of(dialogContext).pop();
              },
              child: const Text(
                'OK',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Inter',
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _showSuccessDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          backgroundColor: cardColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Text(
            'Success',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              fontFamily: 'Inter',
              color: successColor,
            ),
          ),
          content: Text(
            message,
            style: TextStyle(
              fontSize: 16,
              fontFamily: 'Inter',
              color: textPrimary,
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: successColor,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 0,
              ),
              onPressed: () {
                Navigator.of(dialogContext).pop();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const HomeScreen()),
                );
              },
              child: const Text(
                'Continue',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Inter',
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              // Header Section - Compact
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: primaryColor.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.church,
                        color: primaryColor,
                        size: 28,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Welcome to WCM',
                      style: TextStyle(
                        color: textPrimary,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Inter',
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Connect with your ministry community',
                      style: TextStyle(
                        color: textSecondary,
                        fontSize: 14,
                        fontFamily: 'Inter',
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              
              // Auth Container - Main Content
              Expanded(
                flex: 4,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: cardColor,
                    borderRadius: BorderRadius.circular(18),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.08),
                        blurRadius: 24,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      // Tab Bar - Compact
                      Container(
                        decoration: BoxDecoration(
                          color: backgroundColor,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: TabBar(
                          controller: _tabController,
                          indicator: BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          indicatorSize: TabBarIndicatorSize.tab,
                          labelColor: Colors.white,
                          unselectedLabelColor: textSecondary,
                          labelStyle: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                            fontFamily: 'Inter',
                          ),
                          unselectedLabelStyle: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            fontFamily: 'Inter',
                          ),
                          tabs: const [
                            Tab(text: 'Sign In'),
                            Tab(text: 'Sign Up'),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      
                      // Tab Content
                      Expanded(
                        child: TabBarView(
                          controller: _tabController,
                          children: [
                            _buildLoginTab(),
                            _buildRegisterTab(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              
              // Footer - Minimal
              Expanded(
                flex: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () {},
                      style: TextButton.styleFrom(
                        foregroundColor: primaryColor,
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                      ),
                      child: const Text(
                        'Privacy Policy',
                        style: TextStyle(
                          fontSize: 12,
                          fontFamily: 'Inter',
                        ),
                      ),
                    ),
                    Container(
                      width: 3,
                      height: 3,
                      decoration: BoxDecoration(
                        color: textSecondary,
                        shape: BoxShape.circle,
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      style: TextButton.styleFrom(
                        foregroundColor: primaryColor,
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                      ),
                      child: const Text(
                        'Terms of Service',
                        style: TextStyle(
                          fontSize: 12,
                          fontFamily: 'Inter',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLoginTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Welcome back!',
          style: TextStyle(
            color: textPrimary,
            fontSize: 18,
            fontWeight: FontWeight.w600,
            fontFamily: 'Inter',
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'Sign in to continue',
          style: TextStyle(
            color: textSecondary,
            fontSize: 14,
            fontFamily: 'Inter',
          ),
        ),
        const SizedBox(height: 20),
        
        _buildTextField(
          Icons.email_outlined, 
          'Email address',
          controller: _loginEmailController,
        ),
        const SizedBox(height: 12),
        _buildTextField(
          Icons.lock_outline, 
          'Password', 
          obscure: true,
          controller: _loginPasswordController,
        ),
        const SizedBox(height: 8),
        
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Checkbox(
                  value: false,
                  onChanged: (value) {},
                  activeColor: primaryColor,
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                Text(
                  'Remember me',
                  style: TextStyle(
                    color: textSecondary,
                    fontSize: 14,
                    fontFamily: 'Inter',
                  ),
                ),
              ],
            ),
            TextButton(
              onPressed: () {
                _showForgotPasswordDialog();
              },
              style: TextButton.styleFrom(
                foregroundColor: primaryColor,
                padding: EdgeInsets.zero,
              ),
              child: const Text(
                'Forgot password?',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Inter',
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        
        SizedBox(
          width: double.infinity,
          height: 48,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryColor,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 0,
              shadowColor: primaryColor.withOpacity(0.3),
            ),
            onPressed: _isLoginLoading ? null : _handleLogin,
            child: _isLoginLoading
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  )
                : const Text(
                    'Sign In',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Inter',
                    ),
                  ),
          ),
        ),
        const SizedBox(height: 16),
        
        // Social Login - Compact
        Row(
          children: [
            Expanded(child: Divider(color: Colors.grey.withOpacity(0.3))),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                'or continue with',
                style: TextStyle(
                  color: textSecondary,
                  fontSize: 14,
                  fontFamily: 'Inter',
                ),
              ),
            ),
            Expanded(child: Divider(color: Colors.grey.withOpacity(0.3))),
          ],
        ),
        const SizedBox(height: 16),
        
        SizedBox(
          width: double.infinity,
          child: _buildSocialButton(
            icon: Icons.g_mobiledata,
            label: 'Google',
            onPressed: () {},
          ),
        ),
      ],
    );
  }

  Widget _buildRegisterTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Create account',
          style: TextStyle(
            color: textPrimary,
            fontSize: 18,
            fontWeight: FontWeight.w600,
            fontFamily: 'Inter',
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'Join our ministry community',
          style: TextStyle(
            color: textSecondary,
            fontSize: 14,
            fontFamily: 'Inter',
          ),
        ),
        const SizedBox(height: 20),
        
        _buildTextField(
          Icons.person_outline, 
          'Full name',
          controller: _registerNameController,
        ),
        const SizedBox(height: 12),
        _buildTextField(
          Icons.email_outlined, 
          'Email address',
          controller: _registerEmailController,
        ),
        const SizedBox(height: 12),
        _buildTextField(
          Icons.phone_outlined, 
          'Phone number',
          controller: _registerPhoneController,
        ),
        const SizedBox(height: 12),
        _buildTextField(
          Icons.lock_outline, 
          'Password', 
          obscure: true,
          controller: _registerPasswordController,
        ),
        const SizedBox(height: 12),
        _buildTextField(
          Icons.lock_outline, 
          'Confirm password', 
          obscure: true,
          controller: _registerConfirmPasswordController,
        ),
        const SizedBox(height: 20),
        
        SizedBox(
          width: double.infinity,
          height: 48,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryColor,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 0,
              shadowColor: primaryColor.withOpacity(0.3),
            ),
            onPressed: _isRegisterLoading ? null : _handleRegister,
            child: _isRegisterLoading
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  )
                : const Text(
                    'Create Account',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Inter',
                    ),
                  ),
          ),
        ),
      ],
    );
  }

  Widget _buildTextField(
    IconData icon, 
    String hint, 
    {bool obscure = false, TextEditingController? controller}
  ) {
    return TextField(
      controller: controller,
      obscureText: obscure,
      style: TextStyle(
        color: textPrimary,
        fontSize: 16,
        fontFamily: 'Inter',
      ),
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: textSecondary, size: 20),
        labelText: hint,
        labelStyle: TextStyle(
          color: textSecondary,
          fontSize: 14,
          fontFamily: 'Inter',
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.withOpacity(0.3)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.withOpacity(0.3)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: primaryColor, width: 2),
        ),
        filled: true,
        fillColor: backgroundColor,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      ),
    );
  }

  Widget _buildSocialButton({
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
  }) {
    // Define brand colors and styles for internal app look
    Color buttonColor;
    Color iconColor;
    Color textColor;
    Color borderColor;
    IconData brandIcon;
    
    if (label == 'Google') {
      buttonColor = const Color(0xFFF8F9FA); // Light gray background
      iconColor = const Color(0xFFEA4335); // Google Red
      textColor = const Color(0xFF3C4043); // Dark gray text
      borderColor = const Color(0xFFDADCE0); // Light border
      brandIcon = Icons.g_mobiledata;
    } else if (label == 'Facebook') {
      buttonColor = const Color(0xFFF0F2F5); // Facebook light background
      iconColor = const Color(0xFF1877F2); // Facebook Blue
      textColor = const Color(0xFF1877F2); // Facebook Blue text
      borderColor = const Color(0xFFE4E6EB); // Light border
      brandIcon = Icons.facebook;
    } else {
      // Default styling
      buttonColor = const Color(0xFFF8F9FA);
      iconColor = textSecondary;
      textColor = textPrimary;
      borderColor = const Color(0xFFE0E0E0);
      brandIcon = icon;
    }

    return Container(
      height: 48,
      decoration: BoxDecoration(
        color: buttonColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: borderColor, width: 1.5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: onPressed,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: iconColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Icon(
                    brandIcon,
                    size: 18,
                    color: iconColor,
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Inter',
                    color: textColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showForgotPasswordDialog() {
    final TextEditingController emailController = TextEditingController();
    
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          backgroundColor: cardColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Text(
            'Reset Password',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              fontFamily: 'Inter',
              color: textPrimary,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Enter your registered email address to receive a password reset link.',
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: 'Inter',
                  color: textSecondary,
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                style: TextStyle(
                  color: textPrimary,
                  fontSize: 16,
                  fontFamily: 'Inter',
                ),
                decoration: InputDecoration(
                  labelText: 'Email address',
                  labelStyle: TextStyle(
                    color: textSecondary,
                    fontSize: 14,
                    fontFamily: 'Inter',
                  ),
                  prefixIcon: Icon(Icons.email_outlined, size: 20, color: textSecondary),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.grey.withOpacity(0.3)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: primaryColor, width: 2),
                  ),
                  filled: true,
                  fillColor: backgroundColor,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                ),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
              },
              child: Text(
                'Cancel',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Inter',
                  color: textSecondary,
                ),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 0,
                shadowColor: primaryColor.withOpacity(0.3),
              ),
              onPressed: () async {
                if (emailController.text.isNotEmpty) {
                  try {
                    await FirebaseService.sendPasswordResetEmail(emailController.text.trim());
                    Navigator.of(dialogContext).pop();
                    _showResetEmailSentDialog();
                  } catch (e) {
                    Navigator.of(dialogContext).pop();
                    String errorMessage = 'Failed to send reset email';
                    if (e.toString().contains('FirebaseAuthException')) {
                      // Handle Firebase auth exceptions
                      if (e.toString().contains('user-not-found')) {
                        errorMessage = 'No account found with this email address';
                      } else if (e.toString().contains('invalid-email')) {
                        errorMessage = 'Invalid email address';
                      } else {
                        errorMessage = 'Failed to send reset email: ${e.toString()}';
                      }
                    }
                    _showErrorDialog(errorMessage);
                  }
                }
              },
              child: const Text(
                'Send Reset Link',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Inter',
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _showResetEmailSentDialog() {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          backgroundColor: cardColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Text(
            'Reset Link Sent',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              fontFamily: 'Inter',
              color: textPrimary,
            ),
          ),
          content: Text(
            'If an account with that email exists, you will receive a password reset link shortly.',
            style: TextStyle(
              fontSize: 16,
              fontFamily: 'Inter',
              color: textSecondary,
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 0,
                shadowColor: primaryColor.withOpacity(0.3),
              ),
              onPressed: () {
                Navigator.of(dialogContext).pop();
              },
              child: const Text(
                'OK',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Inter',
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
