import 'package:flutter_test/flutter_test.dart';
import 'package:ip_checker/features/ip_checker/model/ip_info.dart';
import 'package:ip_checker/features/ip_checker/model/ip_location.dart';

import '../mock_data/data.dart';

void main() {
  late IpInfo ipInfo;
  late Map<String, dynamic> ipInfoJson;
  late IPLocation ipLocation;
  setUp(() {
    ipInfoJson = ipInfoJsonMock;
    ipLocation = const IPLocation(
        city: 'Fairfield',
        country: 'USA',
        geonameId: 2,
        lat: 1,
        lng: 1,
        postalCode: '52557',
        region: 'IA',
        timezone: 'GMT-6');
    ipInfo = IpInfo(ip: '8.8.8.8', isp: 'Google LLC', ipLocation: ipLocation);
  });

  group('IPInfo class', () {
    test('compare two objects', () {
      expect(IpInfo(ip: '8.8.8.8', isp: 'Google LLC', ipLocation: ipLocation),
          IpInfo(ip: '8.8.8.8', isp: 'Google LLC', ipLocation: ipLocation));
    });

    test('tests fromJson method', () {
      expect(IpInfo.fromJson(ipInfoJson), ipInfo);
    });

    test('tests toJson method', () {
      expect(ipInfo.toJson(), ipInfoJson);
    });
  });
}
