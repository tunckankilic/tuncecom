import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tuncecom/models/order_model.dart';

class OrderProvider with ChangeNotifier {
  final auth = FirebaseAuth.instance;
  final repo = FirebaseFirestore.instance;
  final List<OrdersModelAdvanced> orders = [];
  List get getOrders {
    return [...orders];
  }

  Future<List<OrdersModelAdvanced>> fetchOrders() async {
    final repo = FirebaseFirestore.instance;
    final uid = FirebaseAuth.instance.currentUser!.uid;

    try {
      final QuerySnapshot querySnapshot = await repo
          .collection("ordersAdvanced")
          .where("userId", isEqualTo: uid)
          .get();

      for (var element in querySnapshot.docs) {
        final quantityFromFirestore = element.get("quantity");
        final priceFromFirestore = element.get("price") as double;
        final totalPriceFromFirestore = element.get("totalPrice") as double;

        orders.add(OrdersModelAdvanced(
          orderId: element.get("orderId").toString(),
          userId: element.get("userId").toString(),
          productId: element.get("productId").toString(),
          productTitle: element.get("productTitle").toString(),
          userName: element.get("userName").toString(),
          price: priceFromFirestore,
          imageUrl: element.get("imageUrl").toString(),
          quantity: quantityFromFirestore is int
              ? quantityFromFirestore
              : quantityFromFirestore.toInt(),
          orderDate: element.get("orderDate") as Timestamp,
          totalPrice: totalPriceFromFirestore,
        ));
      }

      return orders;
    } catch (e) {
      log("Hata: $e");
      // Hata durumunda boş bir liste döndürün veya hata işleme stratejisi uygulayın.
      return [];
    }
  }
}
