import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:travel_management_app_2/auth/auth_service.dart';
import 'package:travel_management_app_2/components/my_button.dart';
import 'package:travel_management_app_2/components/my_sized_box.dart';
import 'package:travel_management_app_2/components/my_text_field.dart';
import 'package:travel_management_app_2/constants.dart' as constants;

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final FocusNode focusNode = FocusNode();
  final authService = AuthService();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  // Add this variable to store the complete phone number
  String _completePhoneNumber = '';

  void signUp() async {
    final firstName = _firstNameController.text;
    final lastName = _lastNameController.text;
    final phone = _completePhoneNumber; // Use the stored complete number
    final email = _emailController.text;
    final password = _passwordController.text;
    final confirmPassword = _confirmPasswordController.text;

    if (password == confirmPassword) {
      try {
        await authService.signUpWithEmailAndPassword(
          email,
          password,
          firstName,
          lastName,
          phone, // Now includes country code
        );
        if (mounted) {
          Navigator.pushNamed(context, '/auth-gate');
        }
      } catch (e) {
        if (mounted) {
          if (e.runtimeType == AuthApiException) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(e.toString())));
          } else if (e.runtimeType == AuthWeakPasswordException) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(
                  'Your password should have at least 6 characters',
                ),
              ),
            );
          } else {
            debugPrint(e.toString());
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                duration: const Duration(seconds: 20),
                content: Text("${e.toString()}\n${e.runtimeType.toString()}"),
              ),
            );
          }
        }
      }
    } else {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Passwords do not match')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).size.width / 4,
            left: MediaQuery.of(context).size.width / 10,
            right: MediaQuery.of(context).size.width / 10,
          ),
          child: ListView(
            children: [
              // logo
              Center(child: Image.asset(constants.logoURL)),
              MySizedBox(),

              // first name
              MyTextField(
                textInputType: TextInputType.text,
                controller: _firstNameController,
                hintText: 'First Name',
                obscureText: false,
              ),
              MySizedBox(),

              // last name
              MyTextField(
                textInputType: TextInputType.text,
                controller: _lastNameController,
                hintText: 'Last name',
                obscureText: false,
              ),
              MySizedBox(),

              // phone number field - Modified to capture complete number
              IntlPhoneField(
                controller: _phoneNumberController,
                focusNode: focusNode,
                decoration: const InputDecoration(
                  labelText: 'Phone Number',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                  ),
                ),
                initialCountryCode: 'US',
                onChanged: (PhoneNumber phone) {
                  // Store the complete international number
                  _completePhoneNumber = phone.completeNumber;
                  debugPrint('Complete phone number: $_completePhoneNumber');
                },
                onCountryChanged: (country) {
                  debugPrint('Country changed to ${country.name}');
                },
              ),
              MySizedBox(),

              // email field
              MyTextField(
                textInputType: TextInputType.emailAddress,
                controller: _emailController,
                hintText: 'Email',
                obscureText: false,
              ),
              MySizedBox(),

              // Password field
              MyTextField(
                textInputType: TextInputType.text,
                controller: _passwordController,
                hintText: 'Password',
                obscureText: true,
              ),
              MySizedBox(),

              // confirm password field
              MyTextField(
                textInputType: TextInputType.text,
                controller: _confirmPasswordController,
                hintText: 'Confirm Password',
                obscureText: true,
              ),
              MySizedBox(),

              // sign up button
              MyButton(
                onTap: signUp,
                text: 'Sign Up',
                color: Colors.blue.shade700,
              ),
              MySizedBox(),

              // login link
              Center(
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, '/auth-gate');
                  },
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
}
