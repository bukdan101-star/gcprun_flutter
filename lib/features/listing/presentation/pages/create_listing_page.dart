import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CreateListingPage extends StatefulWidget {
  final String? editListingId;

  const CreateListingPage({super.key, this.editListingId});

  @override
  State<CreateListingPage> createState() => _CreateListingPageState();
}

class _CreateListingPageState extends State<CreateListingPage> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _priceController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _locationController = TextEditingController();
  String _selectedCategory = 'Elektronik';
  String _selectedCondition = 'Baru';
  bool _isSubmitting = false;

  final _categories = [
    'Elektronik',
    'Komputer',
    'Smartphone',
    'Gaming',
    'Fashion',
    'Otomotif',
    'Rumah Tangga',
    'Kesehatan',
    'Olahraga',
    'Buku',
    'Lainnya',
  ];

  final _conditions = ['Baru', 'Bekas (Seperti Baru)', 'Bekas', 'Refurbished'];

  bool get _isEditing => widget.editListingId != null;

  @override
  void dispose() {
    _titleController.dispose();
    _priceController.dispose();
    _descriptionController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  Future<void> _handleSubmit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isSubmitting = true);
    await Future.delayed(const Duration(seconds: 2));

    if (mounted) {
      setState(() => _isSubmitting = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(_isEditing
              ? 'Listing berhasil diperbarui!'
              : 'Listing berhasil dibuat!'),
          backgroundColor: const Color(0xFF16A34A),
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
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(_isEditing ? 'Edit Listing' : 'Buat Listing Baru'),
        actions: [
          TextButton(
            onPressed: _isSubmitting ? null : _handleSubmit,
            child: _isSubmitting
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Color(0xFF2563EB),
                    ),
                  )
                : const Text('Publikasi'),
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(16.r),
          children: [
            // Image Upload
            Text(
              'Foto Produk',
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 8.h),
            SizedBox(
              height: 120.h,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: 5,
                separatorBuilder: (_, __) => SizedBox(width: 12.w),
                itemBuilder: (context, index) {
                  return index == 0
                      ? Container(
                          width: 120.w,
                          height: 120.h,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: theme.colorScheme.outline
                                  .withValues(alpha: 0.3),
                              style: BorderStyle.solid,
                            ),
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.add_photo_alternate_outlined,
                                size: 32.sp,
                                color: theme.colorScheme.outline,
                              ),
                              SizedBox(height: 4.h),
                              Text(
                                'Tambah Foto',
                                style:
                                    theme.textTheme.labelSmall?.copyWith(
                                  color: theme.colorScheme.outline,
                                ),
                              ),
                            ],
                          ),
                        )
                      : Container(
                          width: 120.w,
                          height: 120.h,
                          decoration: BoxDecoration(
                            color: theme
                                .colorScheme.surfaceContainerHighest,
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                        );
                },
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              'Foto pertama akan dijadikan foto utama (0/5)',
              style: theme.textTheme.labelSmall?.copyWith(
                color: theme.colorScheme.onSurface.withValues(alpha: 0.4),
              ),
            ),
            SizedBox(height: 20.h),

            // Title
            TextFormField(
              controller: _titleController,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Judul wajib diisi';
                }
                if (value.length < 10) {
                  return 'Judul minimal 10 karakter';
                }
                return null;
              },
              maxLength: 100,
              decoration: InputDecoration(
                labelText: 'Judul Produk',
                hintText: 'Contoh: iPhone 15 Pro Max 256GB',
                prefixIcon: const Icon(Icons.title),
              ),
            ),
            SizedBox(height: 16.h),

            // Category
            DropdownButtonFormField<String>(
              value: _selectedCategory,
              decoration: InputDecoration(
                labelText: 'Kategori',
                prefixIcon: const Icon(Icons.category_outlined),
              ),
              items: _categories
                  .map((cat) => DropdownMenuItem(
                        value: cat,
                        child: Text(cat),
                      ))
                  .toList(),
              onChanged: (value) {
                if (value != null) {
                  setState(() => _selectedCategory = value);
                }
              },
            ),
            SizedBox(height: 16.h),

            // Condition
            DropdownButtonFormField<String>(
              value: _selectedCondition,
              decoration: InputDecoration(
                labelText: 'Kondisi',
                prefixIcon: const Icon(Icons.verified_outlined),
              ),
              items: _conditions
                  .map((cond) => DropdownMenuItem(
                        value: cond,
                        child: Text(cond),
                      ))
                  .toList(),
              onChanged: (value) {
                if (value != null) {
                  setState(() => _selectedCondition = value);
                }
              },
            ),
            SizedBox(height: 16.h),

            // Price
            TextFormField(
              controller: _priceController,
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Harga wajib diisi';
                }
                final price = int.tryParse(value);
                if (price == null || price <= 0) {
                  return 'Harga tidak valid';
                }
                return null;
              },
              decoration: InputDecoration(
                labelText: 'Harga',
                hintText: '0',
                prefixText: 'Rp ',
                prefixIcon: const Icon(Icons.payments),
              ),
            ),
            SizedBox(height: 16.h),

            // Location
            TextFormField(
              controller: _locationController,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Lokasi wajib diisi';
                }
                return null;
              },
              decoration: InputDecoration(
                labelText: 'Lokasi',
                hintText: 'Contoh: Jakarta Selatan',
                prefixIcon: const Icon(Icons.location_on_outlined),
              ),
            ),
            SizedBox(height: 16.h),

            // Description
            TextFormField(
              controller: _descriptionController,
              maxLines: 5,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Deskripsi wajib diisi';
                }
                if (value.length < 20) {
                  return 'Deskripsi minimal 20 karakter';
                }
                return null;
              },
              decoration: InputDecoration(
                labelText: 'Deskripsi',
                hintText: 'Jelaskan detail produk, kondisi, dan kelengkapan',
                prefixIcon: const Padding(
                  padding: EdgeInsets.only(bottom: 64),
                  child: Icon(Icons.description),
                ),
                alignLabelWithHint: true,
              ),
            ),
            SizedBox(height: 32.h),
          ],
        ),
      ),
    );
  }
}
