import 'package:flutter/material.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  RegistrationPageState createState() => RegistrationPageState();
}

class RegistrationPageState extends State<RegistrationPage> {
  final _formKey = GlobalKey<FormState>();

  String _name = '';
  String _username = '';
  String _password = '';
  String _phone = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
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
                const SizedBox(height: 20),
                _buildTextFormField(
                  labelText: 'Name',
                  onSaved: (value) => _name = value!,
                ),
                _buildTextFormField(
                  labelText: 'Username',
                  onSaved: (value) => _username = value!,
                ),
                _buildTextFormField(
                  labelText: 'Password',
                  obscureText: true,
                  onSaved: (value) => _password = value!,
                ),
                _buildTextFormField(
                  labelText: 'Phone',
                  onSaved: (value) => _phone = value!,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _register,
                  child: const Text('Register'),
                ),
              ],
            ),
          ),
        ),
      ),
    ));
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

  void _register() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Registering...')),
      );
    }
  }
}
