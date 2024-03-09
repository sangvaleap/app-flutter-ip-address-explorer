import 'dart:convert';

import 'package:ip_checker/core/exception/exception.dart';
import 'package:ip_checker/core/services/storage_service.dart';
import 'package:ip_checker/core/utils/app_constant.dart';
import 'package:ip_checker/core/utils/app_util.dart';
import 'package:ip_checker/features/ip_checker/repository/remote/remote_ip_repostiroy.dart';
import 'package:ip_checker/features/ip_checker/repository/ip_repository.dart';
import 'package:ip_checker/features/ip_checker/model/ip_info.dart';

/// The `LocalIPRepository` class serves as a proxy for the `RemoteIPRepository`
/// and is designed to control requests to the remote server by utilizing local
/// caching mechanisms.
///
/// It implements the `IPRepository` interface, ensuring compatibility with
/// other classes expecting an `IPRepository` implementation.
class LocalIPRepository implements IPRepository {
  final IPRepository _ipRepository;

  LocalIPRepository({required networkService})
      : _ipRepository = RemoteIPRepository(networkService: networkService);

  /// Retrieves IP information for the provided [ip] address, either from local
  /// cache or by making a request to the remote server if not found in the cache.
  ///
  /// If the IP information is found in the local cache, it is returned to avoid
  /// making unnecessary requests to the remote server.
  /// If not found, a request is sent to the remote server, and the response is
  /// saved into the local cache for future use.
  ///
  /// Throws an error if an issue occurs during the retrieval or caching process.
  @override
  Future<IpInfo> getIPInfo(String ip) async {
    // load ip in caches
    String? ipInfoString =
        await StorageService.getString(_getCombinedCacheKey(ip));
    // check if ip exists in cache
    if (ipInfoString != null) {
      // perform operations with cache
      AppUtil.debugPrint("Local cache:");
      try {
        // convert ip information string to json
        Map<String, dynamic> ipInfoJson = json.decode(ipInfoString);
        // convert ip information json to object and return
        return IpInfo.fromJson(ipInfoJson);
      } catch (e) {
        // ip information cannot be converted. throw exception about the ip address
        AppUtil.debugPrint("Local exception: $ipInfoString");
        throw CustomException(message: ipInfoString);
      }
    } else {
      // perform operations with remote server
      AppUtil.debugPrint("Remote server:");
      try {
        // send request to remote server
        IpInfo response = await _ipRepository.getIPInfo(ip);
        // save into cache
        _saveIPInfoToCache(ip, response);
        // return data
        return response;
      } on BaseException catch (e) {
        // save the ip information from remote server and throw exception about the ip address
        AppUtil.debugPrint("Remote base exception: ${e.message}");
        StorageService.saveString(_getCombinedCacheKey(ip), e.message);
        rethrow;
      } catch (e) {
        // save the ip information from remote server and throw generic exception about the ip address
        AppUtil.debugPrint("Remote exception: ${e.toString()}");
        StorageService.saveString(
            _getCombinedCacheKey(ip), 'General exception');
        rethrow;
      }
    }
  }

  /// Saves the provided [ipInfo] into the local cache for the specified [ip] address.
  void _saveIPInfoToCache(String ip, IpInfo ipInfo) {
    AppUtil.debugPrint("saved: $ipInfo");
    final json = ipInfo.toJson();
    StorageService.saveString(_getCombinedCacheKey(ip), jsonEncode(json));
  }

  String _getCombinedCacheKey(String ip) => '${AppConstant.cacheKey}/$ip';
}
