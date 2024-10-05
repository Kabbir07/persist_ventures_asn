import 'package:flutter/material.dart';

// make custom text widget with optional named parameters

class CText extends StatelessWidget {
  final String text;
  final double? size;
  final Color? color;
  final FontWeight? weight;
  final TextAlign? align;
  final TextOverflow? overflow;
  // add decorations
  final TextDecoration? decoration;
  const CText(
    this.text, {
    super.key,
    this.size,
    this.color,
    this.weight,
    this.align,
    this.overflow,
    this.decoration,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: size,
        color: color,
        fontWeight: weight,
        decoration: decoration,
      ),
      textAlign: align,
      overflow: overflow,
    );
  }
}
