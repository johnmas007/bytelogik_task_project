import 'package:bytelogik_task/widgets/primary_button.dart';
import 'package:bytelogik_task/widgets/secondary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../constants.dart';
import '../../widgets/custom_text_form_filed.dart';
import '../controllers/auth_controller.dart';
import 'signup_view.dart';
import 'home_view.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginView extends ConsumerStatefulWidget {
  const LoginView({super.key});

  @override
  ConsumerState<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends ConsumerState<LoginView> {
  final _formKey = GlobalKey<FormState>();
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  final _authController = AuthController();
  bool _loading = false;

  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _loading = true);
    final err = await _authController.login(
      _emailCtrl.text.trim(),
      _passCtrl.text.trim(),
    );
    setState(() => _loading = false);
    if (err == null) {
      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const HomeView()),
      );
    } else {
      if (!mounted) return;
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(err)));
    }
  }

  Future<void> _forgotPassword() async {
    final email = _emailCtrl.text.trim();
    if (email.isEmpty || !email.contains('@')) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Enter a valid email first")),
      );
      return;
    }
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content:
            Text("Password reset email sent! Check your inbox.")),
      );
    } on FirebaseAuthException catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message ?? "Failed to send email")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: height/25.2),
                  Text(
                    "Welcome Back!,",
                    style: GoogleFonts.poppins(
                      color: Constants.secondaryAppColor,
                      fontWeight: FontWeight.w700,
                      fontSize: width/8,
                    ),
                  ),
                  Text(

                    "Login",
                    style: GoogleFonts.poppins(
                      color: Constants.primaryAppColor,
                      fontWeight: FontWeight.w700,
                      fontSize: width/8,
                    ),
                  ),
                  SizedBox(height: height/75.6),
                  Text(
                    "",
                    style: GoogleFonts.poppins(
                      color: Constants.bodyTextColor,
                      fontWeight: FontWeight.w400,
                      fontSize: width/18,
                    ),
                  ),
                ],
              ),
              SizedBox(height: height/25.2),
              CustomTextFormField(
                controller: _emailCtrl,
                validator: (v) {
                  if (v == null || v.isEmpty) return 'Enter email';
                  if (!v.contains('@')) return 'Enter a valid email';
                  return null;
                }, label: 'Email', onSubmitted: (String? value) {
                  return null;
                  },
              ),
              CustomTextFormField(
                controller: _passCtrl,
              label: 'Password',
                obscureText: true,
                validator: (v) {
                  if (v == null || v.isEmpty) return 'Enter password';
                  if (v.length < 6) return 'Password must be 6+ chars';
                  return null;
                }, onSubmitted: (String? value) {
                  return null;
                  },
              ),
              const SizedBox(height: 20),
              _loading
                  ? const CircularProgressIndicator()
                  : PrimaryButton(
                  onTap: _login, title: "Login",),
              SizedBox(height: height/25.2),
              SecondaryButton(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const SignUpView()),
                  );
                },
               title: "Create an account",

              ),
              TextButton(
                onPressed: _forgotPassword,
                child: const Text('Forgot Password?'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
