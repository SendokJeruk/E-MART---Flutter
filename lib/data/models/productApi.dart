import 'dart:convert';

List<Post> postFromJson(String str) =>
    List<Post>.from(json.decode(str).map((x) => Post.fromJson(x)));

String postToJson(List<Post> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Post {
  final int id;
  final int userId;
  final int categoryId;
  final String namaProduct;
  final String deskripsi;
  final String harga;
  final int stock;
  final String fotoCover;
  final String statusProduk;
  final DateTime createdAt;
  final DateTime updatedAt;

  Post({
    required this.id,
    required this.userId,
    required this.categoryId,
    required this.namaProduct,
    required this.deskripsi,
    required this.harga,
    required this.stock,
    required this.fotoCover,
    required this.statusProduk,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json["id"],
      userId: json["user_id"],
      categoryId: json["category_id"],
      namaProduct: json["nama_product"],
      deskripsi: json["deskripsi"],
      harga: json["harga"],
      stock: json["stock"],
      fotoCover: json["foto_cover"],
      statusProduk: json["status_produk"],
      createdAt: DateTime.parse(json["created_at"]),
      updatedAt: DateTime.parse(json["updated_at"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "category_id": categoryId,
    "nama_product": namaProduct,
    "deskripsi": deskripsi,
    "harga": harga,
    "stock": stock,
    "foto_cover": fotoCover,
    "status_produk": statusProduk,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}