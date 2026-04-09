import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/network/api_client.dart';
import '../../../listing/data/datasources/listing_remote_datasource.dart';
import '../../../listing/domain/entities/listing_entity.dart';
import '../../../orders/domain/entities/order_entity.dart';
import '../../../orders/data/datasources/order_remote_datasource.dart';
import '../../../wallet/domain/entities/wallet_entity.dart';
import '../../../wallet/data/datasources/wallet_remote_datasource.dart';

class DashboardStats {
  final int activeListings;
  final int totalOrders;
  final int pendingOrders;
  final WalletEntity? wallet;
  final List<ListingEntity> recentListings;
  final List<OrderEntity> recentOrders;

  const DashboardStats({
    this.activeListings = 0,
    this.totalOrders = 0,
    this.pendingOrders = 0,
    this.wallet,
    this.recentListings = const [],
    this.recentOrders = const [],
  });
}

class DashboardState {
  final DashboardStats? stats;
  final bool isLoading;
  final String? error;

  const DashboardState({
    this.stats,
    this.isLoading = false,
    this.error,
  });

  DashboardState copyWith({
    DashboardStats? stats,
    bool? isLoading,
    String? error,
    bool clearError = false,
  }) {
    return DashboardState(
      stats: stats ?? this.stats,
      isLoading: isLoading ?? this.isLoading,
      error: clearError ? null : (error ?? this.error),
    );
  }
}

class DashboardNotifier extends Notifier<DashboardState> {
  late final ListingRemoteDatasource _listingDatasource;
  late final OrderRemoteDatasource _orderDatasource;
  late final WalletRemoteDatasource _walletDatasource;

  @override
  DashboardState build() {
    final apiClient = ApiClient();
    _listingDatasource = ListingRemoteDatasource(apiClient);
    _orderDatasource = OrderRemoteDatasource(apiClient);
    _walletDatasource = WalletRemoteDatasource(apiClient);
    return const DashboardState();
  }

  Future<void> loadDashboard() async {
    state = state.copyWith(isLoading: true, clearError: true);

    try {
      final results = await Future.wait([
        _listingDatasource.getMyListings(page: 1, limit: 5),
        _orderDatasource.getMyOrders(page: 1),
        _walletDatasource.getWallet(),
      ]);

      final listingsResponse = results[0];
      final ordersResponse = results[1];
      final walletResponse = results[2];

      final listings = listingsResponse.success ? listingsResponse.data ?? [] : <ListingEntity>[];
      final orders = ordersResponse.success ? ordersResponse.data ?? [] : <OrderEntity>[];
      final wallet = walletResponse.success ? walletResponse.data : null;

      state = DashboardState(
        stats: DashboardStats(
          activeListings: listings.where((l) => l.status == 'active').length,
          totalOrders: orders.length,
          pendingOrders: orders.where((o) => o.status == 'pending').length,
          wallet: wallet,
          recentListings: listings,
          recentOrders: orders.take(5).toList(),
        ),
      );
    } catch (e) {
      debugPrint('Dashboard load error: $e');
      state = state.copyWith(isLoading: false, error: 'Gagal memuat dashboard');
    }
  }

  void refresh() => loadDashboard();
}

final dashboardNotifierProvider = NotifierProvider<DashboardNotifier, DashboardState>(
  DashboardNotifier.new,
);
