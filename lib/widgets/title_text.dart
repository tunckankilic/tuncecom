import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TitlesTextWidget extends StatelessWidget {
  const TitlesTextWidget({
    Key? key,
    required this.label,
    this.fontSize = 20,
    this.color = Colors.black,
    this.maxLines,
    this.fontWeight = FontWeight.w500,
  }) : super(key: key);
  final FontWeight fontWeight;
  final String label;
  final double fontSize;
  final Color? color;
  final int? maxLines;
  @override
  Widget build(BuildContext context) {
    return Text(label,
        maxLines: maxLines,
        // textAlign: TextAlign.justify,
        style: Theme.of(context).textTheme.titleLarge!.copyWith(
            fontWeight: fontWeight, fontSize: fontSize, color: color));
  }
}
