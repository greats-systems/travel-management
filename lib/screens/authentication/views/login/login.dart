import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:travel_management_app_2/auth/auth_service.dart';
import 'package:travel_management_app_2/components/my_button.dart';
import 'package:travel_management_app_2/components/my_sized_box.dart';
import 'package:travel_management_app_2/components/my_snack_bar.dart';
import 'package:travel_management_app_2/components/my_text_field.dart';
import 'package:travel_management_app_2/constants.dart' as constants;

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final AuthService _authService = AuthService();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    try {
      await _authService.signInWithEmailAndPassword(
        _emailController.text,
        _passwordController.text,
      );
    } on AuthApiException catch (e) {
      if (!mounted) return;
      MySnackBar.showSnackBar(context, e.toString(), Colors.red);
    } catch (e) {
      if (!mounted) return;
      MySnackBar.showSnackBar(
        context,
        'An unexpected error occurred: ${e.runtimeType}',
        Colors.red,
      );
    }
  }

  void _navigateToRegister() {
    if (!mounted) return;
    Navigator.pop(context);
    Navigator.pushNamed(context, '/register');
  }

  @override
  Widget build(BuildContext context) {
    final horizontalPadding = MediaQuery.of(context).size.width / 10;
    final topPadding = MediaQuery.of(context).size.width / 5;

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

              // Email field
              _buildTextField(
                controller: _emailController,
                hintText: 'Email',
                keyboardType: TextInputType.emailAddress,
              ),
              MySizedBox(),

              // Password field
              _buildTextField(
                controller: _passwordController,
                hintText: 'Password',
                obscureText: true,
              ),
              MySizedBox(),

              // Login button
              MyButton(
                onTap: _login,
                text: 'Login',
                color: Colors.blue.shade700,
              ),
              MySizedBox(),

              // Sign up link
              Center(
                child: GestureDetector(
                  onTap: _navigateToRegister,
                  child: Text('Sign Up', style: TextStyle(color: Colors.blue)),
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
}
