import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'ip_location.g.dart';

@JsonSerializable()
class IPLocation extends Equatable {
  final String city;
  final String country;
  final int geonameId;
  final double lat;
  final double lng;
  final String postalCode;
  final String region;
  final String timezone;

  const IPLocation({
    required this.city,
    required this.country,
    required this.geonameId,
    required this.lat,
    required this.lng,
    required this.postalCode,
    required this.region,
    required this.timezone,
  });

  factory IPLocation.fromJson(Map<String, dynamic> json) =>
      _$IPLocationFromJson(json);
  Map<String, dynamic> toJson() => _$IPLocationToJson(this);

  @override
  List<Object?> get props =>
      [city, country, geonameId, lat, lng, postalCode, region, timezone];
}
