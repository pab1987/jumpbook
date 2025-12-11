import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

import 'package:jumpbook/screens/auth/auth_screens.dart';
import 'package:jumpbook/screens/jumps/add_jump.dart';
import 'package:jumpbook/screens/home/home_screen.dart';
import 'package:jumpbook/providers/auth_state_notifier.dart';
import 'package:jumpbook/screens/onboarding/onboarding_screen.dart';

class AppRouter {
  static final GlobalKey<NavigatorState> _rootNavigatorKey =
      GlobalKey<NavigatorState>();

  static final GoRouter router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: "/onboarding",
    debugLogDiagnostics: true,

    refreshListenable: AuthStateNotifier(),

    redirect: (context, state) {
      final user = FirebaseAuth.instance.currentUser;

      // 👇 NUNCA bloquear onboarding
      if (state.matchedLocation == "/onboarding") {
        return null;
      }

      final loggingIn = state.matchedLocation == "/login";
      final registering = state.matchedLocation == "/register";
      final authRoute = loggingIn || registering;

      if (user == null) {
        // Permitir login o register
        if (authRoute) return null;

        return "/login";
      }

      if (authRoute) {
        // Evitar quedarse en login/register si ya está logueado
        return "/home";
      }

      // Todo bien, dejar pasar
      return null;
    },

    routes: [
      GoRoute(
        path: '/onboarding',
        builder: (_, __) => const OnboardingScreen(),
      ),
      GoRoute(path: "/login", builder: (_, __) => const LoginScreen()),
      GoRoute(path: "/register", builder: (_, __) => const RegisterScreen()),
      GoRoute(path: "/home", builder: (_, __) => const HomeScreen()),
      GoRoute(path: "/add_jump", builder: (_, __) => const AddJumpScreen()),
    ],
  );
}
