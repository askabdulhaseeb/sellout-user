import 'package:flutter/material.dart';
import '../../utilities/utilities.dart';

class CustomScoreButton extends StatelessWidget {
  const CustomScoreButton({
    required this.score,
    required this.title,
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
  final String score;
  final String title;
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
            borderRadius ?? BorderRadius.circular(Utilities.borderRadius / 2),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 2,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      // child: Material(
      //   borderRadius:
      //       borderRadius ?? BorderRadius.circular(Utilities.borderRadius / 2),
      //   color: bgColor ?? Theme.of(context).scaffoldBackgroundColor,
      child: InkWell(
        onTap: onTap,
        borderRadius:
            borderRadius ?? BorderRadius.circular(Utilities.borderRadius / 2),
        child: Container(
          height: height,
          width: width,
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                score,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                  fontSize: 18,
                ),
              ),
              Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 9),
              ),
            ],
          ),
        ),
      ),
      // ),
    );
  }
}
