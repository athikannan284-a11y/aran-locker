import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:go_router/go_router.dart';
import '../core/app_colors.dart';
import '../widgets/glass_card.dart';

class DocumentViewerScreen extends StatelessWidget {
  const DocumentViewerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Aadhaar Card'),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.share_outlined)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert)),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FadeInDown(
              child: GlassCard(
                padding: EdgeInsets.zero,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(24),
                  child: Image.network(
                    'https://images.unsplash.com/photo-1633158829585-23ba8f7c8caf?q=80&w=2070&auto=format&fit=crop',
                    height: 400,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
            FadeInLeft(
              delay: const Duration(milliseconds: 200),
              child: const Text(
                'Document Details',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 20),
            FadeInUp(
              delay: const Duration(milliseconds: 400),
              child: GlassCard(
                child: Column(
                  children: [
                    _buildDetailRow(Icons.category_outlined, 'Category', 'Government IDs'),
                    const Divider(color: Colors.white10),
                    _buildDetailRow(Icons.calendar_today_outlined, 'Added on', 'May 14, 2026'),
                    const Divider(color: Colors.white10),
                    _buildDetailRow(Icons.verified_outlined, 'Status', 'Verified by AI'),
                    const Divider(color: Colors.white10),
                    _buildDetailRow(Icons.lock_outline, 'Encryption', 'AES-256 Enabled'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),
            FadeInLeft(
              delay: const Duration(milliseconds: 600),
              child: const Text(
                'Extracted Text (OCR)',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 15),
            FadeInUp(
              delay: const Duration(milliseconds: 800),
              child: GlassCard(
                child: const Text(
                  'GOVERNMENT OF INDIA\nNAME: JOHN DOE\nDOB: 01/01/1990\nID: 1234 5678 9012\nADDRESS: 123, Fintech Street, Neo City.',
                  style: TextStyle(color: Colors.white70, height: 1.6),
                ),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, color: AppColors.primary, size: 20),
          const SizedBox(width: 15),
          Text(label, style: const TextStyle(color: Colors.white54)),
          const Spacer(),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
