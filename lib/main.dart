import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ip_checker/core/services/geolocation_service.dart';
import 'package:ip_checker/core/services/network_service.dart';
import 'package:ip_checker/core/utils/app_constant.dart';
import 'package:ip_checker/core/utils/app_env.dart';
import 'package:ip_checker/features/ip_checker/cubit/ip_checker_cubit.dart';
import 'package:ip_checker/features/ip_checker/repository/local/local_ip_repository.dart';
import 'package:ip_checker/features/ip_checker/view/ip_checker_page.dart';
import 'package:ip_checker/features/map/cubit/map_cubit.dart';
import 'package:ip_checker/features/map/cubit/map_state.dart';
import 'package:ip_checker/features/setting/cubit/cache/cache_cubit.dart';
import 'package:ip_checker/features/setting/cubit/theme/theme_cubit.dart';
import 'package:ip_checker/features/setting/cubit/theme/theme_state.dart';
import 'package:ip_checker/core/style/theme.dart';

// Entry point of the Flutter application
void main() async {
  // Ensure that Flutter is initialized before running the application
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize the GeolocatorService and the service will be accessed after running the application
  await GeolocatorService.init();
  // Run the Flutter application
  runApp(const MyApp());
}

// MyApp is the root widget of your Flutter application
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    var headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.authorizationHeader: AppENV.accessToken
    };
    return MultiBlocProvider(
      providers: [
        BlocProvider<IPCheckerCubit>(
          create: (context) => IPCheckerCubit(
            ipRepository: LocalIPRepository(
              networkService: NetworkService(
                endpoint: AppConstant.ipCheckerEndPoint,
                baseUrl: AppENV.baseURL,
              )..headers = headers,
            ),
          ),
        ),
        // initialize theme cubit and load theme mode from local storage
        BlocProvider<ThemeCubit>(
          create: (context) => ThemeCubit(themeState: const ThemeState()),
        ),
        BlocProvider<CacheCubit>(
          create: (context) => CacheCubit(),
        ),
        BlocProvider<MapCubit>(
          create: (context) => MapCubit(
            initState: const MapState(),
          ),
        ),
      ],
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'IP Checker',
            darkTheme: AppTheme.darkTheme,
            theme: AppTheme.lightTheme,
            themeMode: state.mode,
            home: const IPChekerPage(),
          );
        },
      ),
    );
  }
}
