import 'package:flutter_test/flutter_test.dart';
import 'package:ip_checker/features/ip_checker/model/ip_location.dart';

import '../mock_data/data.dart';

void main() {
  late IPLocation ipLocation;
  late Map<String, dynamic> ipLocationJson;

  setUp(() {
    ipLocationJson = ipLocationJsonMock;
    ipLocation = const IPLocation(
      city: 'Fairfield',
      country: 'USA',
      geonameId: 2,
      lat: 1,
      lng: 1,
      postalCode: '52557',
      region: 'IA',
      timezone: 'GMT-6',
    );
  });

  group('IPLocation class', () {
    test('tests compare two objects', () {
      expect(
        const IPLocation(
          city: 'Fairfield',
          country: 'USA',
          geonameId: 2,
          lat: 1,
          lng: 1,
          postalCode: '52557',
          region: 'IA',
          timezone: 'GMT-6',
        ),
        const IPLocation(
          city: 'Fairfield',
          country: 'USA',
          geonameId: 2,
          lat: 1,
          lng: 1,
          postalCode: '52557',
          region: 'IA',
          timezone: 'GMT-6',
        ),
      );
    });

    test('tests fromJson method', () {
      expect(IPLocation.fromJson(ipLocationJson), ipLocation);
    });

    test('tests toJson method', () {
      expect(ipLocation.toJson(), ipLocationJson);
    });
  });
}
