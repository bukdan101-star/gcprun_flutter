import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DashboardShell extends StatelessWidget {
  final Widget child;

  const DashboardShell({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: _BottomNavBar(),
    );
  }
}

class _BottomNavBar extends StatefulWidget {
  @override
  State<_BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<_BottomNavBar> {
  int _currentIndex = 0;

  final _screens = [
    _NavScreen(route: '/dashboard', icon: Icons.home_outlined, label: 'Beranda'),
    _NavScreen(route: '/marketplace', icon: Icons.storefront_outlined, label: 'Marketplace'),
    _NavScreen(route: '/dashboard/messages', icon: Icons.chat_bubble_outline, label: 'Pesan'),
    _NavScreen(route: '/dashboard/orders', icon: Icons.receipt_long_outlined, label: 'Pesanan'),
    _NavScreen(route: '/dashboard/profile', icon: Icons.person_outline, label: 'Profil'),
  ];

  void _onTap(int index) {
    setState(() => _currentIndex = index);
    context.go(_screens[index].route);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // Detect current route to set active index
    final location = GoRouterState.of(context).matchedLocation;
    int activeIndex = 0;
    if (location.startsWith('/dashboard/messages')) {
      activeIndex = 2;
    } else if (location.startsWith('/dashboard/orders')) {
      activeIndex = 3;
    } else if (location.startsWith('/dashboard/profile')) {
      activeIndex = 4;
    } else if (location.startsWith('/marketplace')) {
      activeIndex = 1;
    } else if (location.startsWith('/dashboard')) {
      activeIndex = 0;
    }

    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 20,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.only(top: 4, bottom: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(_screens.length, (index) {
              final screen = _screens[index];
              final isActive = index == activeIndex;

              return _NavItem(
                icon: screen.icon,
                label: screen.label,
                isActive: isActive,
                onTap: () => _onTap(index),
                activeColor: theme.colorScheme.primary,
                inactiveColor: theme.colorScheme.outline,
              );
            }),
          ),
        ),
      ),
    );
  }
}

class _NavScreen {
  final String route;
  final IconData icon;
  final String label;

  const _NavScreen({
    required this.route,
    required this.icon,
    required this.label,
  });
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isActive;
  final VoidCallback onTap;
  final Color activeColor;
  final Color inactiveColor;

  const _NavItem({
    required this.icon,
    required this.label,
    required this.isActive,
    required this.onTap,
    required this.activeColor,
    required this.inactiveColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Container(
        width: 64,
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 24,
              color: isActive ? activeColor : inactiveColor,
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: TextStyle(
                fontSize: 11,
                fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
                color: isActive ? activeColor : inactiveColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
