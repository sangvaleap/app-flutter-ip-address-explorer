import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ip_checker/core/utils/app_asset.dart';
import 'package:ip_checker/features/ip_checker/cubit/ip_checker_cubit.dart';
import 'package:ip_checker/features/ip_checker/cubit/ip_checker_state.dart';
import 'package:ip_checker/common/widgets/custom_progress_indicator.dart';

/// `SubmitButton` is a `StatelessWidget` widget that represents a button used for submitting actions.
class SubmitButton extends StatelessWidget {
  /// Constructs a `SubmitButton` with an optional onTap callback.
  const SubmitButton({super.key, this.onTap});

  /// A callback function that is triggered when the button is tapped.
  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 50,
        height: 50,
        decoration: const BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.horizontal(
            right: Radius.circular(10),
          ),
        ),
        child: BlocBuilder<IPCheckerCubit, IPCheckerState>(
          builder: (context, state) {
            return state.status == IPCheckerStatus.loading
                ? const CustomProgressIndicator(
                    color: Colors.white,
                  )
                : SvgPicture.asset(
                    AppAsset.arrowIcon,
                    fit: BoxFit.none,
                    width: 30,
                    height: 30,
                    colorFilter:
                        const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                  );
          },
        ),
      ),
    );
  }
}
