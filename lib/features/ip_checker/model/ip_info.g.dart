// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ip_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IpInfo _$IpInfoFromJson(Map<String, dynamic> json) => IpInfo(
      ip: json['ip'] as String,
      isp: json['isp'] as String,
      ipLocation: IPLocation.fromJson(json['location'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$IpInfoToJson(IpInfo instance) => <String, dynamic>{
      'ip': instance.ip,
      'isp': instance.isp,
      'location': instance.ipLocation.toJson(),
    };
