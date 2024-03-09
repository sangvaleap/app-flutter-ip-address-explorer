class AppENV {
  static String get accessToken {
    return const String.fromEnvironment('TOKEN');
  }

  static String get baseURL {
    return const String.fromEnvironment('BASE_URL');
  }
}
