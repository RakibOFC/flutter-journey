import 'package:flutter/material.dart';
import 'package:flutter_journey/database/database_helper.dart';
import 'package:flutter_journey/util/values.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  String _username = '';
  String _password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Image.asset(
                        'assets/images/flutter.png',
                        width: 70.0,
                        height: 70.0,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    _buildTextFormField(
                        labelText: 'Username',
                        onSaved: (value) => _username = value!),
                    _buildTextFormField(
                        labelText: 'Password',
                        onSaved: (value) => _password = value!,
                        obscureText: true),
                    const SizedBox(height: 20),
                    ElevatedButton(
                        onPressed: _login, child: const Text('Login')),
                    const SizedBox(
                      height: 20.0,
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/registration');
                        },
                        child: const Text(
                            'Don’t have an account? Register here.')),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextFormField({
    required String labelText,
    required FormFieldSetter<String> onSaved,
    bool obscureText = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: labelText,
          border: const OutlineInputBorder(),
        ),
        obscureText: obscureText,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter your ${labelText.toLowerCase()}';
          }
          return null;
        },
        onSaved: onSaved,
      ),
    );
  }

  void _login() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      _performLogin();
    }
  }

  Future<void> _performLogin() async {

    final user = await DatabaseHelper.instance.getUser(_username, _password);
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    if (!mounted) return;

    if (user != null) {
      // Login successful
      int userId = user.id!;
      prefs.setBool(Values.isLoggedInKey, true);
      prefs.setInt(Values.userIdKey, userId);

      Navigator.pushReplacementNamed(context, '/dashboard', arguments: userId);
    } else {
      // Invalid credentials
      _showMessage('Invalid username or password.');
    }
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}
