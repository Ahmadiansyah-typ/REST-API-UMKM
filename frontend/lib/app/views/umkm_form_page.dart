import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/umkm_controller.dart';

class UmkmFormPage extends StatefulWidget {
  const UmkmFormPage({super.key});

  @override
  State<UmkmFormPage> createState() => _UmkmFormPageState();
}

class _UmkmFormPageState extends State<UmkmFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _namaC = TextEditingController();
  final _pemilikC = TextEditingController();
  final _alamatC = TextEditingController();
  final _kategoriC = TextEditingController();
  final _kontakC = TextEditingController();
  final _controller = Get.find<UmkmController>();

  @override
  void dispose() {
    _namaC.dispose();
    _pemilikC.dispose();
    _alamatC.dispose();
    _kategoriC.dispose();
    _kontakC.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    final success = await _controller.createUmkm(
      nama: _namaC.text,
      pemilik: _pemilikC.text,
      alamat: _alamatC.text,
      kategori: _kategoriC.text,
      kontak: _kontakC.text,
    );

    if (!mounted) return;

    if (success) {
      Get.back();
      Get.snackbar(
        'Berhasil',
        _controller.responseMessage.value,
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(16),
      );
    } else {
      Get.snackbar(
        'Gagal menyimpan data',
        _controller.responseMessage.value,
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(16),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tambah UMKM')),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 28),
            children: [
              Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: const Color(0xFFE8F4F0),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.storefront_rounded, color: Color(0xFF176B5B), size: 28),
                    SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Lengkapi informasi usaha. Data akan dikirim ke REST API dan disimpan di database.',
                        style: TextStyle(color: Color(0xFF31584F), fontSize: 12),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              _FormField(
                controller: _namaC,
                label: 'Nama UMKM',
                hint: 'Contoh: Kopi Nusantara',
                icon: Icons.store_mall_directory_outlined,
                validator: (value) {
                  final text = value?.trim() ?? '';
                  if (text.isEmpty) return 'Nama UMKM wajib diisi';
                  if (text.length < 3) return 'Nama minimal 3 karakter';
                  return null;
                },
              ),
              const SizedBox(height: 14),
              _FormField(
                controller: _pemilikC,
                label: 'Pemilik',
                hint: 'Nama pemilik usaha',
                icon: Icons.person_outline,
              ),
              const SizedBox(height: 14),
              _FormField(
                controller: _alamatC,
                label: 'Alamat',
                hint: 'Alamat lengkap usaha',
                icon: Icons.location_on_outlined,
                maxLines: 2,
              ),
              const SizedBox(height: 14),
              _FormField(
                controller: _kategoriC,
                label: 'Kategori',
                hint: 'Contoh: Kuliner, Kerajinan, Fashion',
                icon: Icons.category_outlined,
              ),
              const SizedBox(height: 14),
              _FormField(
                controller: _kontakC,
                label: 'Kontak',
                hint: 'Nomor telepon atau WhatsApp',
                icon: Icons.phone_outlined,
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 24),
              Obx(
                () => FilledButton.icon(
                  onPressed: _controller.isSubmitting.value ? null : _submit,
                  icon: _controller.isSubmitting.value
                      ? const SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Icon(Icons.save_outlined),
                  label: Text(_controller.isSubmitting.value ? 'Menyimpan...' : 'Simpan UMKM'),
                  style: FilledButton.styleFrom(
                    minimumSize: const Size.fromHeight(52),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FormField extends StatelessWidget {
  const _FormField({
    required this.controller,
    required this.label,
    required this.hint,
    required this.icon,
    this.validator,
    this.keyboardType,
    this.maxLines = 1,
  });

  final TextEditingController controller;
  final String label;
  final String hint;
  final IconData icon;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      keyboardType: keyboardType,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: Icon(icon),
        alignLabelWithHint: maxLines > 1,
      ),
    );
  }
}
