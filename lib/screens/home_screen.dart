import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tuncecom/consts/app_colors.dart';
import 'package:tuncecom/consts/app_constants.dart';
import 'package:tuncecom/providers/theme_provider.dart';
import 'package:tuncecom/screens/diy/diy_screen.dart';
import 'package:tuncecom/widgets/products/ctg_rounded_widget.dart';
import 'package:tuncecom/widgets/products/latest_arrival.dart';

import '../providers/products_provider.dart';
import '../widgets/app_name_text.dart';
import '../widgets/title_text.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final productsProvider = Provider.of<ProductsProvider>(context);
    final themeProvider = Provider.of<ThemeProvider>(context);
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
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
          leading: const Icon(Icons.ac_unit),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(DIYScreen.routeName);
              },
              icon: const Icon(Icons.ac_unit),
            ),
          ],
          title: const AppNameTextWidget(
            fontSize: 20,
            text: "Home Screen",
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 15,
                ),
                SizedBox(
                  height: size.height * 0.25,
                  child: ClipRRect(
                    // borderRadius: BorderRadius.circular(50),
                    child: Swiper(
                      autoplay: true,
                      itemBuilder: (BuildContext context, int index) {
                        return Image.asset(
                          AppConstants.bannersImages[index],
                          fit: BoxFit.fill,
                        );
                      },
                      itemCount: AppConstants.bannersImages.length,
                      pagination: const SwiperPagination(
                        // alignment: Alignment.center,
                        builder: DotSwiperPaginationBuilder(
                            activeColor: Colors.red, color: Colors.white),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15.0,
                ),
                Visibility(
                  visible: productsProvider.getProducts.isNotEmpty,
                  child: const TitlesTextWidget(
                    label: "Latest arrival",
                    color: Colors.white,
                  ),
                ),
                const SizedBox(
                  height: 15.0,
                ),
                Visibility(
                  visible: productsProvider.getProducts.isNotEmpty,
                  child: SizedBox(
                    height: size.height * 0.2,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: productsProvider.getProducts.length < 10
                            ? productsProvider.getProducts.length
                            : 10,
                        itemBuilder: (context, index) {
                          return ChangeNotifierProvider.value(
                              value: productsProvider.getProducts[index],
                              child: const LatestArrivalProductsWidget());
                        }),
                  ),
                ),
                const TitlesTextWidget(
                  label: "Categories",
                  color: Colors.white,
                ),
                const SizedBox(
                  height: 15.0,
                ),
                GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 4,
                  children: List.generate(AppConstants.categoriesList.length,
                      (index) {
                    return CategoryRoundedWidget(
                      image: AppConstants.categoriesList[index].image,
                      name: AppConstants.categoriesList[index].name,
                    );
                  }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
