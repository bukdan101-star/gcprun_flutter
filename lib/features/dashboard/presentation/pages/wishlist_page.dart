import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/widgets/empty_state.dart';
import '../../../../core/utils/currency_formatter.dart';

class WishlistPage extends StatelessWidget {
  const WishlistPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
        title: const Text('Wishlist'),
      ),
      body: EmptyState(
        icon: Icons.favorite_border,
        title: 'Wishlist Kosong',
        description: 'Simpan produk yang Anda minati untuk nanti',
        actionLabel: 'Jelajahi Marketplace',
        onAction: () => context.go('/marketplace'),
      ),
    );
  }
}
