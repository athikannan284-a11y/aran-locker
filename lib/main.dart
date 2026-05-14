import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/app_theme.dart';
import 'core/router.dart';
import 'services/firebase_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Note: Firebase initialization is commented out because google-services.json is needed.
  // await FirebaseService.initialize();
  runApp(const ProviderScope(child: VaultXApp()));
}

class VaultXApp extends ConsumerWidget {
  const VaultXApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);

    return MaterialApp.router(
      title: 'VaultX',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      routerConfig: router,
    );
  }
}
