import 'package:ip_checker/features/ip_checker/model/ip_info.dart';

abstract class IPRepository {
  Future<IpInfo> getIPInfo(String ip);
}
