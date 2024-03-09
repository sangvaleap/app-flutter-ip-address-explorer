import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ip_checker/features/ip_checker/cubit/ip_checker_cubit.dart';
import 'package:ip_checker/features/ip_checker/cubit/ip_checker_state.dart';
import 'package:ip_checker/features/ip_checker/model/ip_info.dart';
import 'package:ip_checker/features/ip_checker/view/ip_checker_page.dart';
import 'package:ip_checker/features/ip_checker/view/widgets/background_image.dart';
import 'package:ip_checker/features/ip_checker/view/widgets/ip_info_card.dart';
import 'package:ip_checker/features/ip_checker/view/widgets/ip_info_error_card.dart';
import 'package:ip_checker/features/ip_checker/view/widgets/ip_info_result_card.dart';
import 'package:ip_checker/features/ip_checker/view/widgets/search_submit.dart';
import 'package:ip_checker/features/ip_checker/view/widgets/submit_button.dart';
import 'package:ip_checker/features/ip_checker/view/widgets/title_widget.dart';
import 'package:ip_checker/features/map/cubit/map_cubit.dart';
import 'package:ip_checker/features/map/cubit/map_state.dart';
import 'package:ip_checker/common/widgets/custom_progress_indicator.dart';
import 'package:ip_checker/common/widgets/custom_textfield.dart';
import 'package:ip_checker/features/map/view/open_street_map_widget.dart';
import 'package:ip_checker/features/setting/cubit/theme/theme_cubit.dart';
import 'package:ip_checker/features/setting/cubit/theme/theme_state.dart';
import 'package:mocktail/mocktail.dart';

import '../helper/helper.dart';
import '../mock_data/data.dart';

class MockIPCheckerCubit extends MockCubit<IPCheckerState>
    implements IPCheckerCubit {}

class MockMapCubit extends MockCubit<MapState> implements MapCubit {}

class MockThemeCubit extends MockCubit<ThemeState> implements ThemeCubit {}

void main() {
  late IPCheckerCubit ipCubit;
  late MapCubit mapCubit;
  late ThemeCubit themeCubit;
  late IpInfo ipInfo;
  setUpAll(() {
    TestWidgetsFlutterBinding.ensureInitialized();
  });

  setUp(() {
    ipCubit = MockIPCheckerCubit();
    mapCubit = MockMapCubit();
    themeCubit = MockThemeCubit();
    ipInfo = IpInfo.fromJson(ipInfoJsonMock);
    when(() => mapCubit.state)
        .thenReturn(const MapState(mode: MapStateMode.openstreet));
    when(() => themeCubit.state).thenReturn(const ThemeState());
    when(() => ipCubit.getMyPublicIP).thenAnswer((_) => Future.value(''));
  });
  group('IPChekerPage', () {
    testWidgets('renders IPChekerPage', (tester) async {
      when(() => ipCubit.state).thenReturn(const IPCheckerState());

      await tester.pumpApp(
          ipCubit: ipCubit,
          mapCubit: mapCubit,
          themeCubit: themeCubit,
          child: const IPChekerPage());

      expect(find.byType(TitleWidget), findsOneWidget);
      expect(find.byType(SearchSubmit), findsOneWidget);
      expect(find.byType(BackgroundImage), findsOneWidget);
      expect(find.byType(IPInfoCard), findsOneWidget);
      expect(find.byType(OpenStreetMapWidget), findsOneWidget);
    });

    testWidgets('renders IPInfoResultCard when success state', (tester) async {
      when(() => ipCubit.state).thenReturn(
          IPCheckerState(status: IPCheckerStatus.success, ipInfo: ipInfo));

      await tester.pumpApp(
          ipCubit: ipCubit,
          mapCubit: mapCubit,
          themeCubit: themeCubit,
          child: const IPChekerPage());
      expect(find.byType(IPInfoResultCard), findsOneWidget);
    });

    testWidgets('renders IPInfoErrorCard when error state', (tester) async {
      when(() => ipCubit.state)
          .thenReturn(const IPCheckerState(status: IPCheckerStatus.error));
      await tester.pumpApp(
          ipCubit: ipCubit,
          mapCubit: mapCubit,
          themeCubit: themeCubit,
          child: const IPChekerPage());
      expect(find.byType(IPInfoErrorCard), findsOneWidget);
    });

    testWidgets('renders CustomProgressIndicator when loading state',
        (tester) async {
      when(() => ipCubit.state)
          .thenReturn(const IPCheckerState(status: IPCheckerStatus.loading));
      await tester.pumpApp(
          ipCubit: ipCubit,
          mapCubit: mapCubit,
          themeCubit: themeCubit,
          child: const IPChekerPage());
      expect(find.byType(CustomProgressIndicator), findsOneWidget);
    });

    testWidgets('taps SubmitButton and call getIPInfo(ip)', (tester) async {
      when(() => ipCubit.state)
          .thenReturn(const IPCheckerState(status: IPCheckerStatus.initial));
      when(() => ipCubit.getIPInfo(any())).thenAnswer((_) async =>
          IPCheckerState(status: IPCheckerStatus.success, ipInfo: ipInfo));

      await tester.pumpApp(
          ipCubit: ipCubit,
          mapCubit: mapCubit,
          themeCubit: themeCubit,
          child: const IPChekerPage());

      await tester.enterText(find.byType(CustomTextField), '8.8.8.8');
      await tester.tap(find.byType(SubmitButton));
      verify(() => ipCubit.getIPInfo('8.8.8.8')).called(1);
    });
  });
}
