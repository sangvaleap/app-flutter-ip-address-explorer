import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ip_checker/features/ip_checker/cubit/ip_checker_cubit.dart';
import 'package:ip_checker/features/ip_checker/cubit/ip_checker_state.dart';
import 'package:ip_checker/features/ip_checker/view/widgets/ip_info_error_card.dart';
import 'package:ip_checker/features/ip_checker/view/widgets/ip_info_result_card.dart';

class IPInfoCard extends StatelessWidget {
  const IPInfoCard({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<IPCheckerCubit, IPCheckerState>(
      builder: (context, state) {
        if (state.status == IPCheckerStatus.error) {
          return IPInfoErrorCard(message: state.message);
        } else if (state.status == IPCheckerStatus.success) {
          return IPInfoResultCard(ipInfo: state.ipInfo!);
        }
        return const SizedBox();
      },
    );
  }
}
