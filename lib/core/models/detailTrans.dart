class DetailTrans {
  final String status;
  final String orderId;
  final String courier;
  final String trackingNumber;
  final String shippingStatus;
  final String address;
  final String paymentMethod;
  final String? sellerNote;
  final List<Map<String, dynamic>> products;

  const DetailTrans({
    required this.status,
    required this.orderId,
    required this.courier,
    required this.trackingNumber,
    required this.shippingStatus,
    required this.address,
    required this.paymentMethod,
    this.sellerNote,
    required this.products,
  });

  int get totalPrice => products.fold(
        0,
        (sum, item) => sum +
            ((item['price'] as int) * (item['quantity'] as int)),
      );
}