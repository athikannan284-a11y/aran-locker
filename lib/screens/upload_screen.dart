import 'dart:io';
import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import '../core/app_colors.dart';
import '../widgets/premium_button.dart';
import '../widgets/glass_card.dart';

class UploadScreen extends StatefulWidget {
  const UploadScreen({super.key});

  @override
  State<UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  File? _selectedFile;
  bool _isProcessing = false;
  String _status = 'Upload your document';

  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _selectedFile = File(pickedFile.path);
        _status = 'File selected';
      });
      _processDocument();
    }
  }

  void _processDocument() async {
    setState(() {
      _isProcessing = true;
      _status = 'Scanning document with AI...';
    });

    // Simulate AI Scan
    await Future.delayed(const Duration(seconds: 3));
    if (mounted) {
      setState(() {
        _status = 'Aadhaar Card detected!';
      });
      await Future.delayed(const Duration(seconds: 1));
      if (mounted) {
        setState(() {
          _status = 'Extracting data...';
        });
        await Future.delayed(const Duration(seconds: 2));
        if (mounted) {
          setState(() {
            _isProcessing = false;
            _status = 'Success! Document classified.';
          });
          // Go back or show results
          _showResultDialog();
        }
      }
    }
  }

  void _showResultDialog() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => GlassCard(
        borderRadius: 30,
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'AI Scan Results',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            _buildResultField('Document Type', 'Aadhaar Card'),
            _buildResultField('Category', 'Government IDs'),
            _buildResultField('Confidence', '98.5%'),
            _buildResultField('Extracted Name', 'JOHN DOE'),
            _buildResultField('Document ID', 'XXXX-XXXX-1234'),
            const SizedBox(height: 30),
            PremiumButton(
              text: 'Save to Vault',
              onPressed: () {
                Navigator.pop(context);
                context.go('/dashboard');
              },
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildResultField(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Colors.white54)),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Document'),
        leading: IconButton(
          onPressed: () => context.go('/dashboard'),
          icon: const Icon(Icons.arrow_back_ios_new),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const SizedBox(height: 20),
            FadeInDown(
              child: GlassCard(
                padding: const EdgeInsets.all(40),
                child: Column(
                  children: [
                    if (_selectedFile == null) ...[
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.primary.withOpacity(0.1),
                        ),
                        child: const Icon(Icons.cloud_upload_outlined, size: 60, color: AppColors.primary),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'Select or Take a Photo',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ] else ...[
                      ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.file(_selectedFile!, height: 200, width: double.infinity, fit: BoxFit.cover),
                      ),
                    ],
                    const SizedBox(height: 20),
                    Text(
                      _status,
                      style: TextStyle(
                        color: _isProcessing ? AppColors.accent : Colors.white54,
                        fontWeight: _isProcessing ? FontWeight.bold : FontWeight.normal,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    if (_isProcessing) ...[
                      const SizedBox(height: 20),
                      const LinearProgressIndicator(color: AppColors.primary),
                    ],
                  ],
                ),
              ),
            ),
            const Spacer(),
            FadeInUp(
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () => _pickImage(ImageSource.gallery),
                      icon: const Icon(Icons.photo_library_outlined),
                      label: const Text('Gallery'),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 18),
                        side: BorderSide(color: Colors.white.withOpacity(0.1)),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      ),
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: PremiumButton(
                      text: 'Camera',
                      icon: Icons.camera_alt_outlined,
                      onPressed: () => _pickImage(ImageSource.camera),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
