import 'package:network_info_plus/network_info_plus.dart';
import 'package:http/http.dart' as http;

/// A service for retrieving network-related information.
///
/// This class provides access to network-related functionality, such as obtaining the device's IP address.
class NetworkInfoService {
  /// A singleton instance of the [NetworkInfo] class.
  static final NetworkInfo _networkInfo = NetworkInfo();

  /// Private constructor to prevent the instantiation of this class.
  NetworkInfoService._();

  /// The cached device's IP address obtained from the network information.
  ///
  /// The IP address is retrieved asynchronously and cached for subsequent access.
  static String? _myWifiIP;

  /// Gets the device's IP address, retrieving it if not already cached.
  ///
  /// Returns a [Future<String?>] representing the device's IP address.
  /// The IP address is obtained asynchronously using the network-related method.
  /// The result is cached for subsequent calls to avoid redundant network requests.
  static Future<String?> get myWifiIP async =>
      _myWifiIP ??= await _networkInfo.getWifiIP();

  /// The cached public IP address obtained from the ipify api.
  ///
  /// The IP address is retrieved asynchronously and cached for subsequent access.
  static String? _myPublicIP;

  /// Gets the public IP address, retrieving it if not already cached.
  ///
  /// Returns a [Future<String?>] representing the public IP address.
  /// The IP address is obtained asynchronously using the network request to ipify api.
  /// The result is cached for subsequent calls to avoid redundant network requests.
  static Future<String?> get myPublicIP async =>
      _myPublicIP ??= await _get(Uri.parse('https://api.ipify.org'));

  static Future<String> _get(Uri uri) async {
    try {
      final response = await http.get(uri);

      if (response.statusCode != 200) {
        throw Exception(
            'Received an invalid status code from ipify: ${response.statusCode}. The service might be experiencing issues.');
      }

      return response.body;
    } catch (e) {
      throw Exception(
          "The request failed because it wasn't able to reach the ipify service. This is most likely due to a networking error of some sort.");
    }
  }
}
