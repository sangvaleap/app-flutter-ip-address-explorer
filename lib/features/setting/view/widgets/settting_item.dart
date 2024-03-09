import 'package:flutter/material.dart';
import 'package:ip_checker/core/style/app_color.dart';
import 'package:ip_checker/common/widgets/custom_icon_button.dart';

class SettingItem extends StatelessWidget {
  final String title;
  final GestureTapCallback? onTap;
  final Widget? trailing;
  final Widget? leading;
  const SettingItem(
      {super.key,
      required this.title,
      this.leading,
      this.onTap,
      this.trailing});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.horizontal(
            right: Radius.circular(15),
          ),
          color: Theme.of(context).cardColor,
          boxShadow: [
            BoxShadow(
              color: AppColor.shadowColor.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 1,
              offset: const Offset(0, 1), // changes position of shadow
            ),
          ],
        ),
        child: _buildItem(context),
      ),
    );
  }

  Widget _buildItem(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        if (leading != null) CustomIconButton(padding: 7, child: leading!),
        if (leading != null) const SizedBox(width: 20),
        Expanded(
          child: Text(
            title,
            style: const TextStyle(fontSize: 16),
          ),
        ),
        if (trailing != null) trailing!,
      ],
    );
  }
}
