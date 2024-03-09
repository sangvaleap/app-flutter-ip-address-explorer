import 'package:flutter/material.dart';
import 'package:ip_checker/core/utils/app_asset.dart';

class BackgroundImage extends StatelessWidget {
  const BackgroundImage({
    super.key,
    required this.width,
    required this.height,
  });

  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Image(
      image: const AssetImage(AppAsset.background),
      width: width,
      height: height,
      fit: BoxFit.fill,
    );
  }
}
