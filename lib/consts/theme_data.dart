import 'package:flutter/material.dart';
import 'package:tuncecom/consts/app_colors.dart';
import 'package:tuncecom/consts/fonts_management.dart';
import 'package:tuncecom/consts/styles_management.dart';
import 'package:tuncecom/consts/values_management.dart';

class Styles {
  static ThemeData themeData(
      {required bool isDarkTheme, required BuildContext context}) {
    return ThemeData(
      scaffoldBackgroundColor: isDarkTheme
          ? AppColors.darkScaffoldColor
          : AppColors.lightScaffoldColor,
      cardColor: isDarkTheme
          ? const Color.fromARGB(255, 13, 6, 37)
          : AppColors.lightCardColor, //Main Colors
      primaryColor: AppColors.darkGrey,
      primaryColorLight: AppColors.primaryOpacity70,
      primaryColorDark: AppColors.darkPrimary,
      disabledColor: AppColors.grey1,
      colorScheme: ColorScheme.fromSwatch(
        brightness: isDarkTheme ? Brightness.dark : Brightness.light,
      ).copyWith(secondary: AppColors.grey),
      //Card Colors
      cardTheme: CardTheme(
        color: AppColors.white,
        shadowColor: AppColors.grey,
        elevation: AppSize.s4,
      ),
      //AppBar Colors
      appBarTheme: AppBarTheme(
        centerTitle: true,
        color: AppColors.primary,
        elevation: AppSize.s4,
        shadowColor: AppColors.primaryOpacity70,
        titleTextStyle: getRegularStyle(
          color: AppColors.white,
          fontSize: FontSize.s16,
        ),
      ),
      //Button Colors
      buttonTheme: ButtonThemeData(
        shape: const StadiumBorder(),
        disabledColor: AppColors.grey1,
        buttonColor: AppColors.primary,
        splashColor: AppColors.primaryOpacity70,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
        textStyle: getRegularStyle(color: AppColors.white),
        backgroundColor: AppColors.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSize.s12),
        ),
      )),
      //Text Colors
      textTheme: TextTheme(
        displayLarge:
            getSemiBoldStyle(color: AppColors.darkGrey, fontSize: FontSize.s16),
        titleSmall:
            getMediumStyle(color: AppColors.primary, fontSize: FontSize.s14),
        titleMedium:
            getMediumStyle(color: AppColors.lightGrey, fontSize: FontSize.s14),
        bodySmall: getRegularStyle(color: AppColors.darkPrimary),
        bodyLarge: getRegularStyle(color: AppColors.grey),
      ),
      inputDecorationTheme: InputDecorationTheme(
        contentPadding: const EdgeInsets.all(AppPadding.p8),
        hintStyle: getRegularStyle(
          color: AppColors.grey1,
        ),
        labelStyle: getMediumStyle(
          color: AppColors.darkGrey,
        ),
        errorStyle: getRegularStyle(
          color: AppColors.error,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.grey,
            width: AppSize.s1_5,
          ),
          borderRadius: BorderRadius.circular(AppSize.s8),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: AppColors.primary,
            width: AppSize.s1_5,
          ),
          borderRadius: BorderRadius.circular(AppSize.s8),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.error,
            width: AppSize.s1_5,
          ),
          borderRadius: BorderRadius.circular(AppSize.s8),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: AppColors.primary,
            width: AppSize.s1_5,
          ),
          borderRadius: BorderRadius.circular(AppSize.s8),
        ),
      ),
      // );
      //   return ThemeData(
      //       scaffoldBackgroundColor: isDarkTheme
      //           ? AppColors.darkScaffoldColor
      //           : AppColors.lightScaffoldColor,

      //       appBarTheme: AppBarTheme(
      //         iconTheme: IconThemeData(
      //           color: isDarkTheme ? Colors.white : Colors.black,
      //         ),
      //         backgroundColor: isDarkTheme
      //             ? AppColors.darkScaffoldColor
      //             : AppColors.lightScaffoldColor,
      //         elevation: 0,
      //         titleTextStyle: TextStyle(
      //           color: isDarkTheme ? Colors.white : Colors.black,
      //         ),
      //       ),
      //       inputDecorationTheme: InputDecorationTheme(
      //         filled: true,
      //         contentPadding: const EdgeInsets.all(10),
      //         enabledBorder: OutlineInputBorder(
      //           borderSide: const BorderSide(
      //             width: 1,
      //             color: Colors.transparent,
      //           ),
      //           borderRadius: BorderRadius.circular(12),
      //         ),
      //         focusedBorder: OutlineInputBorder(
      //           borderSide: BorderSide(
      //             width: 1,
      //             color: isDarkTheme ? Colors.white : Colors.black,
      //           ),
      //           borderRadius: BorderRadius.circular(12),
      //         ),
      //         errorBorder: OutlineInputBorder(
      //           borderSide: BorderSide(
      //             width: 1,
      //             color: Theme.of(context).colorScheme.error,
      //           ),
      //           borderRadius: BorderRadius.circular(12.0),
      //         ),
      //         focusedErrorBorder: OutlineInputBorder(
      //           borderSide: BorderSide(
      //             width: 1,
      //             color: Theme.of(context).colorScheme.error,
      //           ),
      //           borderRadius: BorderRadius.circular(12.0),
      //         ),
      //       ));
    );
  }
}
