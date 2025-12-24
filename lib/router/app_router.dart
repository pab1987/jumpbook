import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:jumpbook/models/jump_model.dart';

import 'package:jumpbook/screens/auth/auth_screens.dart';
import 'package:jumpbook/screens/jumps/add_jump.dart';
import 'package:jumpbook/screens/home/home_screen.dart';
import 'package:jumpbook/providers/auth_state_notifier.dart';
import 'package:jumpbook/screens/jumps/all_jumps_screen.dart';
import 'package:jumpbook/screens/jumps/jump_detail.dart';
import 'package:jumpbook/screens/onboarding/onboarding_screen.dart';

class AppRouter {
  static final GlobalKey<NavigatorState> _rootNavigatorKey =
      GlobalKey<NavigatorState>();

  static final GoRouter router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: "/onboarding",
    debugLogDiagnostics: true,

    refreshListenable: AuthStateNotifier(),

    /* redirect: (context, state) {
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
    }, */
    redirect: (context, state) {
      final user = FirebaseAuth.instance.currentUser;

      // NUNCA bloquear onboarding
      if (state.matchedLocation == "/onboarding") return null;

      // Ignorar pantallas secundarias
      final secondaryScreens = ["/add_jump", "/all_jumps"];
      if (secondaryScreens.contains(state.matchedLocation)) return null;

      final authRoutes = ["/login", "/register"];
      final loggingIn = authRoutes.contains(state.matchedLocation);

      if (user == null) return loggingIn ? null : "/login";
      if (loggingIn) return "/home";

      return null;
    },

    routes: [
      GoRoute(
        path: '/onboarding',
        builder: (_, __) => const OnboardingScreen(),
      ),
      GoRoute(
        path: '/jump_detail',
        builder: (context, state) {
          final extra = state.extra;
          late final Jump jump;
          int? jumpNumber;

          if (extra is Map<String, dynamic>) {
            jump = extra['jump'] as Jump;
            jumpNumber = extra['jumpNumber'] as int?;
          } else {
            jump = extra as Jump;
          }

          return JumpDetailScreen(jump: jump, jumpNumber: jumpNumber);
        },
      ),

      GoRoute(path: "/login", builder: (_, __) => const LoginScreen()),
      GoRoute(path: "/register", builder: (_, __) => const RegisterScreen()),
      GoRoute(path: "/home", builder: (_, __) => const HomeScreen()),
      GoRoute(
        path: '/add_jump',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) {
          final existingJump = state.extra as Jump?;
          return AddJumpScreen(existingJump: existingJump);
        },
      ),
      GoRoute(
        path: "/all_jumps",
        parentNavigatorKey: _rootNavigatorKey,
        builder: (_, __) => const AllJumpsScreen(),
      ),
    ],
  );
}
