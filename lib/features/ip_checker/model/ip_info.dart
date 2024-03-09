import 'package:equatable/equatable.dart';
import 'package:ip_checker/features/ip_checker/model/ip_location.dart';
import 'package:json_annotation/json_annotation.dart';

part 'ip_info.g.dart';

@JsonSerializable(explicitToJson: true)
class IpInfo extends Equatable {
  final String ip;
  final String isp;
  @JsonKey(name: 'location')
  final IPLocation ipLocation;

  const IpInfo({
    required this.ip,
    required this.isp,
    required this.ipLocation,
  });

  factory IpInfo.fromJson(Map<String, dynamic> json) => _$IpInfoFromJson(json);
  Map<String, dynamic> toJson() => _$IpInfoToJson(this);

  @override
  List<Object?> get props => [ip, isp, ipLocation];
}
