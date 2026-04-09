import '../../../../core/network/api_client.dart';
import '../../../../core/network/api_response.dart';
import '../../../../core/constants/api_constants.dart';
import '../../domain/entities/wallet_entity.dart';

class WalletRemoteDatasource {
  final ApiClient _apiClient;

  WalletRemoteDatasource(this._apiClient);

  Future<ApiResponse<WalletEntity>> getWallet() async {
    return _apiClient.get<WalletEntity>(
      ApiConstants.wallet,
      fromJson: (data) => _parseWallet(data as Map<String, dynamic>),
    );
  }

  Future<ApiResponse<List<WalletTransactionEntity>>> getTransactions({int page = 1, int limit = 20}) async {
    return _apiClient.get<List<WalletTransactionEntity>>(
      ApiConstants.walletTransactions,
      queryParameters: {'page': page, 'limit': limit},
      fromJson: (data) {
        if (data is List) {
          return data.map((e) => _parseTransaction(e as Map<String, dynamic>)).toList();
        }
        final items = data['items'] as List? ?? [];
        return items.map((e) => _parseTransaction(e as Map<String, dynamic>)).toList();
      },
    );
  }

  Future<ApiResponse<WalletTransactionEntity>> topUp({required int amount, required String paymentMethod}) async {
    return _apiClient.post<WalletTransactionEntity>(
      ApiConstants.topUp,
      data: {'amount': amount, 'paymentMethod': paymentMethod},
      fromJson: (data) => _parseTransaction(data as Map<String, dynamic>),
    );
  }

  Future<ApiResponse<WithdrawRequestEntity>> requestWithdrawal({
    required int amount,
    required String bankName,
    required String accountNumber,
    required String accountHolder,
  }) async {
    return _apiClient.post<WithdrawRequestEntity>(
      ApiConstants.withdraw,
      data: {
        'amount': amount,
        'bankName': bankName,
        'accountNumber': accountNumber,
        'accountHolder': accountHolder,
      },
      fromJson: (data) => _parseWithdraw(data as Map<String, dynamic>),
    );
  }

  Future<ApiResponse<List<WithdrawRequestEntity>>> getWithdrawHistory({int page = 1}) async {
    return _apiClient.get<List<WithdrawRequestEntity>>(
      ApiConstants.withdrawHistory,
      queryParameters: {'page': page},
      fromJson: (data) {
        if (data is List) {
          return data.map((e) => _parseWithdraw(e as Map<String, dynamic>)).toList();
        }
        final items = data['items'] as List? ?? [];
        return items.map((e) => _parseWithdraw(e as Map<String, dynamic>)).toList();
      },
    );
  }

  WalletEntity _parseWallet(Map<String, dynamic> json) {
    return WalletEntity(
      id: json['id'] as String? ?? '',
      balance: (json['balance'] as num?)?.toInt() ?? 0,
      totalIncome: (json['totalIncome'] as num?)?.toInt() ?? 0,
      totalExpense: (json['totalExpense'] as num?)?.toInt() ?? 0,
      pendingBalance: (json['pendingBalance'] as num?)?.toInt() ?? 0,
    );
  }

  WalletTransactionEntity _parseTransaction(Map<String, dynamic> json) {
    return WalletTransactionEntity(
      id: json['id'] as String? ?? '',
      type: json['type'] as String? ?? 'credit',
      status: json['status'] as String? ?? 'completed',
      amount: (json['amount'] as num?)?.toInt() ?? 0,
      description: json['description'] as String?,
      referenceId: json['referenceId'] as String?,
      createdAt: json['createdAt'] as String?,
    );
  }

  WithdrawRequestEntity _parseWithdraw(Map<String, dynamic> json) {
    return WithdrawRequestEntity(
      id: json['id'] as String? ?? '',
      amount: (json['amount'] as num?)?.toInt() ?? 0,
      status: json['status'] as String? ?? 'pending',
      bankName: json['bankName'] as String?,
      accountNumber: json['accountNumber'] as String?,
      accountHolder: json['accountHolder'] as String?,
      notes: json['notes'] as String?,
      createdAt: json['createdAt'] as String?,
      processedAt: json['processedAt'] as String?,
    );
  }
}
