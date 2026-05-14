import 'package:flutter/material.dart';
import '../core/app_colors.dart';

class PremiumButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final IconData? icon;
  final bool isLoading;
  final double? width;
  final Gradient? gradient;

  const PremiumButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.icon,
    this.isLoading = false,
    this.width,
    this.gradient,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? double.infinity,
      height: 60,
      decoration: BoxDecoration(
        gradient: gradient ?? AppColors.primaryGradient,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: (gradient?.colors.first ?? AppColors.primary).withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onPressed: isLoading ? null : onPressed,
          borderRadius: BorderRadius.circular(20),
          child: Center(
            child: isLoading
                ? const SizedBox(
                    height: 24,
                    width: 24,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2,
                    ),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (icon != null) ...[
                        Icon(icon, color: Colors.white, size: 20),
                        const SizedBox(width: 10),
                      ],
                      Text(
                        text,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
