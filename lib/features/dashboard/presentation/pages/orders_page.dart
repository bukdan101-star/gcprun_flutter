import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/widgets/empty_state.dart';

class OrdersPage extends StatelessWidget {
  const OrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          ),
          title: const Text('Pesanan Saya'),
          bottom: TabBar(
            isScrollable: true,
            tabAlignment: TabAlignment.start,
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            labelStyle: theme.textTheme.labelLarge?.copyWith(
              fontWeight: FontWeight.w600,
            ),
            unselectedLabelStyle: theme.textTheme.labelLarge?.copyWith(
              fontWeight: FontWeight.w500,
            ),
            tabs: const [
              Tab(text: 'Semua'),
              Tab(text: 'Aktif'),
              Tab(text: 'Selesai'),
              Tab(text: 'Dibatalkan'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            _OrdersTab(status: 'all'),
            _OrdersTab(status: 'active'),
            _OrdersTab(status: 'completed'),
            _OrdersTab(status: 'cancelled'),
          ],
        ),
      ),
    );
  }
}

class _OrdersTab extends StatelessWidget {
  final String status;

  const _OrdersTab({required this.status});

  @override
  Widget build(BuildContext context) {
    return EmptyState(
      icon: Icons.receipt_long_outlined,
      title: 'Belum Ada Pesanan',
      description: status == 'all'
          ? 'Pesanan Anda akan muncul di sini'
          : 'Tidak ada pesanan ${status == 'active' ? 'aktif' : status == 'completed' ? 'yang selesai' : 'yang dibatalkan'}',
      actionLabel: 'Jelajahi Marketplace',
      onAction: () => Navigator.popAndPushNamed(context, '/marketplace'),
    );
  }
}
