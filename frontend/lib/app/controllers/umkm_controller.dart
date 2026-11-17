import 'package:get/get.dart';

import '../models/umkm_model.dart';
import '../services/umkm_service.dart';

class UmkmController extends GetxController {
  UmkmController(this._service);

  final UmkmService _service;

  final RxList<Umkm> umkmList = <Umkm>[].obs;
  final RxBool isLoading = true.obs;
  final RxBool isSubmitting = false.obs;
  final RxString errorMessage = ''.obs;
  final RxString responseMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchUmkm();
  }

  Future<void> fetchUmkm({bool showLoading = true}) async {
    if (showLoading) isLoading.value = true;
    errorMessage.value = '';

    try {
      final result = await _service.getUmkmList();
      umkmList.assignAll(result);
    } catch (error) {
      errorMessage.value = error.toString();
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool> createUmkm({
    required String nama,
    String? pemilik,
    String? alamat,
    String? kategori,
    String? kontak,
  }) async {
    isSubmitting.value = true;
    responseMessage.value = '';

    try {
      final result = await _service.createUmkm(
        Umkm(
          namaUmkm: nama.trim(),
          pemilik: _clean(pemilik),
          alamat: _clean(alamat),
          kategori: _clean(kategori),
          kontak: _clean(kontak),
        ),
      );

      responseMessage.value =
          (result['message'] ?? 'Data UMKM berhasil ditambahkan').toString();
      await fetchUmkm(showLoading: false);
      return true;
    } catch (error) {
      responseMessage.value = error.toString();
      return false;
    } finally {
      isSubmitting.value = false;
    }
  }

  String? _clean(String? value) {
    final cleaned = value?.trim() ?? '';
    return cleaned.isEmpty ? null : cleaned;
  }
}
