import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ip_checker/core/utils/app_asset.dart';
import 'package:ip_checker/core/utils/app_navigate.dart';
import 'package:ip_checker/features/setting/view/setting_page.dart';
import 'package:ip_checker/common/widgets/custom_icon_button.dart';

class TitleWidget extends StatelessWidget {
  const TitleWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width - 40,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Expanded(
            flex: 1,
            child: SizedBox(),
          ),
          Expanded(
            flex: 3,
            child: Text(
              "IP Address Tracker",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          Expanded(
            flex: 1,
            child: Align(
              alignment: Alignment.centerRight,
              child: CustomIconButton(
                onTap: () =>
                    AppNavigator.to(context, const SettingPage(), true),
                child: SvgPicture.asset(
                  AppAsset.settingIcon,
                  colorFilter: ColorFilter.mode(
                    Theme.of(context).iconTheme.color ??
                        Theme.of(context).primaryColor,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
