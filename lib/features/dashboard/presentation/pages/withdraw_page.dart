import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/currency_formatter.dart';

class WithdrawPage extends StatefulWidget {
  const WithdrawPage({super.key});

  @override
  State<WithdrawPage> createState() => _WithdrawPageState();
}

class _WithdrawPageState extends State<WithdrawPage> {
  final _amountController = TextEditingController();
  final _bankController = TextEditingController();
  final _accountController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  int _selectedBankIndex = 0;
  bool _isSubmitting = false;

  final _banks = ['BCA', 'BRI', 'Mandiri', 'BNI', 'CIMB Niaga'];
  int _availableBalance = 1250000;

  void _setMaxAmount() {
    _amountController.text = _availableBalance.toString();
  }

  @override
  void dispose() {
    _amountController.dispose();
    _bankController.dispose();
    _accountController.dispose();
    super.dispose();
  }

  Future<void> _handleWithdraw() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isSubmitting = true);
    await Future.delayed(const Duration(seconds: 2));
    if (mounted) {
      setState(() => _isSubmitting = false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Permintaan tarik dana berhasil dikirim!'),
          backgroundColor: Color(0xFF16A34A),
          behavior: SnackBarBehavior.floating,
        ),
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Tarik Dana'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(16.r),
          children: [
            // Available Balance
            Card(
              child: Padding(
                padding: EdgeInsets.all(20.r),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Saldo Tersedia',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onSurface
                            .withValues(alpha: 0.5),
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      CurrencyFormatter.format(_availableBalance),
                      style: theme.textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.w800,
                        color: theme.colorScheme.primary,
                      ),
                    ),
                    TextButton(
                      onPressed: _setMaxAmount,
                      child: const Text('Tarik Semua'),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 24.h),

            // Bank Selection
            Text(
              'Pilih Bank',
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 8.h),
            SizedBox(
              height: 48.h,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: _banks.length,
                separatorBuilder: (_, __) => SizedBox(width: 8.w),
                itemBuilder: (context, index) {
                  final isSelected = index == _selectedBankIndex;
                  return GestureDetector(
                    onTap: () => setState(() => _selectedBankIndex = index),
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? theme.colorScheme.primary
                            : theme.colorScheme.surfaceContainerHighest,
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Text(
                        _banks[index],
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: isSelected
                              ? Colors.white
                              : theme.colorScheme.onSurface,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 20.h),

            // Account Number
            TextFormField(
              controller: _accountController,
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Nomor rekening wajib diisi';
                }
                return null;
              },
              decoration: InputDecoration(
                labelText: 'Nomor Rekening',
                hintText: 'Masukkan nomor rekening',
                prefixIcon: const Icon(Icons.credit_card),
              ),
            ),
            SizedBox(height: 16.h),

            // Amount
            TextFormField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Jumlah penarikan wajib diisi';
                }
                final amount = int.tryParse(value);
                if (amount == null || amount <= 0) {
                  return 'Jumlah tidak valid';
                }
                if (amount > _availableBalance) {
                  return 'Saldo tidak mencukupi';
                }
                if (amount < 10000) {
                  return 'Minimal penarikan Rp 10.000';
                }
                return null;
              },
              decoration: InputDecoration(
                labelText: 'Jumlah Penarikan',
                hintText: 'Minimal Rp 10.000',
                prefixText: 'Rp ',
                prefixIcon: const Icon(Icons.payments),
              ),
            ),
            SizedBox(height: 16.h),

            // Info
            Container(
              padding: EdgeInsets.all(12.r),
              decoration: BoxDecoration(
                color: theme.colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.info_outline,
                    size: 18.sp,
                    color: theme.colorScheme.primary,
                  ),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: Text(
                      'Penarikan akan diproses dalam 1-3 hari kerja. Biaya admin Rp 2.500 per transaksi.',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onPrimaryContainer,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 24.h),

            // Submit Button
            SizedBox(
              height: 52.h,
              child: ElevatedButton(
                onPressed: _isSubmitting ? null : _handleWithdraw,
                child: _isSubmitting
                    ? const SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(
                          strokeWidth: 2.5,
                          color: Colors.white,
                        ),
                      )
                    : const Text('Tarik Dana'),
              ),
            ),
            SizedBox(height: 32.h),
          ],
        ),
      ),
    );
  }
}
