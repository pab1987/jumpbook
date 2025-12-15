import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jumpbook/theme/app_colors.dart';

class JumpbookAppBar extends StatelessWidget implements PreferredSizeWidget {
  final IconData icon;
  final String title;
  final VoidCallback? onIconPressed;

  const JumpbookAppBar({
    super.key,
    required this.icon,
    required this.title,
    this.onIconPressed,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.background,
      elevation: 0,
      scrolledUnderElevation: 0,
      leading: IconButton(
        onPressed:
            onIconPressed ??
            () {
              final router = GoRouter.of(context);

              // La verificación de seguridad para evitar la excepción "nothing to pop"
              if (router.canPop()) {
                router.pop();
              }
              // Opcional: Si está en la raíz y no puede hacer pop, va a /home
              else {
                router.go('/home');
              }
            },
        icon: Icon(icon, color: AppColors.textPrimary),
      ),
      title: Text(title, style: TextStyle(color: AppColors.textPrimary)),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 16.0),
          child: CircleAvatar(
            radius: 19,
            backgroundColor: const Color(0xFF6B8EAC),
            child: CircleAvatar(
              radius: 18,
              backgroundColor: const Color(0xFF2C2C2E),
              backgroundImage: const AssetImage('assets/images/profile.jpg'),
            ),
          ),
        ),
      ],
    );
  }
}
