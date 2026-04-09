import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/widgets/empty_state.dart';

class MessagesPage extends StatelessWidget {
  const MessagesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
        title: const Text('Pesan'),
      ),
      body: EmptyState(
        icon: Icons.chat_bubble_outline,
        title: 'Belum Ada Pesan',
        description: 'Pesan dari pembeli dan penjual akan muncul di sini',
        actionLabel: 'Jelajahi Marketplace',
        onAction: () => context.go('/marketplace'),
      ),
    );
  }
}
