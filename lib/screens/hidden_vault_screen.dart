import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import '../core/app_colors.dart';
import '../widgets/glass_card.dart';
import '../widgets/premium_button.dart';

class HiddenVaultScreen extends StatefulWidget {
  const HiddenVaultScreen({super.key});

  @override
  State<HiddenVaultScreen> createState() => _HiddenVaultScreenState();
}

class _HiddenVaultScreenState extends State<HiddenVaultScreen> {
  bool _isUnlocked = false;
  final TextEditingController _pinController = TextEditingController();

  void _unlockVault() {
    if (_pinController.text == '1234') {
      setState(() => _isUnlocked = true);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Invalid PIN! Try 1234'), backgroundColor: Colors.red),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hidden Vault'),
        leading: IconButton(
          onPressed: () => context.go('/dashboard'),
          icon: const Icon(Icons.arrow_back_ios_new),
        ),
      ),
      body: _isUnlocked ? _buildVaultContent() : _buildUnlockScreen(),
    );
  }

  Widget _buildUnlockScreen() {
    return Padding(
      padding: const EdgeInsets.all(30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FadeInDown(
            child: const Icon(Icons.lock_person_rounded, size: 80, color: AppColors.primary),
          ),
          const SizedBox(height: 20),
          const Text(
            'Secure Access Required',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          const Text(
            'Enter your secondary PIN to unlock the hidden vault.',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white54),
          ),
          const SizedBox(height: 40),
          GlassCard(
            child: TextField(
              controller: _pinController,
              obscureText: true,
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 24, letterSpacing: 10),
              decoration: const InputDecoration(
                hintText: 'PIN',
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                fillColor: Colors.transparent,
              ),
            ),
          ),
          const SizedBox(height: 30),
          PremiumButton(
            text: 'Unlock Vault',
            onPressed: _unlockVault,
          ),
        ],
      ),
    );
  }

  Widget _buildVaultContent() {
    return FadeIn(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Private Documents',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              'These files are encrypted and hidden from the main dashboard.',
              style: TextStyle(color: Colors.white54),
            ),
            const SizedBox(height: 30),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 15,
                ),
                itemCount: 0, // Placeholder for hidden docs
                itemBuilder: (context, index) => Container(),
              ),
            ),
            Center(
              child: Column(
                children: [
                  Icon(FontAwesomeIcons.folderOpen, size: 60, color: Colors.white.withOpacity(0.1)),
                  const SizedBox(height: 20),
                  const Text('No hidden documents yet', style: TextStyle(color: Colors.white24)),
                ],
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
