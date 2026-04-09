import '../entities/wallet_entity.dart';

abstract class WalletRepository {
  Future<WalletEntity> getWallet();
  Future<List<WalletTransactionEntity>> getTransactions({int page = 1, int limit = 20});
  Future<WalletTransactionEntity> topUp({required int amount, required String paymentMethod});
  Future<WithdrawRequestEntity> requestWithdrawal({required int amount, required String bankName, required String accountNumber, required String accountHolder});
  Future<List<WithdrawRequestEntity>> getWithdrawHistory({int page = 1});
}
