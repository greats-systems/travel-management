import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:travel_management_app_2/auth/auth_service.dart';
import 'package:travel_management_app_2/components/my_button.dart';
import 'package:travel_management_app_2/components/my_date_picker.dart';
import 'package:travel_management_app_2/components/my_sized_box.dart';
import 'package:travel_management_app_2/components/my_text_field.dart';
import 'package:travel_management_app_2/constants.dart' as constants;
import 'package:travel_management_app_2/auth/models/mobile_user.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // Controllers
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _dobController = TextEditingController();
  final _vehicleRegNumberController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  // Focus node
  final _phoneFocusNode = FocusNode();

  // State variables
  String? _role;
  String? _licenseClass;
  String _completePhoneNumber = '';

  // Services
  final AuthService _authService = AuthService();

  // Constants
  static const _roles = ['traveller', 'driver'];
  static const _licenseClasses = ['1', '2', '3', '4'];
  static const _borderRadius = BorderRadius.all(Radius.circular(15));

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _phoneNumberController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _phoneFocusNode.dispose();
    super.dispose();
  }

  void _setRoleDropdownValue(String? value) {
    if (value == null) return;

    setState(() => _role = value);
    log('Selected role: $_role');
  }

  void _setLicenseClassDropdownValue(String? value) {
    if (value == null) return;

    setState(() => _licenseClass = value);
    log('Selected license class: $_licenseClass');
  }

  Future<void> _signUp() async {
    final user =
        MobileUser()
          ..firstName = _firstNameController.text.trim()
          ..lastName = _lastNameController.text.trim()
          ..phone = _completePhoneNumber.trim()
          ..email = _emailController.text.trim()
          ..role = _role
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
      await _authService.signUpWithEmailAndPassword(user, password);
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

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final horizontalPadding = screenWidth / 10;
    final topPadding = screenWidth / 4;

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

              // First name
              _buildTextField(
                controller: _firstNameController,
                hintText: 'First name',
                keyboardType: TextInputType.name,
              ),
              MySizedBox(),

              // Last name
              _buildTextField(
                controller: _lastNameController,
                hintText: 'Last name',
                keyboardType: TextInputType.name,
              ),
              MySizedBox(),

              // Phone number field
              _buildPhoneNumberField(),

              // Email field
              _buildTextField(
                controller: _emailController,
                hintText: 'Email',
                keyboardType: TextInputType.emailAddress,
              ),
              MySizedBox(),

              // Role dropdown
              _buildRolesDropdown(),
              MySizedBox(),

              _role == 'driver' ? _buildDriverRegistrationForm() : MySizedBox(),

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
            ],
          ),
        ),
      ),
    );
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

  Widget _buildPhoneNumberField() {
    return IntlPhoneField(
      controller: _phoneNumberController,
      focusNode: _phoneFocusNode,
      decoration: const InputDecoration(
        labelText: 'Phone Number',
        border: OutlineInputBorder(borderRadius: _borderRadius),
      ),
      initialCountryCode: 'ZW',
      onChanged: (PhoneNumber phone) {
        _completePhoneNumber = phone.completeNumber;
        debugPrint('Complete phone number: $_completePhoneNumber');
      },
      onCountryChanged: (country) {
        debugPrint('Country changed to ${country.name}');
      },
    );
  }

  Widget _buildRolesDropdown() {
    return DropdownButtonFormField<String>(
      borderRadius: const BorderRadius.all(Radius.circular(12)),
      decoration: const InputDecoration(
        border: OutlineInputBorder(borderRadius: _borderRadius),
      ),
      isExpanded: true,
      hint: const Text('Select Role'),
      items:
          _roles
              .map(
                (role) => DropdownMenuItem(
                  value: role,
                  child: Text(role.capitalize()),
                ),
              )
              .toList(),
      value: _role,
      onChanged: _setRoleDropdownValue,
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
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1)}";
  }
}
