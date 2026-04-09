import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/utils/currency_formatter.dart';

class ListingDetailPage extends StatelessWidget {
  final String listingId;

  const ListingDetailPage({super.key, required this.listingId});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Produk'),
        actions: [
          IconButton(
            icon: const Icon(Icons.share_outlined),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.favorite_border),
            onPressed: () {},
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.r),
          child: Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.chat_bubble_outline),
                  label: const Text('Chat'),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                flex: 2,
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text(
                    'Beli Sekarang',
                    style: TextStyle(fontSize: 15.sp),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: ListView(
        children: [
          // Image
          Container(
            height: 300.h,
            width: double.infinity,
            color: theme.colorScheme.surfaceContainerHighest,
            child: Center(
              child: Icon(
                Icons.image_outlined,
                size: 64.sp,
                color: theme.colorScheme.outline,
              ),
            ),
          ),
          // Content
          Padding(
            padding: EdgeInsets.all(16.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Category
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 8.w,
                    vertical: 4.h,
                  ),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(6.r),
                  ),
                  child: Text(
                    'Elektronik',
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: theme.colorScheme.onPrimaryContainer,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                SizedBox(height: 12.h),
                // Title
                Text(
                  'iPhone 15 Pro Max 256GB Natural Titanium',
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 8.h),
                // Price
                Text(
                  CurrencyFormatter.format(22500000),
                  style: theme.textTheme.headlineSmall?.copyWith(
                    color: theme.colorScheme.primary,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(height: 16.h),
                // Seller Info
                Row(
                  children: [
                    Container(
                      width: 40.w,
                      height: 40.h,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: const LinearGradient(
                          colors: [Color(0xFF2563EB), Color(0xFF7C3AED)],
                        ),
                      ),
                      child: Center(
                        child: Text(
                          'AS',
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Apple Store Official',
                            style: theme.textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Row(
                            children: [
                              Icon(Icons.location_on,
                                  size: 12.sp,
                                  color: theme.colorScheme.outline),
                              SizedBox(width: 2.w),
                              Text(
                                'Jakarta Selatan',
                                style: theme.textTheme.labelSmall?.copyWith(
                                  color: theme.colorScheme.outline,
                                ),
                              ),
                              SizedBox(width: 8.w),
                              Icon(Icons.star,
                                  size: 12.sp, color: const Color(0xFFF59E0B)),
                              SizedBox(width: 2.w),
                              Text(
                                '4.9 (128)',
                                style: theme.textTheme.labelSmall?.copyWith(
                                  color: theme.colorScheme.outline,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.h),

                const Divider(),
                SizedBox(height: 16.h),

                // Description
                Text(
                  'Deskripsi',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  'iPhone 15 Pro Max 256GB Natural Titanium - Kondisi Baru, Segel\n\n'
                  'Spesifikasi:\n'
                  '• Chip A17 Pro\n'
                  '• Kamera 48MP Main + 12MP Ultra Wide + 12MP Telephoto\n'
                  '• Layar Super Retina XDR 6.7"\n'
                  '• Titanium Design\n'
                  '• USB-C\n'
                  '• Action Button\n\n'
                  'Kelengkapan:\n'
                  '• iPhone 15 Pro Max 256GB\n'
                  '• Kabel USB-C\n'
                  '• Dokumentasi',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                    height: 1.6,
                  ),
                ),
                SizedBox(height: 20.h),

                const Divider(),
                SizedBox(height: 16.h),

                // Condition & Shipping
                Text(
                  'Detail Produk',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 12.h),
                _DetailRow(
                  label: 'Kondisi',
                  value: 'Baru',
                  theme: theme,
                ),
                _DetailRow(
                  label: 'Kategori',
                  value: 'Elektronik > Smartphone',
                  theme: theme,
                ),
                _DetailRow(
                  label: 'Pengiriman',
                  value: 'Jakarta Selatan',
                  theme: theme,
                ),
                _DetailRow(
                  label: 'Diposting',
                  value: '15 Januari 2025',
                  theme: theme,
                ),
                SizedBox(height: 32.h),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  final String label;
  final String value;
  final ThemeData theme;

  const _DetailRow({
    required this.label,
    required this.value,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
            ),
          ),
          Text(
            value,
            style: theme.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
