import 'package:flutter/material.dart';
import 'package:hemophilia_manager/auth/auth.dart';
import 'package:hemophilia_manager/services/firestore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CreateAccPage extends StatefulWidget {
  const CreateAccPage({super.key});

  @override
  State<CreateAccPage> createState() => _CreateAccPageState();
}

class _CreateAccPageState extends State<CreateAccPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  bool _isLoading = false;
  int _step = 0; // 0: registration, 1: role selection
  String? _error;
  String? _userUid;

  void _register() async {
    if (!_formKey.currentState!.validate()) return;

    final email = _emailController.text.trim();
    final password = _passwordController.text;
    final confirmPassword = _confirmPasswordController.text;
    final name = _nameController.text.trim();
    final phone = _phoneController.text.trim();

    if (password != confirmPassword) {
      _showError('Passwords do not match');
      return;
    }

    setState(() => _isLoading = true);
    try {
      final user = await AuthService().createAccount(email, password);
      if (user != null) {
        _userUid = user.uid;
        await FirestoreService().createUser(user.uid, name, email, ''); // role will be set later
        setState(() {
          _step = 1;
          _isLoading = false;
        });
      } else {
        _showError('Registration failed');
        setState(() => _isLoading = false);
      }
    } catch (e) {
      _showError(e.toString());
      setState(() => _isLoading = false);
    }
  }

  void _chooseRole(String role) async {
    setState(() => _isLoading = true);
    if (_userUid != null) {
      final name = _nameController.text.trim();
      final email = _emailController.text.trim();
      await FirestoreService().updateUser(_userUid!, name, email, role);
      if (role == 'patient') {
        if (!mounted) return;
        Navigator.pushReplacementNamed(context, '/user_screen');
      } else if (role == 'caregiver') {
        // TODO: Add caregiver navigation
      } else if (role == 'medical') {
        if (!mounted) return;
        Navigator.pushReplacementNamed(context, '/healthcare_main');
      }
    }
    setState(() => _isLoading = false);
  }

  void _showError(String message) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Error'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Center(
          child: SingleChildScrollView(
            child: _step == 0
                ? Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Text(
                            'RedSyncPH',
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: Colors.redAccent,
                              letterSpacing: 1.2,
                            ),
                          ),
                        ),
                        SizedBox(height: 36),
                        Text(
                          'Create your account',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                        SizedBox(height: 28),
                        TextFormField(
                          controller: _nameController,
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.person_outline,
                              color: Colors.redAccent,
                            ),
                            labelText: 'Full Name',
                            border: UnderlineInputBorder(),
                          ),
                          keyboardType: TextInputType.name,
                          validator: (value) {
                            if (value == null || value.isEmpty) return 'Enter name';
                            return null;
                          },
                        ),
                        SizedBox(height: 18),
                        TextFormField(
                          controller: _emailController,
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.email_outlined,
                              color: Colors.redAccent,
                            ),
                            labelText: 'Email',
                            border: UnderlineInputBorder(),
                          ),
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value == null || value.isEmpty) return 'Enter email';
                            if (!value.contains('@')) return 'Enter valid email';
                            return null;
                          },
                        ),
                        SizedBox(height: 18),
                        TextFormField(
                          controller: _passwordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.lock_outline,
                              color: Colors.redAccent,
                            ),
                            labelText: 'Password',
                            border: UnderlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Enter password';
                            }
                            if (value.length < 6) {
                              return 'Password must be at least 6 characters';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 18),
                        TextFormField(
                          controller: _confirmPasswordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.lock_outline,
                              color: Colors.redAccent,
                            ),
                            labelText: 'Confirm Password',
                            border: UnderlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Confirm your password';
                            }
                            if (value != _passwordController.text) {
                              return 'Passwords do not match';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 28),
                        SizedBox(
                          width: double.infinity,
                          child: FilledButton(
                            onPressed: _isLoading ? null : _register,
                            style: FilledButton.styleFrom(
                              backgroundColor: Colors.redAccent,
                              padding: EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: _isLoading
                                ? CircularProgressIndicator(color: Colors.white)
                                : Text(
                                    'Next',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                    ),
                                  ),
                          ),
                        ),
                        SizedBox(height: 15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Already have an account?',
                              style: TextStyle(color: Colors.black87),
                            ),
                            TextButton(
                              style: TextButton.styleFrom(
                                foregroundColor: Colors.blue,
                                padding: EdgeInsets.zero,
                              ),
                              child: Text(
                                'Login',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              onPressed: () {
                                Navigator.pushReplacementNamed(context, '/login');
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'What type of account do you want to create?',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                      SizedBox(height: 24),
                      AccountList(
                        listIcon: FontAwesomeIcons.person,
                        listTitle: 'I\'m a Patient',
                        listSubtitle: 'I want to track my own health',
                        color: Colors.redAccent,
                        onTap: () => _chooseRole('patient'),
                      ),
                      SizedBox(height: 12),
                      AccountList(
                        listIcon: FontAwesomeIcons.personBreastfeeding,
                        listTitle: 'I\'m a Caregiver',
                        listSubtitle: 'I want to track someone else\'s health',
                        color: Colors.orangeAccent,
                        onTap: () => _chooseRole('caregiver'),
                      ),
                      SizedBox(height: 12),
                      AccountList(
                        listIcon: FontAwesomeIcons.userDoctor,
                        listTitle: 'I\'m a Medical Professional',
                        listSubtitle: 'I want to track patients who have hemophilia',
                        color: Colors.blueAccent,
                        onTap: () => _chooseRole('medical'),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}

class AccountList extends StatelessWidget {
  final String listTitle;
  final String listSubtitle;
  final IconData listIcon;
  final VoidCallback onTap;
  final Color color;

  const AccountList({
    super.key,
    required this.listTitle,
    required this.listIcon,
    required this.listSubtitle,
    required this.onTap,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      // ignore: deprecated_member_use
      tileColor: color.withOpacity(0.1),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      leading: Icon(listIcon, size: 32, color: color),
      title: Text(
        listTitle,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: color,
          fontSize: 17,
        ),
      ),
      subtitle: Text(
        listSubtitle,
        style: TextStyle(
          color: Colors.black87,
          fontSize: 14,
        ),
      ),
      trailing: Icon(Icons.arrow_forward_ios, color: color, size: 20),
      onTap: onTap,
    );
  }
}
