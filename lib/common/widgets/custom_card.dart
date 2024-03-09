import 'package:flutter/material.dart';
import 'package:ip_checker/core/style/app_color.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({
    super.key,
    required this.child,
    this.width,
    this.height,
    this.padding,
    this.radius = 10,
    this.bgColor,
  });

  final Widget child;
  final double? width;
  final double? height;
  final EdgeInsets? padding;
  final double radius;
  final Color? bgColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: padding,
      decoration: BoxDecoration(
        color: bgColor ?? Theme.of(context).cardColor,
        borderRadius: BorderRadius.all(Radius.circular(radius)),
        boxShadow: [
          BoxShadow(
            color: AppColor.shadowColor.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 1,
            offset: const Offset(0, 1), // changes position of shadow
          )
        ],
      ),
      child: child,
    );
  }
}
