import 'package:flutter/material.dart';

class AppText extends StatelessWidget {
  final String text;
  final double size;
  final Color? color;
  final FontWeight weight;
  final TextAlign align;

  const AppText(
    this.text, {
    super.key,
    this.size = 24,
    this.color,
    this.weight = FontWeight.w600,
    this.align = TextAlign.left,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: align,
      style: TextStyle(
        fontSize: size,
        color: color ?? Theme.of(context).textTheme.bodyMedium!.color,
        fontWeight: weight,
      ),
    );
  }
}
