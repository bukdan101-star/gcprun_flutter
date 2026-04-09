import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/auth/presentation/pages/register_page.dart';
import '../../features/auth/presentation/providers/auth_provider.dart';
import '../../features/dashboard/presentation/pages/dashboard_shell.dart';
import '../../features/dashboard/presentation/pages/home_page.dart';
import '../../features/dashboard/presentation/pages/listings_page.dart';
import '../../features/dashboard/presentation/pages/orders_page.dart';
import '../../features/dashboard/presentation/pages/messages_page.dart';
import '../../features/dashboard/presentation/pages/profile_page.dart';
import '../../features/dashboard/presentation/pages/wallet_page.dart';
import '../../features/dashboard/presentation/pages/wishlist_page.dart';
import '../../features/dashboard/presentation/pages/notifications_page.dart';
import '../../features/dashboard/presentation/pages/kyc_page.dart';
import '../../features/dashboard/presentation/pages/coupons_page.dart';
import '../../features/dashboard/presentation/pages/ai_credit_score_page.dart';
import '../../features/dashboard/presentation/pages/support_page.dart';
import '../../features/dashboard/presentation/pages/settings_page.dart';
import '../../features/dashboard/presentation/pages/withdraw_page.dart';
import '../../features/auth/presentation/pages/forgot_password_page.dart';
import '../../features/marketplace/presentation/pages/marketplace_page.dart';
import '../../features/listing/presentation/pages/listing_detail_page.dart';
import '../../features/listing/presentation/pages/create_listing_page.dart';
import '../../features/messages/presentation/pages/chat_page.dart';
import '../../features/user/presentation/pages/user_profile_page.dart';
import '../presentation/pages/splash_page.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();

final routerProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authNotifierProvider);

  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/splash',
    debugLogDiagnostics: true,
    redirect: (context, state) {
      final isAuthRoute = state.matchedLocation.startsWith('/login') ||
          state.matchedLocation.startsWith('/register') ||
          state.matchedLocation.startsWith('/forgot-password') ||
          state.matchedLocation.startsWith('/reset-password');

      final isSplashRoute = state.matchedLocation == '/splash';

      if (isSplashRoute) return null;

      final isAuthenticated = authState.isAuthenticated;
      final isLoading = authState.isLoading;

      if (isLoading) return '/splash';

      if (!isAuthenticated && !isAuthRoute) return '/login';
      if (isAuthenticated && isAuthRoute) return '/dashboard';

      return null;
    },
    routes: [
      // Splash
      GoRoute(
        path: '/splash',
        builder: (context, state) => const SplashPage(),
      ),

      // Auth Routes
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: '/register',
        builder: (context, state) => const RegisterPage(),
      ),
      GoRoute(
        path: '/forgot-password',
        builder: (context, state) => const ForgotPasswordPage(),
      ),
      GoRoute(
        path: '/reset-password',
        builder: (context, state) => const _ResetPasswordPage(),
      ),

      // Marketplace (standalone)
      GoRoute(
        path: '/marketplace',
        builder: (context, state) => const MarketplacePage(),
      ),

      // Listing Detail
      GoRoute(
        path: '/listing/:id',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) {
          final id = state.pathParameters['id']!;
          return ListingDetailPage(listingId: id);
        },
      ),

      // Create Listing
      GoRoute(
        path: '/listing/create',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => const CreateListingPage(),
      ),

      // Edit Listing
      GoRoute(
        path: '/listing/edit/:id',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) {
          final id = state.pathParameters['id']!;
          return CreateListingPage(editListingId: id);
        },
      ),

      // Chat
      GoRoute(
        path: '/messages/:id',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) {
          final id = state.pathParameters['id']!;
          return ChatPage(conversationId: id);
        },
      ),

      // User Profile
      GoRoute(
        path: '/user/:username',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) {
          final username = state.pathParameters['username']!;
          return UserProfilePage(username: username);
        },
      ),

      // Dashboard ShellRoute with Bottom Navigation
      ShellRoute(
        builder: (context, state, child) => DashboardShell(child: child),
        routes: [
          GoRoute(
            path: '/dashboard',
            pageBuilder: (context, state) => const NoTransitionPage(
              child: HomePage(),
            ),
            routes: [
              GoRoute(
                path: 'profile',
                parentNavigatorKey: _rootNavigatorKey,
                builder: (context, state) => const ProfilePage(),
              ),
              GoRoute(
                path: 'listings',
                parentNavigatorKey: _rootNavigatorKey,
                builder: (context, state) => const ListingsPage(),
              ),
              GoRoute(
                path: 'orders',
                parentNavigatorKey: _rootNavigatorKey,
                builder: (context, state) => const OrdersPage(),
              ),
              GoRoute(
                path: 'wallet',
                parentNavigatorKey: _rootNavigatorKey,
                builder: (context, state) => const WalletPage(),
              ),
              GoRoute(
                path: 'withdraw',
                parentNavigatorKey: _rootNavigatorKey,
                builder: (context, state) => const WithdrawPage(),
              ),
              GoRoute(
                path: 'messages',
                parentNavigatorKey: _rootNavigatorKey,
                builder: (context, state) => const MessagesPage(),
              ),
              GoRoute(
                path: 'notifications',
                parentNavigatorKey: _rootNavigatorKey,
                builder: (context, state) => const NotificationsPage(),
              ),
              GoRoute(
                path: 'wishlist',
                parentNavigatorKey: _rootNavigatorKey,
                builder: (context, state) => const WishlistPage(),
              ),
              GoRoute(
                path: 'kyc',
                parentNavigatorKey: _rootNavigatorKey,
                builder: (context, state) => const KycPage(),
              ),
              GoRoute(
                path: 'coupons',
                parentNavigatorKey: _rootNavigatorKey,
                builder: (context, state) => const CouponsPage(),
              ),
              GoRoute(
                path: 'ai-credit-score',
                parentNavigatorKey: _rootNavigatorKey,
                builder: (context, state) => const AiCreditScorePage(),
              ),
              GoRoute(
                path: 'support',
                parentNavigatorKey: _rootNavigatorKey,
                builder: (context, state) => const SupportPage(),
              ),
              GoRoute(
                path: 'settings',
                parentNavigatorKey: _rootNavigatorKey,
                builder: (context, state) => const SettingsPage(),
              ),
            ],
          ),
        ],
      ),

      // Home (alias for dashboard)
      GoRoute(
        path: '/',
        redirect: (context, state) => '/dashboard',
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      appBar: AppBar(title: const Text('Halaman Tidak Ditemukan')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 64, color: Colors.grey),
            const SizedBox(height: 16),
            Text(
              'Halaman tidak ditemukan',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text(
              state.uri.toString(),
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.grey,
                  ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => context.go('/dashboard'),
              child: const Text('Kembali ke Beranda'),
            ),
          ],
        ),
      ),
    ),
  );
});

// Placeholder for reset password page (simple wrapper)
class _ResetPasswordPage extends StatelessWidget {
  const _ResetPasswordPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Atur Ulang Password')),
      body: const Center(child: Text('Atur Ulang Password')),
    );
  }
}
