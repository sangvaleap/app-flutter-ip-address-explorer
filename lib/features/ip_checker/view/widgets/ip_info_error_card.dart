import 'package:flutter/material.dart';
import 'package:ip_checker/core/utils/app_constant.dart';
import 'package:ip_checker/common/widgets/custom_card.dart';

class IPInfoErrorCard extends StatelessWidget {
  const IPInfoErrorCard({super.key, required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    if (width >= AppConstant.minIpadScreenSizeWidth) {
      width = width / 1.5;
    }
    return CustomCard(
      width: width - 40,
      padding: const EdgeInsets.all(15),
      child: Text(
        message,
        textAlign: TextAlign.center,
        style:
            Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.red),
      ),
    );
  }
}
