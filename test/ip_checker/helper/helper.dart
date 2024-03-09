import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ip_checker/features/ip_checker/cubit/ip_checker_cubit.dart';
import 'package:ip_checker/features/map/cubit/map_cubit.dart';
import 'package:ip_checker/features/setting/cubit/theme/theme_cubit.dart';

extension PumpApp on WidgetTester {
  Future<void> pumpApp(
      {required IPCheckerCubit ipCubit,
      required MapCubit mapCubit,
      required ThemeCubit themeCubit,
      required Widget child}) async {
    return pumpWidget(
      MultiBlocProvider(
        providers: [
          BlocProvider<IPCheckerCubit>(
            create: (context) => ipCubit,
          ),
          BlocProvider<MapCubit>(
            create: (context) => mapCubit,
          ),
          BlocProvider<ThemeCubit>(
            create: (context) => themeCubit,
          ),
        ],
        child: MaterialApp(
          home: child,
        ),
      ),
    );
  }
}
