import 'package:intl/intl.dart';

class CurrencyFormatter {
  CurrencyFormatter._();

  static final NumberFormat _rupiahFormat = NumberFormat.currency(
    locale: 'id_ID',
    symbol: 'Rp ',
    decimalDigits: 0,
    name: 'IDR',
  );

  static final NumberFormat _compactFormat = NumberFormat.compactCurrency(
    locale: 'id_ID',
    symbol: 'Rp',
    decimalDigits: 0,
  );

  static String format(int? amount) {
    if (amount == null) return 'Rp 0';
    return _rupiahFormat.format(amount);
  }

  static String formatCompact(int? amount) {
    if (amount == null) return 'Rp 0';
    return _compactFormat.format(amount);
  }

  static String formatWithDecimal(double amount) {
    return _rupiahFormat.format(amount);
  }

  static String formatRaw(int amount) {
    final formatted = _rupiahFormat.format(amount);
    return formatted.replaceAll('Rp ', '').trim();
  }

  static int parse(String value) {
    final cleaned = value.replaceAll(RegExp(r'[^\d]'), '');
    return int.tryParse(cleaned) ?? 0;
  }

  static String formatDifference(int difference) {
    if (difference > 0) {
      return '+${format(difference)}';
    } else if (difference < 0) {
      return '-${format(difference.abs())}';
    }
    return 'Rp 0';
  }
}
