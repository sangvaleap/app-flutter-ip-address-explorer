import 'package:equatable/equatable.dart';
import 'package:ip_checker/features/ip_checker/model/ip_info.dart';

enum IPCheckerStatus { initial, loading, success, error }

class IPCheckerState extends Equatable {
  final IPCheckerStatus status;
  final IpInfo? ipInfo;
  final String message;

  const IPCheckerState({
    this.status = IPCheckerStatus.initial,
    this.ipInfo,
    this.message = '',
  });

  @override
  List<Object?> get props => [status, ipInfo, message];
}
