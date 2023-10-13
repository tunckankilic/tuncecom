import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tuncecom/models/diy_model.dart';
import 'package:tuncecom/screens/diy/diy_details.dart';
import 'package:tuncecom/widgets/app_name_text.dart';

class DIYScreen extends StatelessWidget {
  static const routeName = "/diy";

  const DIYScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppNameTextWidget(
          text: "DIY Screen",
          fontSize: 20,
        ),
      ),
      body: FutureBuilder<QuerySnapshot>(
        future: FirebaseFirestore.instance.collection('diyCollection').get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Hata: ${snapshot.error.toString()}'));
          } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('Hiç ürün bulunamadı.'));
          } else {
            final products = snapshot.data!.docs;
            return ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                DIYModel? productItem;
                List<dynamic> productDetails = [];
                for (var i = 0; i < products.length; i++) {
                  final productData =
                      products[index].data() as Map<String, dynamic>;
                  productDetails.add(productData);
                  final productId = productData['id'];
                  productDetails.add(productId);
                  final productName = productData['title'];
                  productDetails.add(productName);
                  final productDescription = productData['description'];
                  productDetails.add(productDescription);
                  final productImagePath = productData['imagePath'];
                  productDetails.add(productName);
                  final productSteps = List<String>.from(productData['steps']);
                  productItem = DIYModel(
                    description: productDescription,
                    id: productId,
                    imageUrl: productImagePath,
                    steps: productSteps,
                    title: productName,
                  );
                }

                return GestureDetector(
                  onTap: () {
                    navigateToProductDetails(context, productItem!);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                    child: Stack(
                      children: [
                        SizedBox(
                          height: 300,
                          child: Image.network(productItem!.imageUrl),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 130.0),
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              productItem.title,
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .copyWith(fontWeight: FontWeight.bold),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }

  Future<void> navigateToProductDetails(
    BuildContext context,
    DIYModel productItem,
  ) async {
    log('Sayfa geçişi yapılıyor.');
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DIYDetails(productDetails: productItem),
      ),
    );
  }
}
