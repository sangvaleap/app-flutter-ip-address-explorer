import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ip_checker/core/style/app_color.dart';
import 'package:ip_checker/core/style/theme.dart';
import 'package:ip_checker/core/utils/app_asset.dart';
import 'package:ip_checker/core/utils/app_constant.dart';
import 'package:ip_checker/features/setting/cubit/theme/theme_cubit.dart';
import 'package:ip_checker/features/setting/cubit/theme/theme_state.dart';

class ThemeSettingPage extends StatelessWidget {
  const ThemeSettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Theme",
        ),
      ),
      body: buildBody(context),
    );
  }

  Widget buildBody(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    if (width >= AppConstant.minIpadScreenSizeWidth) {
      width = width * .5;
    }
    return Align(
      alignment: Alignment.topCenter,
      child: SizedBox(
        width: width,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          shrinkWrap: true,
          children: [
            const SizedBox(height: 10),
            const Text("Please choose theme mode"),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                _buildDarkmodeBloc(context),
                _buildLightModeBloc(context),
              ],
            ),
            const SizedBox(height: 40),
            _buildDefaultSysteBloc(context),
          ],
        ),
      ),
    );
  }

  Widget _buildDefaultSysteBloc(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text("Default system"),
        BlocBuilder<ThemeCubit, ThemeState>(
          builder: (context, state) {
            return Switch(
              value: state.isDefaultSystem,
              activeColor: AppColor.primary,
              onChanged: (isDefault) {
                context.read<ThemeCubit>().setDefaultSystemTheme(isDefault);
              },
            );
          },
        )
      ],
    );
  }

  Widget _buildLightModeBloc(BuildContext context) {
    return _ModeBox(
      onTap: (value) {
        context.read<ThemeCubit>().setTheme(ThemeMode.light);
      },
      themeMode: ThemeMode.light,
    );
  }

  Widget _buildDarkmodeBloc(BuildContext context) {
    return _ModeBox(
      onTap: (value) {
        context.read<ThemeCubit>().setTheme(ThemeMode.dark);
      },
      themeMode: ThemeMode.dark,
    );
  }
}

class _ModeBox extends StatelessWidget {
  const _ModeBox({required this.themeMode, required this.onTap});

  final ThemeMode themeMode;
  final Function(ThemeMode? value) onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap.call(themeMode);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            width: 100,
            height: 180,
            decoration: BoxDecoration(
              color: themeMode == ThemeMode.dark
                  ? AppTheme.darkTheme.scaffoldBackgroundColor
                  : AppTheme.lightTheme.scaffoldBackgroundColor,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 3,
                  offset: const Offset(0, 0), // changes position of shadow
                ),
              ],
            ),
            child: Image.asset(
              themeMode == ThemeMode.dark
                  ? AppAsset.darkMode
                  : AppAsset.lightMode,
              fit: BoxFit.fill,
            ),
          ),
          BlocBuilder<ThemeCubit, ThemeState>(
            builder: (context, state) {
              return Radio<ThemeMode>(
                activeColor: AppColor.primary,
                value: themeMode,
                groupValue: state.mode == ThemeMode.dark
                    ? ThemeMode.dark
                    : ThemeMode.light,
                onChanged: (ThemeMode? value) {
                  onTap.call(value);
                },
              );
            },
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            themeMode == ThemeMode.dark ? "Dark mode" : "Light mode",
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
    );
  }
}
