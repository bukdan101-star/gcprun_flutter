import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/validators.dart';

class KycPage extends StatefulWidget {
  const KycPage({super.key});

  @override
  State<KycPage> createState() => _KycPageState();
}

class _KycPageState extends State<KycPage> {
  int _currentStep = 0;
  final _nikController = TextEditingController();
  final _fullNameController = TextEditingController();
  final _addressController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _nikController.dispose();
    _fullNameController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
        title: const Text('Verifikasi KYC'),
      ),
      body: Form(
        key: _formKey,
        child: Stepper(
          currentStep: _currentStep,
          onStepContinue: () {
            if (_currentStep < 2) {
              setState(() => _currentStep++);
            } else {
              _handleSubmit();
            }
          },
          onStepCancel: () {
            if (_currentStep > 0) {
              setState(() => _currentStep--);
            }
          },
          controlsBuilder: (context, details) {
            return Padding(
              padding: EdgeInsets.only(top: 16.h),
              child: Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 48.h,
                      child: ElevatedButton(
                        onPressed: details.onStepContinue,
                        child: Text(
                          _currentStep == 2 ? 'Kirim' : 'Lanjutkan',
                        ),
                      ),
                    ),
                  ),
                  if (_currentStep > 0) ...[
                    SizedBox(width: 12.w),
                    SizedBox(
                      height: 48.h,
                      width: 120.w,
                      child: OutlinedButton(
                        onPressed: details.onStepCancel,
                        child: const Text('Kembali'),
                      ),
                    ),
                  ],
                ],
              ),
            );
          },
          steps: [
            Step(
              title: Text(
                'Data Diri',
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              content: Column(
                children: [
                  TextFormField(
                    controller: _fullNameController,
                    validator: Validators.name,
                    decoration: InputDecoration(
                      labelText: 'Nama Lengkap (sesuai KTP)',
                      prefixIcon: const Icon(Icons.person_outlined),
                    ),
                  ),
                  SizedBox(height: 16.h),
                  TextFormField(
                    controller: _nikController,
                    keyboardType: TextInputType.number,
                    maxLength: 16,
                    validator: Validators.nik,
                    decoration: InputDecoration(
                      labelText: 'NIK (Nomor Induk Kependudukan)',
                      prefixIcon: const Icon(Icons.credit_card),
                      counterText: '',
                    ),
                  ),
                ],
              ),
              isActive: _currentStep >= 0,
              state: _currentStep > 0 ? StepState.complete : StepState.indexed,
            ),
            Step(
              title: Text(
                'Alamat',
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              content: TextFormField(
                controller: _addressController,
                maxLines: 3,
                validator: (value) => Validators.required(value, 'Alamat'),
                decoration: InputDecoration(
                  labelText: 'Alamat Lengkap',
                  prefixIcon: const Padding(
                    padding: EdgeInsets.only(bottom: 48),
                    child: Icon(Icons.location_on_outlined),
                  ),
                  alignLabelWithHint: true,
                ),
              ),
              isActive: _currentStep >= 1,
              state:
                  _currentStep > 1 ? StepState.complete : StepState.indexed,
            ),
            Step(
              title: Text(
                'Dokumen',
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              content: Column(
                children: [
                  Text(
                    'Unggah foto KTP Anda',
                    style: theme.textTheme.bodyMedium,
                  ),
                  SizedBox(height: 12.h),
                  _UploadBox(
                    label: 'Foto KTP (depan)',
                    onTap: () {},
                    theme: theme,
                  ),
                  SizedBox(height: 12.h),
                  _UploadBox(
                    label: 'Foto Selfie dengan KTP',
                    onTap: () {},
                    theme: theme,
                  ),
                ],
              ),
              isActive: _currentStep >= 2,
              state: StepState.indexed,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _handleSubmit() async {
    if (!_formKey.currentState!.validate()) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Dokumen KYC berhasil dikirim! Verifikasi akan memakan waktu 1-3 hari kerja.'),
        backgroundColor: AppColors.successGreen,
        behavior: SnackBarBehavior.floating,
      ),
    );
    Navigator.pop(context);
  }
}

class _UploadBox extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  final ThemeData theme;

  const _UploadBox({
    required this.label,
    required this.onTap,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 24.h),
        decoration: BoxDecoration(
          border: Border.all(
            color: theme.colorScheme.outline.withValues(alpha: 0.3),
            style: BorderStyle.solid,
          ),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Column(
          children: [
            Icon(
              Icons.cloud_upload_outlined,
              size: 36.sp,
              color: theme.colorScheme.outline,
            ),
            SizedBox(height: 8.h),
            Text(
              label,
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              'Ketuk untuk memilih file',
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurface.withValues(alpha: 0.4),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
