/// The `AppConstant` class holds constant values used throughout the application.
class AppConstant {
  /// Private constructor to prevent the instantiation of this class.
  AppConstant._();

  /// The endpoint of the IP checker REST API.
  ///
  /// This constant represents the endpoint used to check the IP address via a REST API.
  static const String ipCheckerEndPoint = '/ipcheck';

  //// The abbreviation prefix of the application.
  ///
  /// This constant provides a short abbreviation used as a prefix for various app-related values.
  static const String appAbbrPrefix = 'IPC';

  //// The key for the application cache.
  static const String cacheKey = 'cache';

  /// The constant minimum width of screen size for iPad and Mac
  static const double minIpadScreenSizeWidth = 768;

  /// The constant app version
  static const String appVersion = "1.0.0";

  /// The constant theme mode key for saving theme mode value into local storage
  static const String themeModeKey = "theme";

  /// The constant theme mode default system key for saving theme mode default system value into local storage
  static const themeModeDefaultSystemKey = 'darkModeSystem';

  /// The constant map key for saving map mode value into local storage
  static const String mapModeKey = "map";

  /// The constant open street map provider
  static const String openStreetMapProvider =
      'https://tile.openstreetmap.org/{z}/{x}/{y}.png';

  /// The constant open street map provider
  static const String googleMapProvider =
      'https://mt0.google.com/vt/lyrs=m@221097413&x={x}&y={y}&z={z}';
}
