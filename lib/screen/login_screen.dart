import 'package:flutter/material.dart';
import 'package:practical/screen/complaint_screen.dart';
import 'package:practical/service/api_services.dart';
import 'package:practical/utilities/app_colors.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController mobileController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: _buildMain(),
        ),
      ),
    );
  }

  Widget _buildMain() {
    return Center(
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                _buildTitle(),
                const SizedBox(height: 20),
                _buildMobileNoField(),
                const SizedBox(height: 20),
                _buildPasswordField(),
                const SizedBox(height: 24),
                _buildLoginButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return const Text(
      "Login",
      style: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildMobileNoField() {
    return TextFormField(
      controller: mobileController,
      decoration: InputDecoration(
        labelText: "Enter Number",
        labelStyle: TextStyle(color: AppColors.color2,fontSize: 18),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: AppColors.color2,
            width: 2.0,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: AppColors.red,
            width: 2,
          ),
        ),
        errorStyle: TextStyle(
          color: AppColors.red,
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: AppColors.red,
            width: 2,
          ),
        ),
      ),
      validator: (value) {
        if (mobileController.text.isEmpty) {
          return "Please Enter Number";
        }
        return null;
      },
    );
  }

  Widget _buildPasswordField() {
    return TextFormField(
      controller: passwordController,
      decoration: InputDecoration(
        labelText: "Enter Password",
        labelStyle: TextStyle(color: AppColors.color2,fontSize: 18),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: AppColors.color2,
            width: 2.0,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: AppColors.red,
            width: 2,
          ),
        ),
        errorStyle: TextStyle(
          color: AppColors.red,
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: AppColors.red,
            width: 2,
          ),
        ),
      ),
      validator: (value) {
        if (passwordController.text.isEmpty) {
          return "Please Enter Password";
        }
        return null;
      },
    );
  }

  Widget _buildLoginButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.color2,
        minimumSize: const Size.fromHeight(40),
      ),
      onPressed: _login,
      child: const Text(
        "Login",
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),
    );
  }

  Future<void> _login() async {
    if (_formKey.currentState!.validate()) {
      bool loggedIn = await ApiServices.login(
        mobileController.text,
        passwordController.text,
      );

      if (loggedIn) {
        if (mounted) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const ComplaintScreen(),
            ),
          );
        }
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text('Login failed'),
              backgroundColor: AppColors.red,
            ),
          );
        }
      }
    }
  }
}
