import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fallAnimation;
  late Animation<double> _logoOpacity;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3000),
    );

    // Fade-in del logo cuando ya casi termina la caída
    _logoOpacity = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.75, 1, curve: Curves.easeIn),
      ),
    );

    _controller.forward();

    Future.delayed(const Duration(seconds: 4), () {
      if (mounted) context.go('/login');
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final screenHeight = MediaQuery.of(context).size.height;

    _fallAnimation =
        Tween<double>(
          begin: -400, // más arriba
          end: screenHeight + 300, // sale bien por abajo
        ).animate(
          CurvedAnimation(
            parent: _controller,
            curve: Curves.easeInCubic, // caída más real (acelera)
          ),
        );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.black,
      body: AnimatedBuilder(
        animation: _controller,
        builder: (_, __) {
          return Stack(
            children: [
              /// 🪂 Paracaidista (tu imagen exacta)
              Positioned(
                top: _fallAnimation.value,
                left: screenWidth * 0.2,
                child: Image.asset(
                  "assets/images/logos/logo_login.png",
                  width: 220,
                  filterQuality: FilterQuality.high,
                ),
              ),

              /// ✨ Fade-in del logo
              Center(
                child: Opacity(
                  opacity: _logoOpacity.value,
                  child: const Text(
                    "JumpBook",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 38,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}