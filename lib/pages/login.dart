import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:travel_management_app_2/auth/auth_service.dart';
import 'package:travel_management_app_2/components/my_button.dart';
import 'package:travel_management_app_2/components/my_text_field.dart';

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
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Incorrect username or password")),
          );
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
              // Center(
              //   child: Text(
              //     'Login',
              //     style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              //   ),
              // ),
              // SizedBox(height: 20),

              // email field
              MyTextField(
                controller: _emailController,
                hintText: 'Email',
                obscureText: false,
              ),
              SizedBox(height: 20),

              // password field
              MyTextField(
                controller: _passwordController,
                hintText: 'Password',
                obscureText: true,
              ),
              SizedBox(height: 20),

              // login button
              MyButton(
                onTap: login,
                text: 'Login',
                color: Colors.blue.shade700,
              ),
              SizedBox(height: 20),

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
}
