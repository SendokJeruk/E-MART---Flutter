class Transaction {
  final int id;
  final String kodeTransaksi;
  final String? status;
  final double totalHarga;
  final double? totalOngkir;
  final DateTime createdAt;
  final List<DetailTransaction> detailTransaction;

  Transaction({
    required this.id,
    required this.kodeTransaksi,
    required this.status,
    required this.totalHarga,
    required this.totalOngkir,
    required this.createdAt,
    required this.detailTransaction,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      id: json['id'],
      kodeTransaksi: json['kode_transaksi'],
      status: json['status'],
      totalHarga: (json['total_harga'] as num).toDouble(),
      totalOngkir: json['total_ongkir'] != null
          ? (json['total_ongkir'] as num).toDouble()
          : null,
      createdAt: DateTime.parse(json['created_at']),
      detailTransaction: (json['detail_transaction'] as List)
          .map((e) => DetailTransaction.fromJson(e))
          .toList(),
    );
  }
}

class DetailTransaction {
  final int id;
  final int jumlah;
  final double harga;
  final double subtotal;
  final double totalBerat;
  final Product product;

  DetailTransaction({
    required this.id,
    required this.jumlah,
    required this.harga,
    required this.subtotal,
    required this.totalBerat,
    required this.product,
  });

  factory DetailTransaction.fromJson(Map<String, dynamic> json) {
    return DetailTransaction(
      id: json['id'],
      jumlah: json['jumlah'],
      harga: (json['harga'] as num).toDouble(),
      subtotal: (json['subtotal'] as num).toDouble(),
      totalBerat: (json['totalberat'] as num).toDouble(),
      product: Product.fromJson(json['product']),
    );
  }
}

class Product {
  final int id;
  final String namaProduct;
  final String fotoCover;
  final User user;

  Product({
    required this.id,
    required this.namaProduct,
    required this.fotoCover,
    required this.user,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      namaProduct: json['nama_product'],
      fotoCover: json['foto_cover'],
      user: User.fromJson(json['user']),
    );
  }
}

class User {
  final int id;
  final String name;
  final Toko? toko;

  User({
    required this.id,
    required this.name,
    this.toko,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      toko: json['toko'] != null ? Toko.fromJson(json['toko']) : null,
    );
  }
}

class Toko {
  final int id;
  final String namaToko;
  final AlamatToko? alamatToko;

  Toko({
    required this.id,
    required this.namaToko,
    this.alamatToko,
  });

  factory Toko.fromJson(Map<String, dynamic> json) {
    return Toko(
      id: json['id'],
      namaToko: json['nama_toko'],
      alamatToko: json['alamat_toko'] != null
          ? AlamatToko.fromJson(json['alamat_toko'])
          : null,
    );
  }
}

class AlamatToko {
  final int id;
  final String? kodeDomestik;

  AlamatToko({
    required this.id,
    this.kodeDomestik,
  });

  factory AlamatToko.fromJson(Map<String, dynamic> json) {
    return AlamatToko(
      id: json['id'],
      kodeDomestik: json['kode_domestik'],
    );
  }
}
