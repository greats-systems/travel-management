import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:travel_management_app_2/auth/auth_service.dart';
import 'package:travel_management_app_2/components/my_button.dart';
import 'package:travel_management_app_2/components/my_sized_box.dart';
import 'package:travel_management_app_2/components/my_text_field.dart';
import 'package:travel_management_app_2/constants.dart' as constants;

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final authService = AuthService();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  void login() async {
    final email = _emailController.text;
    final password = _passwordController.text;

    try {
      await authService.signInWithEmailAndPassword(email, password);
    } catch (e) {
      if (mounted) {
        if (e.runtimeType == AuthApiException) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(e.toString())));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("${e.toString()}\n${e.runtimeType.toString()}"),
            ),
          );
        }
      }
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).size.width / 5,
            left: MediaQuery.of(context).size.width / 10,
            right: MediaQuery.of(context).size.width / 10,
          ),
          child: ListView(
            children: [
              // logo
              Center(child: Image.asset(constants.logoURL)),
              MySizedBox(),

              // email field
              _buildTextField(
                controller: _emailController,
                hintText: 'Email',
                keyboardType: TextInputType.emailAddress,
              ),
              MySizedBox(),

              // password field
              _buildTextField(
                controller: _passwordController,
                hintText: 'Password',
                obscureText: true,
              ),
              MySizedBox(),

              // login button
              MyButton(
                onTap: login,
                text: 'Login',
                color: Colors.blue.shade700,
              ),
              MySizedBox(),

              // sign up hyperlink
              Center(
                child: GestureDetector(
                  onTap: () {
                    if (mounted) {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, '/register');
                    }
                  },
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
