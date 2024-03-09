import 'package:flutter/material.dart';
import 'package:ip_checker/core/style/app_color.dart';
import 'package:ip_checker/core/utils/app_asset.dart';
import 'package:ip_checker/core/utils/app_constant.dart';

class CustomConfirmDialogBox extends StatelessWidget {
  final String title;
  final String descriptions;
  final String noText;
  final String yesText;
  final String? img;
  final Function()? onNo;
  final Function()? onYes;

  const CustomConfirmDialogBox({
    super.key,
    this.title = "Message",
    this.descriptions = "",
    this.noText = "No",
    this.yesText = "Yes",
    this.img,
    this.onYes,
    this.onNo,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(_Constants.padding),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: _buildBody(context),
    );
  }

  _buildBody(BuildContext context) {
    return Stack(
      children: <Widget>[
        _buildContent(context),
        const _DialogLogo(),
      ],
    );
  }

  Widget _buildContent(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    if (width >= AppConstant.minIpadScreenSizeWidth) {
      width = width * .5;
    }
    return Container(
      width: width,
      padding: const EdgeInsets.only(
        left: _Constants.padding,
        top: _Constants.avatarRadius + _Constants.padding,
        right: _Constants.padding,
        bottom: _Constants.padding,
      ),
      margin: const EdgeInsets.only(top: _Constants.avatarRadius),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(_Constants.padding),
        boxShadow: const [
          BoxShadow(color: Colors.black, offset: Offset(0, 10), blurRadius: 10),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            title,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
          ),
          const SizedBox(
            height: 15,
          ),
          Text(
            descriptions,
            style: const TextStyle(fontSize: 14),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 22,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  onNo?.call();
                },
                child: Text(
                  noText,
                  style:
                      const TextStyle(fontSize: 18, color: AppColor.labelColor),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  onYes?.call();
                },
                child: Text(
                  yesText,
                  style: const TextStyle(fontSize: 18, color: AppColor.red),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

class _DialogLogo extends StatelessWidget {
  const _DialogLogo();

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: _Constants.padding,
      right: _Constants.padding,
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: _Constants.avatarRadius,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(100),
          child: const Image(
            image: AssetImage(
              AppAsset.logo,
            ),
          ),
        ),
      ),
    );
  }
}

class _Constants {
  _Constants._();
  static const double padding = 15;
  static const double avatarRadius = 35;
}
