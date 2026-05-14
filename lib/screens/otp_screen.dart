import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:go_router/go_router.dart';
import '../core/app_colors.dart';
import '../widgets/premium_button.dart';
import '../widgets/glass_card.dart';

class OTPScreen extends StatefulWidget {
  const OTPScreen({super.key});

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  final List<TextEditingController> _controllers = List.generate(6, (_) => TextEditingController());
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
                  onPressed: () => context.go('/login'),
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
                  'Verify Code',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              FadeInLeft(
                delay: const Duration(milliseconds: 200),
                child: Text(
                  'Enter the 6-digit code sent to +91 98765 43210',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white.withOpacity(0.5),
                  ),
                ),
              ),
              const SizedBox(height: 60),
              FadeInUp(
                delay: const Duration(milliseconds: 400),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(6, (index) {
                    return SizedBox(
                      width: 45,
                      child: GlassCard(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        borderRadius: 12,
                        child: TextField(
                          controller: _controllers[index],
                          autofocus: index == 0,
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,
                          maxLength: 1,
                          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                          decoration: const InputDecoration(
                            counterText: '',
                            border: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            fillColor: Colors.transparent,
                          ),
                          onChanged: (value) {
                            if (value.isNotEmpty && index < 5) {
                              FocusScope.of(context).nextFocus();
                            } else if (value.isEmpty && index > 0) {
                              FocusScope.of(context).previousFocus();
                            }
                          },
                        ),
                      ),
                    );
                  }),
                ),
              ),
              const SizedBox(height: 40),
              FadeInUp(
                delay: const Duration(milliseconds: 600),
                child: Center(
                  child: TextButton(
                    onPressed: () {},
                    child: const Text(
                      'Resend Code in 00:59',
                      style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ),
              const Spacer(),
              FadeInUp(
                delay: const Duration(milliseconds: 800),
                child: PremiumButton(
                  text: 'Verify & Login',
                  isLoading: _isLoading,
                  onPressed: () {
                    setState(() => _isLoading = true);
                    Future.delayed(const Duration(seconds: 2), () {
                      if (mounted) {
                        setState(() => _isLoading = false);
                        context.go('/dashboard');
                      }
                    });
                  },
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
