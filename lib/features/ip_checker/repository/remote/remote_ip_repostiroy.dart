import 'dart:convert';

import 'package:ip_checker/core/exception/exception.dart';
import 'package:ip_checker/core/services/network_service.dart';
import 'package:ip_checker/core/utils/app_util.dart';
import 'package:ip_checker/features/ip_checker/repository/ip_repository.dart';
import 'package:ip_checker/features/ip_checker/model/ip_info.dart';

class RemoteIPRepository implements IPRepository {
  final NetworkService _networkService;

  RemoteIPRepository({required networkService})
      : _networkService = networkService;

  @override
  Future<IpInfo> getIPInfo(String ip) async {
    try {
      final response = await _networkService.getAll(params: 'ip=$ip');
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonBody = jsonDecode(response.body);
        if (jsonBody.containsKey('isp') &&
            !AppUtil.checkIsNull(jsonBody['isp'])) {
          return IpInfo.fromJson(jsonBody);
        }
        throw UnknownIPAddress();
      } else if (response.statusCode == 401) {
        throw UnAuthorized();
      }
      throw CustomException(
          data: response.body, statusCode: response.statusCode);
    } catch (e) {
      rethrow;
    }
  }
}
