import 'package:cloud_firestore/cloud_firestore.dart';

class OrdersModelAdvanced {
  final String orderId;
  final String userId;
  final String productId;
  final String productTitle;
  final String userName;
  final double price;
  final String imageUrl;
  final int quantity;
  final Timestamp orderDate;
  final double totalPrice;

  OrdersModelAdvanced({
    required this.orderId,
    required this.userId,
    required this.productId,
    required this.productTitle,
    required this.userName,
    required this.price,
    required this.imageUrl,
    required this.quantity,
    required this.orderDate,
    required this.totalPrice,
  });
}
