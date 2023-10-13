import 'package:flutter/material.dart';
import 'package:tuncecom/root_screen.dart';
import 'package:tuncecom/screens/auth/forgot_password.dart';
import 'package:tuncecom/screens/auth/login.dart';
import 'package:tuncecom/screens/auth/register.dart';
import 'package:tuncecom/screens/diy/diy_screen.dart';
import 'package:tuncecom/screens/inner_screen/orders/orders_screen.dart';
import 'package:tuncecom/screens/inner_screen/product_details.dart';
import 'package:tuncecom/screens/inner_screen/viewed_recently.dart';
import 'package:tuncecom/screens/inner_screen/wishlist.dart';
import 'package:tuncecom/screens/search_screen.dart';

class Routes {
  static const String splashRoute = "/";
  static const String onBoardRoute = "/onBoard";
  static const String loginRoute = "/login";
  static const String registerRoute = "/register";
  static const String forgotPassRoute = "/fPass";
  static const String mainRoute = "/main";
  static const String storeDetailsRoute = "/sDetail";
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case RootScreen.routeName:
        return MaterialPageRoute(
          builder: (context) => const RootScreen(),
        );
      case ProductDetailsScreen.routeName:
        String productId = routeSettings.arguments as String;
        return MaterialPageRoute(
          builder: (context) => ProductDetailsScreen(
            productId: productId,
          ),
        );
      case WishlistScreen.routeName:
        return MaterialPageRoute(
          builder: (context) => const WishlistScreen(),
        );
      case ViewedRecentlyScreen.routeName:
        return MaterialPageRoute(
          builder: (context) => const ViewedRecentlyScreen(),
        );
      case RegisterScreen.routeName:
        return MaterialPageRoute(
          builder: (context) => const RegisterScreen(),
        );
      case LoginScreen.routeName:
        return MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        );
      case OrdersScreenFree.routeName:
        return MaterialPageRoute(
          builder: (context) => const OrdersScreenFree(),
        );
      case ForgotPasswordScreen.routeName:
        return MaterialPageRoute(
          builder: (context) => const ForgotPasswordScreen(),
        );
      case SearchScreen.routeName:
        return MaterialPageRoute(
          builder: (context) => const SearchScreen(),
        );
      case DIYScreen.routeName:
        return MaterialPageRoute(
          builder: (context) => const DIYScreen(),
        );
      default:
        return MaterialPageRoute(
            builder: (context) => Scaffold(
                  body: Center(
                    child: Text(
                      "404",
                      style: Theme.of(context).textTheme.displayLarge,
                    ),
                  ),
                ));
    }
  }
}
