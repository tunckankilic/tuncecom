import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tuncecom/consts/app_colors.dart';
import 'package:tuncecom/models/product_model.dart';
import 'package:tuncecom/providers/products_provider.dart';
import '../widgets/products/product_widget.dart';
import '../widgets/title_text.dart';
import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';

class SearchScreen extends StatefulWidget {
  static const routeName = '/SearchScreen';
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late TextEditingController searchTextController;
  String? currentCategory;
  List<ProductModel> filteredProducts = [];

  @override
  void initState() {
    searchTextController = TextEditingController();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    final args = ModalRoute.of(context)!.settings.arguments;
    if (args != null && args is String) {
      currentCategory = args;
      filterProducts();
    }
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    searchTextController.dispose();
    super.dispose();
  }

  void filterProducts() {
    final productsProvider =
        Provider.of<ProductsProvider>(context, listen: false);
    if (currentCategory != null) {
      filteredProducts =
          productsProvider.findByCategory(categoryName: currentCategory!);
    } else {
      filteredProducts = productsProvider.products;
    }
    setState(() {});
  }

  void searchProducts(String searchText) {
    final productsProvider =
        Provider.of<ProductsProvider>(context, listen: false);
    setState(() {
      if (searchText.isEmpty && currentCategory != null) {
        filteredProducts =
            productsProvider.findByCategory(categoryName: currentCategory!);
      } else if (searchText.isEmpty) {
        filteredProducts = productsProvider.products;
      } else {
        filteredProducts = productsProvider.searchQuery(
          searchText: searchText,
          passedList: currentCategory != null
              ? productsProvider.findByCategory(categoryName: currentCategory!)
              : productsProvider.products,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(currentCategory ?? "Search products"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchTextController,
              decoration: InputDecoration(
                hintText: "Search",
                prefixIcon: const Icon(Icons.search),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    searchTextController.clear();
                    searchProducts('');
                  },
                ),
              ),
              onChanged: searchProducts,
            ),
          ),
          Expanded(
            child: filteredProducts.isEmpty
                ? Center(
                    child: Text(
                        "No products found in ${currentCategory ?? 'all categories'}"))
                : GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 2 / 3,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    itemCount: filteredProducts.length,
                    itemBuilder: (context, index) {
                      return ProductWidget(
                        productId: filteredProducts[index].productId,
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
