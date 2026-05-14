import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:go_router/go_router.dart';
import '../core/app_colors.dart';
import '../widgets/premium_button.dart';
import '../widgets/glass_card.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _phoneController = TextEditingController();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              FadeInDown(
                child: IconButton(
                  onPressed: () => context.go('/onboarding'),
                  icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
                  style: IconButton.styleFrom(
                    backgroundColor: Colors.white.withOpacity(0.05),
                    padding: const EdgeInsets.all(12),
                  ),
                ),
              ),
              const SizedBox(height: 40),
              FadeInLeft(
                child: const Text(
                  'Enter your\nMobile Number',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    height: 1.2,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              FadeInLeft(
                delay: const Duration(milliseconds: 200),
                child: Text(
                  'We will send a 6-digit verification code to your number.',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white.withOpacity(0.5),
                  ),
                ),
              ),
              const SizedBox(height: 60),
              FadeInUp(
                delay: const Duration(milliseconds: 400),
                child: GlassCard(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Row(
                    children: [
                      const Text(
                        '+91',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                      ),
                      const SizedBox(width: 15),
                      Container(
                        width: 1,
                        height: 30,
                        color: Colors.white.withOpacity(0.1),
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                        child: TextField(
                          controller: _phoneController,
                          keyboardType: TextInputType.phone,
                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                          decoration: const InputDecoration(
                            hintText: 'Mobile Number',
                            border: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            fillColor: Colors.transparent,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const Spacer(),
              FadeInUp(
                delay: const Duration(milliseconds: 600),
                child: PremiumButton(
                  text: 'Send OTP',
                  isLoading: _isLoading,
                  onPressed: () {
                    setState(() => _isLoading = true);
                    Future.delayed(const Duration(seconds: 2), () {
                      if (mounted) {
                        setState(() => _isLoading = false);
                        context.go('/otp');
                      }
                    });
                  },
                ),
              ),
              const SizedBox(height: 20),
              FadeInUp(
                delay: const Duration(milliseconds: 800),
                child: Center(
                  child: Text(
                    'By continuing, you agree to our Terms & Privacy Policy',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.white.withOpacity(0.3),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
