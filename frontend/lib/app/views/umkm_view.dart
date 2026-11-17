import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/umkm_controller.dart';
import '../models/umkm_model.dart';
import '../routes/app_routes.dart';

class UmkmView extends GetView<UmkmController> {
  const UmkmView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('UMKM Connect', style: TextStyle(fontWeight: FontWeight.w800)),
            Text(
              'Direktori usaha lokal',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
            ),
          ],
        ),
        actions: [
          IconButton(
            tooltip: 'Muat ulang data',
            onPressed: controller.fetchUmkm,
            icon: const Icon(Icons.refresh_rounded),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 16),
              child: _SummaryCard(controller: controller),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
              child: Text(
                'Daftar UMKM',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
              ),
            ),
            Expanded(
              child: Obx(() {
                if (controller.isLoading.value && controller.umkmList.isEmpty) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (controller.errorMessage.value.isNotEmpty &&
                    controller.umkmList.isEmpty) {
                  return _ErrorState(
                    message: controller.errorMessage.value,
                    onRetry: controller.fetchUmkm,
                  );
                }

                if (controller.umkmList.isEmpty) {
                  return RefreshIndicator(
                    onRefresh: controller.fetchUmkm,
                    child: ListView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      children: const [
                        SizedBox(height: 80),
                        _EmptyState(),
                      ],
                    ),
                  );
                }

                return RefreshIndicator(
                  onRefresh: controller.fetchUmkm,
                  child: ListView.separated(
                    padding: const EdgeInsets.fromLTRB(20, 2, 20, 100),
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemCount: controller.umkmList.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      return _UmkmCard(item: controller.umkmList[index]);
                    },
                  ),
                );
              }),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Get.toNamed(AppRoutes.umkmForm),
        icon: const Icon(Icons.add_business_rounded),
        label: const Text('Tambah UMKM'),
      ),
    );
  }
}

class _SummaryCard extends StatelessWidget {
  const _SummaryCard({required this.controller});

  final UmkmController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF176B5B),
        borderRadius: BorderRadius.circular(22),
      ),
      child: Row(
        children: [
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Kenali usaha di sekitar Anda',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  'Data ditampilkan langsung dari REST API.',
                  style: TextStyle(color: Color(0xFFD7EEE7), fontSize: 12),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Obx(
            () => Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.14),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  Text(
                    '${controller.umkmList.length}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const Text(
                    'UMKM',
                    style: TextStyle(color: Colors.white, fontSize: 11),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _UmkmCard extends StatelessWidget {
  const _UmkmCard({required this.item});

  final Umkm item;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFE6ECE9)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              color: const Color(0xFFE8F4F0),
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Icon(
              Icons.storefront_rounded,
              color: Color(0xFF176B5B),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.namaUmkm,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF193A33),
                  ),
                ),
                if ((item.kategori ?? '').isNotEmpty) ...[
                  const SizedBox(height: 5),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF0F6F3),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Text(
                        item.kategori!,
                        style: const TextStyle(
                          color: Color(0xFF176B5B),
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ],
                const SizedBox(height: 8),
                _InfoLine(icon: Icons.person_outline, text: item.pemilik ?? 'Pemilik belum diisi'),
                const SizedBox(height: 4),
                _InfoLine(icon: Icons.location_on_outlined, text: item.alamat ?? 'Alamat belum diisi'),
                if ((item.kontak ?? '').isNotEmpty) ...[
                  const SizedBox(height: 4),
                  _InfoLine(icon: Icons.phone_outlined, text: item.kontak!),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoLine extends StatelessWidget {
  const _InfoLine({required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 14, color: const Color(0xFF7B8C86)),
        const SizedBox(width: 6),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(fontSize: 12, color: Color(0xFF60716B)),
          ),
        ),
      ],
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 28),
      child: Column(
        children: [
          Icon(Icons.store_mall_directory_outlined, size: 54, color: Color(0xFF9BAAA4)),
          SizedBox(height: 12),
          Text('Belum ada data UMKM', style: TextStyle(fontWeight: FontWeight.w800)),
          SizedBox(height: 5),
          Text(
            'Tambahkan data UMKM pertama untuk mulai mengisi direktori.',
            textAlign: TextAlign.center,
            style: TextStyle(color: Color(0xFF71817B), fontSize: 12),
          ),
        ],
      ),
    );
  }
}

class _ErrorState extends StatelessWidget {
  const _ErrorState({required this.message, required this.onRetry});

  final String message;
  final Future<void> Function() onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(28),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.cloud_off_rounded, size: 48, color: Color(0xFFB45C4B)),
            const SizedBox(height: 12),
            const Text('Tidak dapat memuat data', style: TextStyle(fontWeight: FontWeight.w800)),
            const SizedBox(height: 6),
            Text(message, textAlign: TextAlign.center, style: const TextStyle(fontSize: 12)),
            const SizedBox(height: 16),
            FilledButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh_rounded),
              label: const Text('Coba lagi'),
            ),
          ],
        ),
      ),
    );
  }
}
