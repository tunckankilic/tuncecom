// ignore_for_file: public_member_api_docs, sort_constructors_first, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tuncecom/consts/app_colors.dart';

import 'package:tuncecom/models/diy_model.dart';
import 'package:tuncecom/providers/cart_provider.dart';
import 'package:tuncecom/providers/products_provider.dart';
import 'package:tuncecom/screens/inner_screen/product_details.dart';
import 'package:tuncecom/services/my_app_functions.dart';
import 'package:tuncecom/widgets/app_name_text.dart';

class DIYDetails extends StatelessWidget {
  final DIYModel productDetails;
  const DIYDetails({
    Key? key,
    required this.productDetails,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final productsProvider = Provider.of<ProductsProvider>(context);
    final cartProvider = Provider.of<CartProvider>(context);
    return Scaffold(
        appBar: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.lightScaffoldColor,
                  Colors.white38,
                  AppColors.lightScaffoldColor,
                ],
              ),
            ),
          ),
          leading: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(Icons.list),
            color: Colors.white,
          ),
          title: AppNameTextWidget(fontSize: 20, text: productDetails.title),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 300,
                child: Image.network(productDetails.imageUrl),
              ),
              TextField(
                readOnly: true,
                decoration: InputDecoration(
                  hintText: productDetails.description,
                ),
              ),
              Column(
                children: productDetails.steps.map((e) {
                  final prod = productsProvider.findByProdId(e);
                  return Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.white,
                        width: 2,
                      ),
                    ),
                    child: ListTile(
                      title: Text(prod!.productTitle),
                      onTap: () => Navigator.of(context).pushNamed(
                          ProductDetailsScreen.routeName,
                          arguments: prod.productId),
                      subtitle: Text(prod.productPrice),
                      leading: SizedBox(
                        height: 100,
                        width: 100,
                        child: Image.network(prod.productImage),
                      ),
                      trailing: IconButton(
                        onPressed: () async {
                          if (cartProvider.isProdinCart(
                              productId: prod.productId)) {
                            return;
                          }
                          try {
                            await cartProvider.addToCartFirebase(
                                productId: prod.productId,
                                qty: 1,
                                context: context);
                          } catch (e) {
                            await MyAppFunctions.showErrorOrWarningDialog(
                              context: context,
                              subtitle: e.toString(),
                              fct: () {},
                            );
                          }
                        },
                        icon: const Icon(
                          Icons.add,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ));
  }
}
