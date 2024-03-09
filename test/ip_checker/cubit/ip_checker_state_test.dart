import 'package:flutter_test/flutter_test.dart';
import 'package:ip_checker/features/ip_checker/cubit/ip_checker_state.dart';
import 'package:ip_checker/features/ip_checker/model/ip_info.dart';
import 'package:mocktail/mocktail.dart';

class MockIPInfo extends Mock implements IpInfo {}

void main() {
  group('IPCheckerState', () {
    test('tests initial state', () {
      expect(const IPCheckerState(), const IPCheckerState());
    });

    test('tests loading state', () {
      expect(const IPCheckerState(status: IPCheckerStatus.loading),
          const IPCheckerState(status: IPCheckerStatus.loading));
    });

    test('tests success state', () {
      final ipInfo = MockIPInfo();
      expect(IPCheckerState(status: IPCheckerStatus.success, ipInfo: ipInfo),
          IPCheckerState(status: IPCheckerStatus.success, ipInfo: ipInfo));
    });

    test('tests error state', () {
      expect(const IPCheckerState(status: IPCheckerStatus.error),
          const IPCheckerState(status: IPCheckerStatus.error));
    });
  });
}
