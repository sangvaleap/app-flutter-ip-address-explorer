// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ip_location.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IPLocation _$IPLocationFromJson(Map<String, dynamic> json) => IPLocation(
      city: json['city'] as String,
      country: json['country'] as String,
      geonameId: json['geonameId'] as int,
      lat: (json['lat'] as num).toDouble(),
      lng: (json['lng'] as num).toDouble(),
      postalCode: json['postalCode'] as String,
      region: json['region'] as String,
      timezone: json['timezone'] as String,
    );

Map<String, dynamic> _$IPLocationToJson(IPLocation instance) =>
    <String, dynamic>{
      'city': instance.city,
      'country': instance.country,
      'geonameId': instance.geonameId,
      'lat': instance.lat,
      'lng': instance.lng,
      'postalCode': instance.postalCode,
      'region': instance.region,
      'timezone': instance.timezone,
    };
