import 'package:flutter/material.dart';
import '../../utilities/utilities.dart';

class CustomIconButton extends StatelessWidget {
  const CustomIconButton({
    required this.icon,
    required this.height,
    required this.width,
    required this.onTap,
    this.margin,
    this.padding,
    this.bgColor,
    this.borderRadius,
    this.boxShadow,
    Key? key,
  }) : super(key: key);
  final VoidCallback onTap;
  final double height;
  final double width;
  final IconData icon;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final Color? bgColor;
  final BorderRadius? borderRadius;
  final BoxShadow? boxShadow;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius:
            borderRadius ?? BorderRadius.circular(Utilities.borderRadius / 3),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 2,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        borderRadius:
            borderRadius ?? BorderRadius.circular(Utilities.borderRadius / 3),
        color: bgColor ?? Theme.of(context).scaffoldBackgroundColor,
        child: InkWell(
          onTap: onTap,
          borderRadius:
              borderRadius ?? BorderRadius.circular(Utilities.borderRadius / 3),
          child: Container(
            height: height,
            width: width,
            alignment: Alignment.center,
            child: Icon(
              icon,
              color: Theme.of(context).primaryColor,
            ),
          ),
        ),
      ),
    );
  }
}
