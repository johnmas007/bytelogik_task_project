import 'package:bytelogik_task/widgets/primary_button.dart';
import 'package:bytelogik_task/widgets/secondary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../constants.dart';
import '../controllers/counter_controller.dart';
import '../providers/counter_provider.dart';
import '../services/firebase_auth_service.dart';
import 'login_view.dart';

class HomeView extends ConsumerWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final counter = ref.watch(counterProvider);
    final ctrl = CounterController(ref);
    Size size = MediaQuery.of(context).size;
    double height = size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Home Page",
          style: GoogleFonts.poppins(
            color: Constants.secondaryAppColor,
            fontWeight: FontWeight.w700,
            fontSize: 28,
          ),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              Text('Counter: $counter', style:  GoogleFonts.poppins(
                color: Constants.primaryAppColor,
                fontWeight: FontWeight.w700,
                fontSize: 24,
              ),),
              const SizedBox(height: 20),
              PrimaryButton(onTap: ctrl.increment, title: 'Increment'),
              const SizedBox(height: 8),
              PrimaryButton(onTap: ctrl.decrement,title:'Decrement'),
              const SizedBox(height: 8),
              PrimaryButton(onTap: ctrl.reset, title:'Reset'),
              SizedBox(height: height/25.2),
              SecondaryButton(
                title: "Logout",
                onTap: () async {
                  await FirebaseAuthService().logout();
                  if (!context.mounted) return;
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const LoginView()));
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
