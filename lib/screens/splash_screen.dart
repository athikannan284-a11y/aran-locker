import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:go_router/go_router.dart';
import '../core/app_colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToNext();
  }

  void _navigateToNext() async {
    await Future.delayed(const Duration(seconds: 3));
    if (mounted) {
      context.go('/onboarding');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          color: AppColors.background,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FadeInDown(
              duration: const Duration(milliseconds: 1500),
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: AppColors.primaryGradient,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withOpacity(0.5),
                      blurRadius: 30,
                      spreadRadius: 5,
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.lock_rounded,
                  size: 80,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 30),
            FadeInUp(
              duration: const Duration(milliseconds: 1500),
              child: const Column(
                children: [
                  Text(
                    'VaultX',
                    style: TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Secure AI Document Locker',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white54,
                      letterSpacing: 1,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
