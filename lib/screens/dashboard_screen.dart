import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import '../core/app_colors.dart';
import '../widgets/glass_card.dart';
import '../widgets/document_card.dart';
import '../models/document_model.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _buildBottomNav(context),
      body: Stack(
        children: [
          // Background Glow
          Positioned(
            top: -150,
            left: -100,
            child: Container(
              width: 400,
              height: 400,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.primary.withOpacity(0.1),
              ),
            ),
          ),
          
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  _buildHeader(),
                  const SizedBox(height: 30),
                  _buildSearchBar(),
                  const SizedBox(height: 30),
                  _buildStorageWidget(),
                  const SizedBox(height: 30),
                  _buildCategories(),
                  const SizedBox(height: 30),
                  _buildRecentFiles(),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.go('/upload'),
        backgroundColor: AppColors.primary,
        child: const Icon(Icons.add, color: Colors.white, size: 30),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget _buildHeader() {
    return FadeInDown(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Hello, John Doe',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Welcome back to VaultX',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white54,
                ),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.primary, width: 2),
            ),
            child: const CircleAvatar(
              radius: 24,
              backgroundImage: NetworkImage('https://i.pravatar.cc/150?u=vaultx'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return FadeInDown(
      delay: const Duration(milliseconds: 200),
      child: GlassCard(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        borderRadius: 16,
        child: Row(
          children: [
            const Icon(Icons.search, color: Colors.white54),
            const SizedBox(width: 15),
            const Expanded(
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search documents, tags, OCR text...',
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  fillColor: Colors.transparent,
                  contentPadding: EdgeInsets.zero,
                ),
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.mic_none_rounded, color: AppColors.primary),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStorageWidget() {
    return FadeInRight(
      delay: const Duration(milliseconds: 400),
      child: GlassCard(
        color: AppColors.primary.withOpacity(0.1),
        border: Border.all(color: AppColors.primary.withOpacity(0.3)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Storage Usage',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                Text(
                  '75% Used',
                  style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 15),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: LinearProgressIndicator(
                value: 0.75,
                backgroundColor: Colors.white.withOpacity(0.05),
                color: AppColors.primary,
                minHeight: 8,
              ),
            ),
            const SizedBox(height: 15),
            const Text(
              '1.5 GB of 2.0 GB used',
              style: TextStyle(color: Colors.white54, fontSize: 13),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategories() {
    final categories = [
      {'name': 'Govt IDs', 'icon': FontAwesomeIcons.idCard, 'color': AppColors.primary},
      {'name': 'Banking', 'icon': FontAwesomeIcons.buildingColumns, 'color': AppColors.accent},
      {'name': 'Education', 'icon': FontAwesomeIcons.graduationCap, 'color': AppColors.gold},
      {'name': 'Health', 'icon': FontAwesomeIcons.heartPulse, 'color': Colors.redAccent},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FadeInLeft(
          delay: const Duration(milliseconds: 600),
          child: const Text(
            'Categories',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 15),
        SizedBox(
          height: 100,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: categories.length,
            itemBuilder: (context, index) {
              final cat = categories[index];
              return FadeInRight(
                delay: Duration(milliseconds: 600 + (index * 100)),
                child: Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: Column(
                    children: [
                      Container(
                        width: 65,
                        height: 65,
                        decoration: BoxDecoration(
                          color: (cat['color'] as Color).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(18),
                          border: Border.all(color: (cat['color'] as Color).withOpacity(0.2)),
                        ),
                        child: Icon(cat['icon'] as IconData, color: cat['color'] as Color, size: 24),
                      ),
                      const SizedBox(height: 8),
                      Text(cat['name'] as String, style: const TextStyle(fontSize: 12)),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildRecentFiles() {
    final docs = [
      DocumentModel(
        documentId: '1',
        userId: 'u1',
        documentType: 'Aadhaar Card',
        category: 'Government IDs',
        fileURL: '',
        createdAt: DateTime.now(),
      ),
      DocumentModel(
        documentId: '2',
        userId: 'u1',
        documentType: 'PAN Card',
        category: 'Government IDs',
        fileURL: '',
        createdAt: DateTime.now().subtract(const Duration(days: 1)),
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FadeInLeft(
          delay: const Duration(milliseconds: 1000),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Recent Documents',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              TextButton(
                onPressed: () {},
                child: const Text('See All', style: TextStyle(color: AppColors.primary)),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 15,
            mainAxisSpacing: 15,
            childAspectRatio: 0.85,
          ),
          itemCount: docs.length,
          itemBuilder: (context, index) {
            return FadeInUp(
              delay: Duration(milliseconds: 1100 + (index * 100)),
              child: DocumentCard(
                document: docs[index],
                onTap: () => context.go('/view'),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildBottomNav(BuildContext context) {
    return Container(
      height: 90,
      decoration: BoxDecoration(
        color: AppColors.background,
        boxShadow: [
          BoxShadow(
            color: Colors.white.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: BottomAppBar(
        color: Colors.transparent,
        elevation: 0,
        shape: const CircularNotchedRectangle(),
        notchMargin: 10,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem(context, Icons.grid_view_rounded, 'Home', true, '/dashboard'),
            _buildNavItem(context, Icons.search_rounded, 'Search', false, '/search'),
            const SizedBox(width: 40),
            _buildNavItem(context, Icons.shield_rounded, 'Vault', false, '/hidden'),
            _buildNavItem(context, Icons.person_rounded, 'Profile', false, '/profile'),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(BuildContext context, IconData icon, String label, bool isActive, String route) {
    return InkWell(
      onTap: () => context.go(route),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: isActive ? AppColors.primary : Colors.white54,
            size: 26,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: isActive ? AppColors.primary : Colors.white54,
              fontSize: 10,
              fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
