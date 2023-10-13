// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';
import 'package:tuncecom/consts/app_colors.dart';
import 'package:tuncecom/screens/auth/login.dart';
import 'package:tuncecom/screens/inner_screen/viewed_recently.dart';
import 'package:tuncecom/screens/inner_screen/wishlist.dart';
import 'package:tuncecom/screens/loading_manager.dart';
import 'package:tuncecom/services/assets_manager.dart';
import 'package:tuncecom/widgets/subtitle_text.dart';

import '../models/user_model.dart';
import '../providers/theme_provider.dart';
import '../providers/user_provider.dart';
import '../services/my_app_functions.dart';
import '../widgets/app_name_text.dart';
import '../widgets/title_text.dart';
import 'inner_screen/orders/orders_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  User? user = FirebaseAuth.instance.currentUser;
  UserModel? userModel;
  bool _isLoading = true;
  Future<void> fetchUserInfo() async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      setState(() {
        _isLoading = true;
      });
      userModel = await userProvider.fetchUserInfo();
    } catch (error) {
      await MyAppFunctions.showErrorOrWarningDialog(
        context: context,
        subtitle: error.toString(),
        fct: () {},
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void initState() {
    fetchUserInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final themeProvider = Provider.of<ThemeProvider>(context);
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
        leading: const Icon(Icons.ac_unit),
        actions: [
          IconButton(
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
            },
            icon: const Icon(Icons.logout_outlined),
          ),
        ],
        title: const AppNameTextWidget(
          fontSize: 20,
          text: "Profile Screen",
        ),
      ),
      body: LoadingManager(
        isLoading: _isLoading,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Visibility(
                visible: user == null ? true : false,
                child: const Padding(
                  padding: EdgeInsets.all(18.0),
                  child: TitlesTextWidget(
                    label: "Please login to have unlimited access",
                  ),
                ),
              ),
              userModel == null
                  ? const SizedBox.shrink()
                  : Padding(
                      padding:
                          const EdgeInsets.only(left: 10, top: 20, bottom: 5),
                      child: Row(
                        children: [
                          Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Theme.of(context).cardColor,
                              border: Border.all(
                                  color:
                                      Theme.of(context).colorScheme.background,
                                  width: 3),
                              image: DecorationImage(
                                image: NetworkImage(
                                  userModel!.userImage,
                                ),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TitlesTextWidget(
                                label: userModel!.userName,
                                color: Colors.white,
                              ),
                              const SizedBox(
                                height: 6,
                              ),
                              SubtitleTextWidget(label: userModel!.userEmail)
                            ],
                          )
                        ],
                      ),
                    ),
              Padding(
                padding: const EdgeInsets.all(14.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Divider(
                      thickness: 1,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const TitlesTextWidget(
                      label: "General",
                      color: Colors.white,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Visibility(
                      visible: userModel == null ? false : true,
                      child: CustomListTile(
                        text: "All Order",
                        imagePath: AssetsManager.orderSvg,
                        function: () {
                          Navigator.pushNamed(
                            context,
                            OrdersScreenFree.routeName,
                          );
                        },
                      ),
                    ),
                    Visibility(
                      visible: userModel == null ? false : true,
                      child: CustomListTile(
                        text: "Wishlist",
                        imagePath: AssetsManager.wishlistSvg,
                        function: () {
                          Navigator.pushNamed(
                              context, WishlistScreen.routeName);
                        },
                      ),
                    ),
                    CustomListTile(
                      text: "Viewed recently",
                      imagePath: AssetsManager.recent,
                      function: () {
                        Navigator.pushNamed(
                            context, ViewedRecentlyScreen.routeName);
                      },
                    ),
                    CustomListTile(
                      text: "Address",
                      imagePath: AssetsManager.address,
                      function: () {},
                    ),
                    const SizedBox(height: 6),
                    const Divider(
                      thickness: 1,
                    ),
                    const SizedBox(height: 6),
                    const TitlesTextWidget(
                      label: "Settings",
                      color: Colors.white,
                    ),
                    const SizedBox(height: 10),
                    SwitchListTile(
                      secondary: Image.asset(
                        AssetsManager.theme,
                        height: 34,
                      ),
                      title: Text(
                        themeProvider.getIsDarkTheme
                            ? "Dark Mode"
                            : "Light Mode",
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      value: themeProvider.getIsDarkTheme,
                      onChanged: (value) {
                        themeProvider.setDarkTheme(themeValue: value);
                      },
                    ),
                  ],
                ),
              ),
              Center(
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        30.0,
                      ),
                    ),
                  ),
                  icon: Icon(user == null ? Icons.login : Icons.logout),
                  label: Text(user == null ? "Login" : "Logout"),
                  onPressed: () async {
                    if (user == null) {
                      Navigator.pushNamed(context, LoginScreen.routeName);
                    } else {
                      await MyAppFunctions.showErrorOrWarningDialog(
                        context: context,
                        subtitle: "Are you sure you want to SignOut",
                        fct: () async {
                          await FirebaseAuth.instance.signOut();
                          if (!mounted) return;
                          Navigator.pushReplacementNamed(
                              context, LoginScreen.routeName);
                        },
                        isError: false,
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomListTile extends StatelessWidget {
  const CustomListTile({
    super.key,
    required this.imagePath,
    required this.text,
    required this.function,
  });
  final String imagePath, text;
  final Function function;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        function();
      },
      title: SubtitleTextWidget(label: text),
      leading: Image.asset(
        imagePath,
        height: 34,
      ),
      trailing: const Icon(IconlyLight.arrowRight2),
    );
  }
}
