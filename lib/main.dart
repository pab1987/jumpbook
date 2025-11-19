import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
//import 'package:jumpbook/controllers/auth_controller.dart';
import 'package:jumpbook/router/app_router.dart';
import 'package:jumpbook/theme/app_theme.dart';
import 'firebase_options.dart'; // generado por flutterfire configure
//import 'package:jumpbook/auth/auth_screens/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const JumpBookApp());
}

class JumpBookApp extends StatelessWidget {
  const JumpBookApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Jumpbook',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      routerConfig: AppRouter.router,
    );
  }
}
