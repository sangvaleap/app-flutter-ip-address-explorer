import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:ip_checker/core/utils/app_constant.dart';

class CustomTextField extends StatelessWidget {
  final bool readOnly;
  final bool obscureText;
  final Widget? leadingIcon;
  final Widget? suffixIcon;
  final String? errorText;
  final String? hintText;
  final String? labelText;
  final double fontSize;
  final double fontWeight;
  final int minLines;
  final int maxLines;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final GestureTapCallback? onTap;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final EdgeInsetsGeometry padding;

  const CustomTextField({
    super.key,
    this.onTap,
    this.onChanged,
    this.onSubmitted,
    this.keyboardType,
    this.controller,
    this.fontSize = 18,
    this.fontWeight = 400,
    this.hintText,
    this.labelText,
    this.readOnly = false,
    this.errorText,
    this.leadingIcon,
    this.suffixIcon,
    this.obscureText = false,
    this.minLines = 1,
    this.maxLines = 1,
    this.padding = const EdgeInsets.all(0),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.horizontal(left: Radius.circular(10)),
        color: Theme.of(context).cardColor,
      ),
      child: _buildTextField(context),
    );
  }

  /// Builds the internal [TextField] widget with the specified configurations.
  Widget _buildTextField(BuildContext context) {
    double lineHeight =
        MediaQuery.of(context).size.width > AppConstant.minIpadScreenSizeWidth
            ? 2.2
            : 2;
    return TextField(
      onTap: onTap,
      onChanged: onChanged,
      onSubmitted: onSubmitted,
      controller: controller,
      keyboardType: keyboardType,
      minLines: minLines,
      maxLines: maxLines,
      readOnly: readOnly,
      obscureText: obscureText,
      textAlignVertical: TextAlignVertical.center,
      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
        fontSize: fontSize,
        fontVariations: [FontVariation('wght', fontWeight)],
      ),
      decoration: InputDecoration(
        prefixIcon: leadingIcon,
        suffixIcon: suffixIcon,
        border: InputBorder.none,
        hintText: hintText,
        hintStyle: Theme.of(context).textTheme.bodySmall?.copyWith(
          fontVariations: [FontVariation('wght', fontWeight)],
          height: lineHeight,
        ),
        labelText: labelText,
        errorText: errorText,
      ),
    );
  }
}
