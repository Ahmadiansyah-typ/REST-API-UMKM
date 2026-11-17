class Umkm {
  const Umkm({
    this.id,
    required this.namaUmkm,
    this.pemilik,
    this.alamat,
    this.kategori,
    this.kontak,
  });

  final int? id;
  final String namaUmkm;
  final String? pemilik;
  final String? alamat;
  final String? kategori;
  final String? kontak;

  factory Umkm.fromJson(Map<String, dynamic> json) {
    return Umkm(
      id: json['id'] == null ? null : int.tryParse(json['id'].toString()),
      namaUmkm: (json['nama_umkm'] ?? '').toString(),
      pemilik: _nullableString(json['pemilik']),
      alamat: _nullableString(json['alamat']),
      kategori: _nullableString(json['kategori']),
      kontak: _nullableString(json['kontak']),
    );
  }

  Map<String, String> toFormData() {
    return {
      'nama_umkm': namaUmkm,
      'pemilik': pemilik ?? '',
      'alamat': alamat ?? '',
      'kategori': kategori ?? '',
      'kontak': kontak ?? '',
    };
  }

  static String? _nullableString(dynamic value) {
    if (value == null) return null;
    final text = value.toString().trim();
    return text.isEmpty ? null : text;
  }
}
