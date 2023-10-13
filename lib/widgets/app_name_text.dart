// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tuncecom/consts/app_colors.dart';

import 'package:tuncecom/widgets/title_text.dart';

class AppNameTextWidget extends StatelessWidget {
  final String text;
  final Color? color;
  const AppNameTextWidget({
    Key? key,
    this.color,
    required this.text,
    this.fontWeight = FontWeight.w500,
    required this.fontSize,
  }) : super(key: key);
  final FontWeight fontWeight;
  final double fontSize;
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      period: Duration(seconds: 22),
      baseColor: Colors.red[900]!,
      highlightColor: AppColors.darkPrimary,
      child: TitlesTextWidget(
        label: text,
        fontSize: fontSize,
        fontWeight: fontWeight,
      ),
    );
  }
}
