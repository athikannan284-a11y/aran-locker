import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../screens/splash_screen.dart';
import '../screens/onboarding_screen.dart';
import '../screens/login_screen.dart';
import '../screens/otp_screen.dart';
import '../screens/dashboard_screen.dart';
import '../screens/document_viewer_screen.dart';
import '../screens/upload_screen.dart';

import '../screens/hidden_vault_screen.dart';
import '../screens/family_sharing_screen.dart';

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: '/onboarding',
        builder: (context, state) => const OnboardingScreen(),
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/otp',
        builder: (context, state) => const OTPScreen(),
      ),
      GoRoute(
        path: '/dashboard',
        builder: (context, state) => const DashboardScreen(),
      ),
      GoRoute(
        path: '/upload',
        builder: (context, state) => const UploadScreen(),
      ),
      GoRoute(
        path: '/view',
        builder: (context, state) => const DocumentViewerScreen(),
      ),
      GoRoute(
        path: '/hidden',
        builder: (context, state) => const HiddenVaultScreen(),
      ),
      GoRoute(
        path: '/family',
        builder: (context, state) => const FamilySharingScreen(),
      ),
    ],
  );
});
