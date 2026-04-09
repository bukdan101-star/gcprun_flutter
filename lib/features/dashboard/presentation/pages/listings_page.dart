import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/widgets/empty_state.dart';

class ListingsPage extends ConsumerWidget {
  const ListingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
        title: const Text('Listing Saya'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => context.push('/listing/create'),
            tooltip: 'Tambah Listing',
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push('/listing/create'),
        child: const Icon(Icons.add),
      ),
      body: EmptyState(
        icon: Icons.inventory_2_outlined,
        title: 'Belum Ada Listing',
        description: 'Mulai jual produk pertama Anda di GCPRUN',
        actionLabel: 'Buat Listing',
        onAction: () => context.push('/listing/create'),
      ),
    );
  }
}
