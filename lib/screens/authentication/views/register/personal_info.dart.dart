import 'dart:convert';

import 'package:flutter/material.dart';
import 'dart:developer';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:travel_management_app_2/auth/models/mobile_user.dart';
import 'package:travel_management_app_2/components/my_sized_box.dart';
import 'package:travel_management_app_2/components/my_text_field.dart';
import 'package:travel_management_app_2/constants.dart' as constants;
import 'package:travel_management_app_2/screens/authentication/register/account_info.dart';

class PersonalInfo extends StatefulWidget {
  const PersonalInfo({super.key});

  @override
  State<PersonalInfo> createState() => _PersonalInfoState();
}

class _PersonalInfoState extends State<PersonalInfo> {
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneFocusNode = FocusNode();

  String _completePhoneNumber = '';
  static const _borderRadius = BorderRadius.all(Radius.circular(15));
  String? _role;
  static const _roles = ['traveller', 'driver'];

  void _setRoleDropdownValue(String? value) {
    if (value == null) return;

    setState(() => _role = value);
    log('Selected role: $_role');
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final horizontalPadding = mediaQuery.size.width / 10;
    final topPadding = mediaQuery.size.width / 10;

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

              // Next page
              _navigateToNextPage(),
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

  Widget _navigateToNextPage() {
    MobileUser mobileUser = MobileUser();
    mobileUser
      ..firstName = _firstNameController.text.trim()
      ..lastName = _lastNameController.text.trim()
      ..phone = _completePhoneNumber.trim()
      ..email = _emailController.text.trim()
      ..role = _role;
    log(JsonEncoder.withIndent(' ').convert(mobileUser));
    return Center(
      child: TextButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AccountInfo(mobileUser: mobileUser),
            ),
          );
        },
        child: const Text('Next', style: TextStyle(color: Colors.blue)),
      ),
    );
  }
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1)}";
  }
}
