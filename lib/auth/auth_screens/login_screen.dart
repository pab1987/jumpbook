import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';
import 'package:jumpbook/services/auth_service.dart';
import 'package:jumpbook/theme/app_colors.dart';
import 'package:jumpbook/widgets/auth/auth_scaffold.dart';
import 'package:jumpbook/widgets/common/custom_button.dart';
import 'package:jumpbook/widgets/common/custom_text_field.dart';
import 'package:jumpbook/widgets/common/custom_text_buttom.dart';
import 'package:jumpbook/widgets/common/social_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _loading = false;
  String? _errorMessage;

  Future<void> _login() async {
    setState(() {
      _loading = true;
      _errorMessage = null;
    });

    print("EMAIL RAW: '${_emailController.text}'");
    print("EMAIL TRIM: '${_emailController.text.trim()}'");
    print("PASS RAW: '${_passwordController.text}'");

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
    } on FirebaseAuthException catch (e) {
      setState(() {
        _errorMessage = e.message;
      });
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AuthScaffold(
      title: "JUMPBOOK",
      header: Image.asset("assets/images/logos/logo_login.png", height: 250),
      children: [
        CustomTextField(
          icon: Icons.email,
          label: "Email",
          controller: _emailController,
        ),
        const SizedBox(height: 15),

        CustomTextField(
          icon: Icons.lock,
          label: "Password",
          controller: _passwordController,
          obscure: true,
        ),
        const SizedBox(height: 15),

        if (_errorMessage != null)
          Text(_errorMessage!, style: const TextStyle(color: Colors.red)),

        const SizedBox(height: 15),

        Align(
          alignment: Alignment.centerRight,
          child: CustomTextButton(
            text: 'Forgot password?',
            fontSize: 16,
            fontWeight: FontWeight.w500,
            onPressed: () {},
            color: AppColors.primaryHover,
          ),
        ),

        const SizedBox(height: 20),

        CustomButton(text: "Log in", loading: _loading, onPressed: _login),
        const SizedBox(height: 20),

        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Don't have an account?",
            style: TextStyle(fontSize: 16, color: AppColors.textSecondary),
          ),
        ),

        //const SizedBox(height: 5),
        Align(
          alignment: Alignment.centerLeft,
          child: CustomTextButton(
            text: 'Sign up >',
            fontSize: 16,
            fontWeight: FontWeight.w500,
            onPressed: () {
              context.go('/register');
            },
            color: AppColors.primaryHover,
          ),
        ),

        Row(
          children: [
            Expanded(child: Divider(color: AppColors.textSecondary)),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Text(
                "or",
                style: TextStyle(fontSize: 16, color: AppColors.textSecondary),
              ),
            ),
            Expanded(child: Divider(color: AppColors.textSecondary)),
          ],
        ),
        const SizedBox(height: 25),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: SocialButton(
                text: 'Google',
                assetPath: 'assets/icons/google.png',
                onPressed: () async {
                  print("===== GOOGLE BUTTON PRESSED =====");

                  try {
                    final userCredential = await AuthService.signInWithGoogle();
                    print("Resultado de signInWithGoogle(): $userCredential");

                    if (userCredential == null) {
                      print("userCredential es NULL");
                      return;
                    }

                    final user = userCredential.user;
                    print("User obtenido: $user");

                    if (user != null) {
                      print("Nombre: ${user.displayName}");
                      print("Email: ${user.email}");
                    } else {
                      print("user es NULL dentro de userCredential");
                    }
                  } catch (e, stack) {
                    print("🔥 ERROR EN GOOGLE LOGIN:");
                    print(e);
                    print(stack);
                  }
                },
              ),
            ),

            const SizedBox(width: 12),

            Expanded(
              child: SocialButton(
                text: 'Apple',
                assetPath: 'assets/icons/apple.png',
                onPressed: () async {
                  final userApple = await AuthService.signInWithApple();
                  if (userApple != null) {
                    print("Bienvenido: ${userApple.user!.email}");
                  }
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
