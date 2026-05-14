import 'dart:ui';
import 'package:flutter/material.dart';
import '../core/app_colors.dart';

class GlassCard extends StatelessWidget {
  final Widget child;
  final double borderRadius;
  final double blur;
  final EdgeInsetsGeometry padding;
  final Color? color;
  final Border? border;

  const GlassCard({
    super.key,
    required this.child,
    this.borderRadius = 24,
    this.blur = 15,
    this.padding = const EdgeInsets.all(20),
    this.color,
    this.border,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
        child: Container(
          padding: padding,
          decoration: BoxDecoration(
            color: color ?? AppColors.glassBackground,
            borderRadius: BorderRadius.circular(borderRadius),
            border: border ?? Border.all(color: AppColors.glassBorder, width: 1.5),
            gradient: AppColors.glassGradient,
          ),
          child: child,
        ),
      ),
    );
  }
}
