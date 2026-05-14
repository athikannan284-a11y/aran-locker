import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:go_router/go_router.dart';
import '../core/app_colors.dart';
import '../widgets/glass_card.dart';
import '../widgets/premium_button.dart';

class FamilySharingScreen extends StatelessWidget {
  const FamilySharingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Family Sharing'),
        leading: IconButton(
          onPressed: () => context.go('/dashboard'),
          icon: const Icon(Icons.arrow_back_ios_new),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FadeInDown(
              child: GlassCard(
                color: AppColors.accent.withOpacity(0.1),
                border: Border.all(color: AppColors.accent.withOpacity(0.3)),
                child: const Row(
                  children: [
                    Icon(Icons.group_add_rounded, color: AppColors.accent, size: 30),
                    SizedBox(width: 20),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Share Securely',
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          Text(
                            'Add up to 5 family members to your secure vault.',
                            style: TextStyle(color: Colors.white54, fontSize: 13),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 40),
            const Text(
              'Members',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            _buildMemberTile('Jane Doe', 'Spouse', 'Full Access'),
            _buildMemberTile('Billy Doe', 'Son', 'View Only'),
            const Spacer(),
            PremiumButton(
              text: 'Add New Member',
              icon: Icons.person_add_alt_1_rounded,
              gradient: AppColors.accentGradient,
              onPressed: () {},
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildMemberTile(String name, String relation, String permission) {
    return FadeInUp(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 15),
        child: GlassCard(
          padding: const EdgeInsets.all(15),
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: AppColors.primary.withOpacity(0.2),
                child: Text(name[0], style: const TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold)),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
                    Text(relation, style: const TextStyle(color: Colors.white54, fontSize: 12)),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  permission,
                  style: const TextStyle(fontSize: 10, color: AppColors.accent),
                ),
              ),
              IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert, size: 20)),
            ],
          ),
        ),
      ),
    );
  }
}
