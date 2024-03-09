import 'package:flutter/material.dart';
import 'package:ip_checker/core/style/app_color.dart';

class CustomIconButton extends StatelessWidget {
  const CustomIconButton(
      {super.key,
      required this.child,
      this.bgColor,
      this.onTap,
      this.borderColor = Colors.transparent,
      this.radius = 50,
      this.padding = 5,
      this.isShadowed = true});
  final Widget child;
  final Color borderColor;
  final Color? bgColor;
  final double radius;
  final double padding;
  final GestureTapCallback? onTap;
  final bool isShadowed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(padding),
        decoration: BoxDecoration(
          color: bgColor ?? Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(radius),
          border: Border.all(color: borderColor),
          boxShadow: [
            if (isShadowed)
              BoxShadow(
                color: AppColor.shadowColor.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 1,
                offset: const Offset(0, 1), // changes position of shadow
              ),
          ],
        ),
        child: child,
      ),
    );
  }
}
