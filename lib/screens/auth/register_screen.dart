import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jumpbook/services/auth_service.dart';
import 'package:jumpbook/theme/app_colors.dart';
import 'package:jumpbook/widgets/layout/auth_scaffold.dart';
import 'package:jumpbook/widgets/buttons/custom_button.dart';
import 'package:jumpbook/widgets/buttons/custom_text_buttom.dart';
import 'package:jumpbook/widgets/inputs/custom_text_field.dart';
import 'package:jumpbook/widgets/buttons/social_button.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _nameController = TextEditingController();
  final _nicknameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _repeatPasswordController = TextEditingController();

  bool _loading = false;
  String? _errorMessage;

  Future<void> _register() async {
    setState(() {
      _loading = true;
      _errorMessage = null;
    });

    if (_passwordController.text.trim() !=
        _repeatPasswordController.text.trim()) {
      if (!mounted) return;
      setState(() {
        _errorMessage = "Passwords do not match";
        _loading = false;
      });
      return;
    }

    try {
      // Crear usuario
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: _emailController.text.trim(),
            password: _passwordController.text.trim(),
          );

      // Actualizar nombre del usuario en Firebase Auth
      await credential.user!.updateDisplayName(_nameController.text.trim());
      await credential.user!.reload();

      final updatedUser = FirebaseAuth.instance.currentUser;

      // (Opcional) Guardar más datos en Firestore
      // FirebaseFirestore.instance.collection("users").doc(credential.user!.uid).set({
      //   "name": _nameController.text.trim(),
      //   "nickname": _nicknameController.text.trim(),
      //   "email": _emailController.text.trim(),
      //   "createdAt": FieldValue.serverTimestamp(),
      // });

      // Continuar a la app
      print("Usuario registrado: ${updatedUser!.email}");
      print("Nombre: ${updatedUser.displayName}");
    } on FirebaseAuthException catch (e) {
      if (!mounted) return;
      setState(() {
        _errorMessage = e.message;
      });
    } finally {
      if (!mounted) return;
      setState(() {
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AuthScaffold(
      title: "JUMPBOOK",
      header: Image.asset("assets/images/logos/free_fall.png", height: 250),
      children: [
        CustomTextField(
          icon: Icons.person,
          label: "Nombre completo",
          controller: _nameController,
        ),
        const SizedBox(height: 15),

        CustomTextField(
          icon: Icons.add_reaction_outlined,
          label: "Nickname",
          controller: _nicknameController,
        ),
        const SizedBox(height: 15),

        CustomTextField(
          icon: Icons.alternate_email,
          label: "Email",
          controller: _emailController,
        ),
        SizedBox(height: 15),

        CustomTextField(
          icon: Icons.lock,
          label: "Password",
          controller: _passwordController,
          obscure: true,
        ),
        const SizedBox(height: 15),

        CustomTextField(
          icon: Icons.lock,
          label: "Repeat Password",
          controller: _repeatPasswordController,
          obscure: true,
        ),

        if (_errorMessage != null)
          Text(_errorMessage!, style: const TextStyle(color: Colors.red)),

        const SizedBox(height: 20),

        CustomButton(text: "Sign up", loading: _loading, onPressed: _register),
        const SizedBox(height: 20),

        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Have an account?",
            style: TextStyle(fontSize: 16, color: AppColors.textSecondary),
          ),
        ),

        //const SizedBox(height: 5),
        Align(
          alignment: Alignment.centerLeft,
          child: CustomTextButton(
            text: 'Log in >',
            fontSize: 16,
            fontWeight: FontWeight.w500,
            onPressed: () {
              context.go('/login');
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
