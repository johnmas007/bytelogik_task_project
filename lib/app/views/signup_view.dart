import 'package:bytelogik_task/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../constants.dart';
import '../../widgets/custom_text_form_filed.dart';
import '../controllers/auth_controller.dart';
import 'login_view.dart';

class SignUpView extends ConsumerStatefulWidget {
  const SignUpView({super.key});

  @override
  ConsumerState<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends ConsumerState<SignUpView> {
  final _formKey = GlobalKey<FormState>();
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  final _authController = AuthController();
  bool _loading = false;

  Future<void> _signUp() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _loading = true);
    final err = await _authController.signUp(_emailCtrl.text.trim(), _passCtrl.text.trim());
    setState(() => _loading = false);
    if (err == null) {
      if (!mounted) return;
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const LoginView()));
    } else {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(err)));
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
                    "Create your account,",
                    style: GoogleFonts.poppins(
                      color: Constants.secondaryAppColor,
                      fontWeight: FontWeight.w700,
                      fontSize: width/8,
                    ),
                  ),
                  Text(

                    "Sign Up",
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
                label: "Email",
                onSubmitted: (String? value){
                  return null;


                },

                validator: (v) {
                  if (v == null || v.isEmpty) return 'Enter email';
                  if (!v.contains('@')) return 'Enter a valid email';
                  return null;
                },
              ),
              CustomTextFormField(
                controller: _passCtrl,
                obscureText: true,
                label: "Password",
                onSubmitted: (String? value){
                  return null;
                },
                validator: (v) {
                  if (v == null || v.isEmpty) return 'Enter password';
                  if (v.length < 6) return 'Password must be 6+ chars';
                  return null;
                },
              ),
              const SizedBox(height: 20),
              _loading
                  ? const CircularProgressIndicator()
                  : PrimaryButton(onTap: _signUp, title: "Sign Up",),
            ],
          ),
        ),
      ),
    );
  }
}
