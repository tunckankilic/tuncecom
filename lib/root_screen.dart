import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';
import 'package:tuncecom/providers/cart_provider.dart';
import 'package:tuncecom/providers/products_provider.dart';
import 'package:tuncecom/providers/user_provider.dart';
import 'package:tuncecom/screens/cart/cart_screen.dart';
import 'package:tuncecom/screens/home_screen.dart';
import 'package:tuncecom/screens/profile_screen.dart';
import 'package:tuncecom/screens/search_screen.dart';

import 'providers/wishlist_provider.dart';

class RootScreen extends StatefulWidget {
  static const routeName = '/RootScreen';
  const RootScreen({super.key});

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  late List<Widget> screens;
  int currentScreen = 0;
  late PageController controller;
  bool isLoadingProd = true;
  @override
  void initState() {
    super.initState();
    screens = [
      const HomeScreen(),
      const SearchScreen(),
      const CartScreen(),
      const ProfileScreen(),
    ];
    controller = PageController(initialPage: currentScreen);
  }

  Future<void> fetchFCT() async {
    final productsProvider =
        Provider.of<ProductsProvider>(context, listen: false);
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final wishlistsProvider =
        Provider.of<WishlistProvider>(context, listen: false);

    try {
      await Future.wait([
        productsProvider.fetchProducts(),
        userProvider.fetchUserInfo(),
      ]);
      await Future.wait([
        cartProvider.fetchCart(),
        wishlistsProvider.fetchWishlist(),
      ]);
    } catch (error) {
      log(error.toString());
    }
  }

  @override
  void didChangeDependencies() {
    if (isLoadingProd) {
      fetchFCT();
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    return Scaffold(
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: controller,
        children: screens,
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: currentScreen,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 10,
        height: kBottomNavigationBarHeight,
        onDestinationSelected: (index) {
          setState(() {
            currentScreen = index;
          });
          controller.jumpToPage(currentScreen);
        },
        destinations: [
          const NavigationDestination(
            selectedIcon: Icon(
              IconlyBold.home,
              color: Colors.white,
            ),
            icon: Icon(
              IconlyLight.home,
              color: Colors.white,
            ),
            label: "Home",
          ),
          const NavigationDestination(
            selectedIcon: Icon(
              IconlyBold.search,
              color: Colors.white,
            ),
            icon: Icon(
              IconlyLight.search,
              color: Colors.white,
            ),
            label: "Search",
          ),
          NavigationDestination(
            selectedIcon: const Icon(
              IconlyBold.bag2,
              color: Colors.white,
            ),
            icon: Badge(
              backgroundColor: Colors.red[900],
              textColor: Colors.white,
              label: Text(cartProvider.getCartitems.length.toString()),
              child: const Icon(
                IconlyLight.bag2,
                color: Colors.white,
              ),
            ),
            label: "Cart",
          ),
          const NavigationDestination(
            selectedIcon: Icon(
              IconlyBold.profile,
              color: Colors.white,
            ),
            icon: Icon(
              IconlyLight.profile,
              color: Colors.white,
            ),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}
