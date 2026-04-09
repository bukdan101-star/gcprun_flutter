class WalletEntity {
  final String id;
  final int balance;
  final int totalIncome;
  final int totalExpense;
  final int pendingBalance;

  const WalletEntity({
    required this.id,
    required this.balance,
    required this.totalIncome,
    required this.totalExpense,
    required this.pendingBalance,
  });
}

class WalletTransactionEntity {
  final String id;
  final String type;
  final String status;
  final int amount;
  final String? description;
  final String? referenceId;
  final String? createdAt;

  const WalletTransactionEntity({
    required this.id,
    required this.type,
    required this.status,
    required this.amount,
    this.description,
    this.referenceId,
    this.createdAt,
  });

  bool get isCredit => type == 'credit' || type == 'topup';
  bool get isDebit => type == 'debit' || type == 'withdraw';
}

class WithdrawRequestEntity {
  final String id;
  final int amount;
  final String status;
  final String? bankName;
  final String? accountNumber;
  final String? accountHolder;
  final String? notes;
  final String? createdAt;
  final String? processedAt;

  const WithdrawRequestEntity({
    required this.id,
    required this.amount,
    required this.status,
    this.bankName,
    this.accountNumber,
    this.accountHolder,
    this.notes,
    this.createdAt,
    this.processedAt,
  });
}
