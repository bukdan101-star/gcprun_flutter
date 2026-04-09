import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/widgets/empty_state.dart';

class MarketplacePage extends StatelessWidget {
  const MarketplacePage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Marketplace'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.tune),
            onPressed: () {},
          ),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          // Search
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(16.r),
              child: Container(
                padding:
                    EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                decoration: BoxDecoration(
                  color: theme.colorScheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Row(
                  children: [
                    Icon(Icons.search,
                        size: 20.sp, color: theme.colorScheme.outline),
                    SizedBox(width: 10.w),
                    Expanded(
                      child: Text(
                        'Cari produk di GCPRUN...',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.onSurface
                              .withValues(alpha: 0.4),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Categories
          SliverToBoxAdapter(
            child: SizedBox(
              height: 100.h,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                itemCount: _categories.length,
                separatorBuilder: (_, __) => SizedBox(width: 12.w),
                itemBuilder: (context, index) {
                  final cat = _categories[index];
                  return GestureDetector(
                    onTap: () {},
                    child: Column(
                      children: [
                        Container(
                          width: 56.w,
                          height: 56.h,
                          decoration: BoxDecoration(
                            color: cat.color.withValues(alpha: 0.12),
                            borderRadius: BorderRadius.circular(14.r),
                          ),
                          child: Icon(cat.icon, color: cat.color, size: 24.sp),
                        ),
                        SizedBox(height: 6.h),
                        Text(
                          cat.label,
                          style: theme.textTheme.labelSmall?.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
          SizedBox(height: 16.h),

          // Products
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            sliver: SliverGrid(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 12.h,
                crossAxisSpacing: 12.w,
                childAspectRatio: 0.68,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final product = _products[index];
                  return GestureDetector(
                    onTap: () =>
                        context.push('/listing/${product['id']}'),
                    child: Card(
                      clipBehavior: Clip.antiAlias,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Container(
                              color: theme.colorScheme.surfaceContainerHighest,
                              child: Center(
                                child: Icon(
                                  Icons.image_outlined,
                                  size: 32.sp,
                                  color: theme.colorScheme.outline,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.r),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  product['title'] as String,
                                  style: theme
                                      .textTheme.bodySmall
                                      ?.copyWith(
                                        fontWeight: FontWeight.w600,
                                      ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(height: 2.h),
                                Text(
                                  product['price'] as String,
                                  style: theme
                                      .textTheme.labelMedium
                                      ?.copyWith(
                                        color:
                                            theme.colorScheme.primary,
                                        fontWeight: FontWeight.w700,
                                      ),
                                ),
                                SizedBox(height: 4.h),
                                Row(
                                  children: [
                                    Icon(Icons.location_on_outlined,
                                        size: 12.sp,
                                        color: theme
                                            .colorScheme.outline),
                                    SizedBox(width: 2.w),
                                    Flexible(
                                      child: Text(
                                        product['location'] as String,
                                        style: theme
                                            .textTheme.labelSmall
                                            ?.copyWith(
                                              color: theme.colorScheme.outline,
                                              fontSize: 10.sp,
                                            ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                childCount: _products.length,
              ),
            ),
          ),
          SizedBox(height: 32.h),
        ],
      ),
    );
  }
}

class _Category {
  final IconData icon;
  final String label;
  final Color color;

  const _Category({
    required this.icon,
    required this.label,
    required this.color,
  });
}

const _categories = [
  _Category(icon: Icons.devices, label: 'Elektronik', color: Color(0xFF2563EB)),
  _Category(icon: Icons.computer, label: 'Komputer', color: Color(0xFF16A34A)),
  _Category(icon: Icons.phone_android, label: 'HP', color: Color(0xFF7C3AED)),
  _Category(icon: Icons.checkroom, label: 'Fashion', color: Color(0xFFD97706)),
  _Category(icon: Icons.sports_esports, label: 'Gaming', color: Color(0xFFDC2626)),
  _Category(icon: Icons.directions_car, label: 'Otomotif', color: Color(0xFF0891B2)),
  _Category(icon: Icons.home, label: 'Rumah', color: Color(0xFF65A30D)),
  _Category(icon: Icons.more_horiz, label: 'Lainnya', color: Color(0xFF737373)),
];

const _products = [
  {'id': '1', 'title': 'iPhone 15 Pro Max 256GB', 'price': 'Rp 22.500.000', 'location': 'Jakarta'},
  {'id': '2', 'title': 'MacBook Air M2 2024', 'price': 'Rp 18.750.000', 'location': 'Bandung'},
  {'id': '3', 'title': 'Samsung Galaxy S24 Ultra', 'price': 'Rp 14.200.000', 'location': 'Surabaya'},
  {'id': '4', 'title': 'PlayStation 5 Digital', 'price': 'Rp 6.800.000', 'location': 'Yogyakarta'},
  {'id': '5', 'title': 'iPad Air M2 256GB', 'price': 'Rp 9.500.000', 'location': 'Semarang'},
  {'id': '6', 'title': 'Sony WH-1000XM5', 'price': 'Rp 4.200.000', 'location': 'Jakarta'},
];
