import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ip_checker/core/style/app_color.dart';
import 'package:ip_checker/core/utils/app_constant.dart';
import 'package:ip_checker/core/utils/app_navigate.dart';
import 'package:ip_checker/core/utils/app_util.dart';
import 'package:ip_checker/features/setting/cubit/cache/cache_cubit.dart';
import 'package:ip_checker/features/setting/cubit/cache/cache_state.dart';
import 'package:ip_checker/features/map/view/map_setting_page.dart';
import 'package:ip_checker/features/setting/view/theme_setting_page.dart';
import 'package:ip_checker/features/setting/view/widgets/settting_item.dart';
import 'package:ip_checker/common/widgets/custom_confirm_dialog.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Theme Setting"),
      ),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    if (width >= AppConstant.minIpadScreenSizeWidth) {
      width = width * .5;
    }
    return BlocListener<CacheCubit, CacheState>(
      listener: (context, state) {
        if (state.status == CacheStateStatus.success) {
          AppUtil.showSnackBar(context, state.message);
        } else if (state.status == CacheStateStatus.error) {
          AppUtil.showSnackBar(context, state.message);
        }
      },
      child: Align(
        alignment: Alignment.topCenter,
        child: SizedBox(
          width: width,
          child: SingleChildScrollView(
            padding: const EdgeInsets.only(top: 25, right: 20, bottom: 10),
            child: Column(
              children: [
                SettingItem(
                  leading: const Icon(Icons.dark_mode_rounded,
                      color: AppColor.purple),
                  title: "Theme Setting",
                  trailing: const Icon(
                    Icons.arrow_forward_ios,
                    size: 14,
                  ),
                  onTap: () {
                    AppNavigator.to(context, const ThemeSettingPage());
                  },
                ),
                const SizedBox(height: 10),
                SettingItem(
                  leading: const Icon(Icons.delete, color: AppColor.red),
                  title: "Clear Cache",
                  trailing: const Icon(
                    Icons.arrow_forward_ios,
                    size: 14,
                  ),
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return CustomConfirmDialogBox(
                          title: "Clear Cache",
                          descriptions: "Do you want to clear cache?",
                          onYes: () {
                            context.read<CacheCubit>().removeAll();
                          },
                        );
                      },
                    );
                  },
                ),
                const SizedBox(height: 10),
                SettingItem(
                  leading: const Icon(Icons.map, color: AppColor.blue),
                  title: "Map Setting",
                  trailing: const Icon(
                    Icons.arrow_forward_ios,
                    size: 14,
                  ),
                  onTap: () {
                    AppNavigator.to(context, const MapSettingPage());
                  },
                ),
                // const SizedBox(height: 10),
                // SettingItem(
                //   leading: const Icon(Icons.rate_review, color: AppColor.green),
                //   title: "Feedback",
                //   trailing: const Icon(
                //     Icons.arrow_forward_ios,
                //     size: 14,
                //   ),
                //   onTap: () {},
                // ),
                const SizedBox(height: 10),
                const SettingItem(
                  leading:
                      Icon(Icons.system_update, color: AppColor.labelColor),
                  title: "Version",
                  trailing: Text(
                    AppConstant.appVersion,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
