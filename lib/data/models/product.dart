class Product {
  final int id;
  final int userId;
  final String namaProduct;
  final String deskripsi;
  final double harga;
  final int stock;
  final double berat;
  final String fotoCover;
  final String statusProduk;
  final int sold;
  final double rating;
  final String seller;

  Product({
    required this.id,
    required this.userId,
    required this.namaProduct,
    required this.deskripsi,
    required this.harga,
    required this.stock,
    required this.berat,
    required this.fotoCover,
    required this.statusProduk,
    this.sold = 0,
    this.rating = 0.0,
    this.seller = '',
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      userId: json['user_id'],
      namaProduct: (json['nama_product'] ?? json['nama_produk'] ?? '').toString(),
      deskripsi: (json['deskripsi'] ?? '').toString(),
      harga: double.tryParse(json['harga']?.toString() ?? '0') ?? 0,
      stock: int.tryParse(json['stock']?.toString() ?? '0') ?? 0,
      berat: double.tryParse(json['berat']?.toString() ?? '0') ?? 0,
      fotoCover: (json['foto_cover'] ?? json['cover_photo'] ?? '').toString(),
      statusProduk: (json['status_produk'] ?? '').toString(),
      sold: int.tryParse((json['sold'] ?? json['jumlah_terjual'] ?? 0).toString()) ?? 0,
      rating: double.tryParse(json['rating']?.toString() ?? '0') ?? 0,
      seller: _extractSeller(json),
    );
  }

  static String _extractSeller(Map<String, dynamic> json) {
    final user = json['user'];
    if (user is Map<String, dynamic>) {
      final toko = user['toko'];
      // kasus hasOne: object
      if (toko is Map<String, dynamic>) {
        return toko['nama_toko']?.toString() ?? (user['name']?.toString() ?? '');
      }
      // kasus hasMany: list
      if (toko is List && toko.isNotEmpty) {
        final first = toko.first;
        if (first is Map<String, dynamic>) {
          return first['nama_toko']?.toString() ?? (user['name']?.toString() ?? '');
        }
      }
      // fallback ke nama user bila toko null
      return user['name']?.toString() ?? '';
    }
    return '';
  }
}
