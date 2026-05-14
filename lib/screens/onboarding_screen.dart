import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:go_router/go_router.dart';
import '../core/app_colors.dart';
import '../widgets/premium_button.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Gradient Orbs
          Positioned(
            top: -100,
            right: -100,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.primary.withOpacity(0.2),
              ),
            ),
          ),
          Positioned(
            bottom: -50,
            left: -50,
            child: Container(
              width: 250,
              height: 250,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.accent.withOpacity(0.1),
              ),
            ),
          ),
          
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 60),
                  FadeInLeft(
                    child: const Text(
                      'Welcome to\nVaultX',
                      style: TextStyle(
                        fontSize: 42,
                        fontWeight: FontWeight.bold,
                        height: 1.1,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  FadeInLeft(
                    delay: const Duration(milliseconds: 300),
                    child: Text(
                      'Your personal, secure, and AI-powered digital document locker.',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white.withOpacity(0.6),
                        height: 1.5,
                      ),
                    ),
                  ),
                  const Spacer(),
                  FadeInUp(
                    delay: const Duration(milliseconds: 600),
                    child: Column(
                      children: [
                        _buildFeatureItem(
                          Icons.security_rounded,
                          'Bank-Grade Security',
                          'End-to-end encryption for all your files.',
                        ),
                        const SizedBox(height: 24),
                        _buildFeatureItem(
                          Icons.psychology_rounded,
                          'AI Organization',
                          'Automatic categorization and OCR scanning.',
                        ),
                        const SizedBox(height: 24),
                        _buildFeatureItem(
                          Icons.cloud_done_rounded,
                          'Seamless Sync',
                          'Access your documents from any device.',
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  FadeInUp(
                    delay: const Duration(milliseconds: 900),
                    child: PremiumButton(
                      text: 'Get Started',
                      onPressed: () => context.go('/login'),
                    ),
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureItem(IconData icon, String title, String desc) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: AppColors.primary.withOpacity(0.2)),
          ),
          child: Icon(icon, color: AppColors.primary, size: 28),
        ),
        const SizedBox(width: 20),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                desc,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white.withOpacity(0.5),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
