import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:travel_management_app_2/auth/auth_service.dart';
import 'package:travel_management_app_2/components/my_button.dart';
import 'package:travel_management_app_2/components/my_text_field.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final authService = AuthService();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  void signUp() async {
    final firstName = _firstNameController.text;
    final lastName = _lastNameController.text;
    final phone = _phoneNumberController.text;
    final email = _emailController.text;
    final password = _passwordController.text;
    final confirmPassword = _confirmPasswordController.text;
    final args = {
      "first_name": firstName,
      "last_name": lastName,
      "phone": phone,
      "email": email,
    };

    if (password == confirmPassword) {
      try {
        await authService.signUpWithEmailAndPassword(
          email,
          password,
          firstName,
          lastName,
          phone,
        );
        Navigator.pushNamed(context, '/auth-gate');
      } catch (e) {
        if (mounted) {
          if (e.runtimeType == AuthApiException) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(e.toString())));
            return;
          } else if (e.runtimeType == AuthWeakPasswordException) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  'Your password should have at least 6 characters',
                ),
              ),
            );
            return;
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("${e.toString()}\n${e.runtimeType.toString()}"),
              ),
            );
            return;
          }
        }
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('User with that phone number already exists')),
      );
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).size.width / 2,
            left: MediaQuery.of(context).size.width / 10,
            right: MediaQuery.of(context).size.width / 10,
          ),
          child: ListView(
            children: [
              // title
              Center(
                child: Text(
                  'Sign Up',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 20),

              // first name
              MyTextField(
                controller: _firstNameController,
                hintText: 'First Name',
                obscureText: false,
              ),
              SizedBox(height: 20),

              // last name
              MyTextField(
                controller: _lastNameController,
                hintText: 'Last name',
                obscureText: false,
              ),
              SizedBox(height: 20),

              // phone number field
              MyTextField(
                controller: _phoneNumberController,
                hintText: 'Phone',
                obscureText: false,
              ),
              SizedBox(height: 20),

              // email field
              MyTextField(
                controller: _emailController,
                hintText: 'Email',
                obscureText: false,
              ),
              SizedBox(height: 20),

              // Password field
              MyTextField(
                controller: _passwordController,
                hintText: 'Password',
                obscureText: true,
              ),
              SizedBox(height: 20),

              // confirm PIN field
              MyTextField(
                controller: _confirmPasswordController,
                hintText: 'Confirm Password',
                obscureText: true,
              ),
              SizedBox(height: 20),

              // login button
              MyButton(
                onTap: signUp,
                text: 'Sign Up',
                color: Colors.blue.shade700,
              ),
              SizedBox(height: 20),

              // sign up hyperlink
              Center(
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                    // Navigator.popUntil(context, (route) => route.isFirst);
                    Navigator.pushNamed(context, '/auth-gate');
                  },
                  child: Text('Log In', style: TextStyle(color: Colors.blue)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
