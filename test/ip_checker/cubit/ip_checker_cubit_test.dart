import 'package:flutter_test/flutter_test.dart';
import 'package:ip_checker/core/exception/exception.dart';
import 'package:ip_checker/features/ip_checker/cubit/ip_checker_cubit.dart';
import 'package:ip_checker/features/ip_checker/cubit/ip_checker_state.dart';
import 'package:ip_checker/features/ip_checker/model/ip_info.dart';
import 'package:ip_checker/features/ip_checker/repository/ip_repository.dart';
import 'package:mocktail/mocktail.dart';
import 'package:bloc_test/bloc_test.dart';

import '../mock_data/data.dart';

class MockIPRepository extends Mock implements IPRepository {}

void main() {
  late IPRepository ipRepository;
  late IpInfo ipInfo;

  setUpAll(() {
    ipRepository = MockIPRepository();
    ipInfo = IpInfo.fromJson(ipInfoJsonMock);
  });

  group('IPCheckerCubit', () {
    test('initial state', () {
      expect(IPCheckerCubit(ipRepository: ipRepository).state,
          const IPCheckerState(status: IPCheckerStatus.initial));
    });

    blocTest<IPCheckerCubit, IPCheckerState>(
      'emits [loading, success] states when calling getIPInfo(ip)',
      build: () => IPCheckerCubit(ipRepository: ipRepository),
      setUp: () {
        when(() => ipRepository.getIPInfo(any()))
            .thenAnswer((_) async => ipInfo);
      },
      act: (cubit) => cubit.getIPInfo('8.8.8.8'),
      expect: () => <IPCheckerState>[
        const IPCheckerState(status: IPCheckerStatus.loading),
        IPCheckerState(status: IPCheckerStatus.success, ipInfo: ipInfo)
      ],
    );

    blocTest<IPCheckerCubit, IPCheckerState>(
      'returns when calling getIPInfo(ip) during loading state',
      build: () => IPCheckerCubit(ipRepository: ipRepository),
      setUp: () {
        when(() => ipRepository.getIPInfo(any()))
            .thenAnswer((_) async => ipInfo);
      },
      seed: () => const IPCheckerState(status: IPCheckerStatus.loading),
      act: (cubit) => cubit.getIPInfo('8.8.8.8'),
      expect: () => <IPCheckerState>[],
    );

    blocTest<IPCheckerCubit, IPCheckerState>(
      'returns when calling getIPInfo(ip) with empty ip',
      build: () => IPCheckerCubit(ipRepository: ipRepository),
      setUp: () {
        when(() => ipRepository.getIPInfo(any()))
            .thenAnswer((_) async => ipInfo);
      },
      seed: () => const IPCheckerState(status: IPCheckerStatus.loading),
      act: (cubit) => cubit.getIPInfo(''),
      expect: () => <IPCheckerState>[],
    );

    blocTest(
      'emits [loading error] states with UnknownIPAddress when calling getIPInfo(ip)',
      build: () => IPCheckerCubit(ipRepository: ipRepository),
      setUp: () {
        when(() => ipRepository.getIPInfo(any())).thenThrow(UnknownIPAddress());
      },
      act: (cubit) => cubit.getIPInfo('8.8.8.8'),
      expect: () => [
        const IPCheckerState(status: IPCheckerStatus.loading),
        const IPCheckerState(
            status: IPCheckerStatus.error, message: 'Unknown IP Addresss'),
      ],
    );

    blocTest(
      'emits [loading error] states with UnAuthorized when calling getIPInfo(ip)',
      build: () => IPCheckerCubit(ipRepository: ipRepository),
      setUp: () {
        when(() => ipRepository.getIPInfo(any())).thenThrow(UnAuthorized());
      },
      act: (cubit) => cubit.getIPInfo('8.8.8.8'),
      expect: () => [
        const IPCheckerState(status: IPCheckerStatus.loading),
        const IPCheckerState(
            status: IPCheckerStatus.error, message: 'Unauthorized'),
      ],
    );

    blocTest(
      'emits [loading error] states with CustomException when calling getIPInfo(ip)',
      build: () => IPCheckerCubit(ipRepository: ipRepository),
      setUp: () {
        when(() => ipRepository.getIPInfo(any())).thenThrow(CustomException());
      },
      act: (cubit) => cubit.getIPInfo('8.8.8.8'),
      expect: () => [
        const IPCheckerState(status: IPCheckerStatus.loading),
        const IPCheckerState(
            status: IPCheckerStatus.error, message: 'General exception'),
      ],
    );
  });
}
