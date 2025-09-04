class OrderItem {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final double price;
  final String status;

  OrderItem({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.price,
    required this.status,
  });
}