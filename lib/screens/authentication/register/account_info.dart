import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:travel_management_app_2/auth/auth_service.dart';
import 'package:travel_management_app_2/auth/models/mobile_user.dart';
import 'package:travel_management_app_2/components/my_button.dart';
import 'package:travel_management_app_2/components/my_date_picker.dart';
import 'package:travel_management_app_2/components/my_sized_box.dart';
import 'package:travel_management_app_2/components/my_text_field.dart';
import 'package:travel_management_app_2/constants.dart' as constants;

class AccountInfo extends StatefulWidget {
  final MobileUser mobileUser;
  const AccountInfo({super.key, required this.mobileUser});

  @override
  State<AccountInfo> createState() => _AccountInfoState();
}

class _AccountInfoState extends State<AccountInfo> {
  final _dobController = TextEditingController();
  final _vehicleRegNumberController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  String? _licenseClass;
  static const _licenseClasses = ['1', '2', '3', '4'];
  static const _borderRadius = BorderRadius.all(Radius.circular(15));

  // Services
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final horizontalPadding = screenWidth / 10;
    final topPadding = screenWidth / 24;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
            top: topPadding,
            left: horizontalPadding,
            right: horizontalPadding,
          ),
          child: ListView(
            children: [
              // Logo
              Center(child: Image.asset(constants.logoURL)),
              MySizedBox(),
              widget.mobileUser.role == 'driver'
                  ? _buildDriverRegistrationForm()
                  : MySizedBox(),
              // Password field
              _buildTextField(
                controller: _passwordController,
                hintText: 'Password',
                obscureText: true,
              ),
              MySizedBox(),

              // Confirm password field
              _buildTextField(
                controller: _confirmPasswordController,
                hintText: 'Confirm password',
                obscureText: true,
              ),
              MySizedBox(),

              // Sign up button
              MyButton(
                onTap: _signUp,
                text: 'Sign Up',
                color: Colors.blue.shade700,
              ),

              // Login link
              Center(
                child: TextButton(
                  onPressed: () => Navigator.pushNamed(context, '/auth-gate'),
                  child: const Text(
                    'Log In',
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
              ),

              // Previous page
              Center(
                child: TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text(
                    'Previous',
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLicenseClassDropdown() {
    return DropdownButtonFormField<String>(
      borderRadius: const BorderRadius.all(Radius.circular(12)),
      decoration: const InputDecoration(
        border: OutlineInputBorder(borderRadius: _borderRadius),
      ),
      isExpanded: true,
      hint: const Text('License class'),
      items:
          _licenseClasses
              .map(
                (license) =>
                    DropdownMenuItem(value: license, child: Text(license)),
              )
              .toList(),
      value: _licenseClass,
      onChanged: _setLicenseClassDropdownValue,
    );
  }

  void _setLicenseClassDropdownValue(String? value) {
    if (value == null) return;

    setState(() => _licenseClass = value);
    log('Selected license class: $_licenseClass');
  }

  Widget _buildDateOfBirthField(TextEditingController controller) {
    return MyDatePicker(
      helpText: 'Date of birth',
      fieldLabelText: 'Date of birth',
      labelText: 'Date of birth',
      controller: controller,
      firstDate: DateTime(DateTime.now().year - 60),
      lastDate: DateTime.now(),
    );
  }

  int calculateAge(DateTime birthDate) {
    final now = DateTime.now();
    int age = now.year - birthDate.year;

    // Adjust if birthday hasn't occurred yet this year
    if (now.month < birthDate.month ||
        (now.month == birthDate.month && now.day < birthDate.day)) {
      age--;
    }

    return age;
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    TextInputType keyboardType = TextInputType.text,
    bool obscureText = false,
  }) {
    return MyTextField(
      controller: controller,
      hintText: hintText,
      textInputType: keyboardType,
      obscureText: obscureText,
    );
  }

  Widget _buildDriverRegistrationForm() {
    return Column(
      children: [
        _buildDateOfBirthField(_dobController),
        MySizedBox(),
        _buildLicenseClassDropdown(),
        MySizedBox(),
        _buildTextField(
          controller: _vehicleRegNumberController,
          hintText: 'Vehicle registration number',
        ),
        MySizedBox(),
      ],
    );
  }

  Future<void> _signUp() async {
    widget.mobileUser
      ..licenseClass = _licenseClass
      ..dob = _dobController.text.trim()
      ..vehicleRegNumber = _vehicleRegNumberController.text.trim();

    final password = _passwordController.text;
    final confirmPassword = _confirmPasswordController.text;

    if (password != confirmPassword) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Passwords do not match')));
      }
      return;
    }

    try {
      await _authService.signUpWithEmailAndPassword(
        widget.mobileUser,
        password,
      );
      if (mounted) {
        Navigator.pushNamed(context, '/auth-gate');
      }
    } catch (e) {
      if (!mounted) return;

      final errorMessage = switch (e) {
        AuthApiException() => e.toString(),
        AuthWeakPasswordException() =>
          'Your password should have at least 6 characters',
        _ => 'An unexpected error occurred',
      };

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(errorMessage),
          duration: const Duration(seconds: 5),
        ),
      );
      debugPrint('Sign up error: $e');
    }
  }
}
