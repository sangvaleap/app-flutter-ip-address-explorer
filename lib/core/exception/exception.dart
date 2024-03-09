import 'dart:convert';

/// Base class for custom exceptions, implementing the Dart Exception interface.
class BaseException implements Exception {
  /// A message providing details about the exception. Defaults to 'General Exception'.
  String message;

  /// An optional HTTP status code associated with the exception.
  int? statusCode;

  /// Constructor for the BaseException class.
  BaseException({this.message = 'General Exception', this.statusCode});

  @override
  String toString() {
    return 'BaseException: $message, Status Code: $statusCode';
  }
}

// Exception thrown when an unknown IP address is encountered.
///
/// This exception is typically used when attempting to retrieve an IP address Information form REST API,
/// but the address is unknown or cannot be determined.
class UnknownIPAddress extends BaseException {
  /// Creates a new instance of [UnknownIPAddress].
  ///
  /// The [message] parameter provides details about the exception (default: 'Unknown IP Address').
  /// The [statusCode] parameter is an optional HTTP status code associated with the exception.
  UnknownIPAddress({super.message = 'Unknown IP Addresss', super.statusCode});
}

/// Exception thrown when an unauthorized access attempt is detected.
///
/// This exception is used to signal unauthorized access to a resource or operation.
class UnAuthorized extends BaseException {
  /// Creates a new instance of [UnAuthorized].
  ///
  /// The [message] parameter provides details about the unauthorized access attempt (default: 'Unauthorized').
  /// The [statusCode] parameter is an optional HTTP status code associated with the exception.
  UnAuthorized({super.message = 'Unauthorized', super.statusCode});
}

/// Custom exception for handling general exceptions with additional details.
///
/// This exception can be used to provide more specific information about a general exception.
class CustomException extends BaseException {
  /// Additional data associated with the exception, typically in JSON format.
  final String? data;

  /// Creates a new instance of [CustomException].
  ///
  /// The [message] parameter provides details about the exception (default: 'General exception').
  /// The [statusCode] parameter is an optional HTTP status code associated with the exception.
  /// The [data] parameter is additional data associated with the exception, typically in JSON format.
  ///
  /// If [data] is provided and contains a 'messages' key, the value of that key is used as the [message].
  CustomException(
      {super.message = 'General exception', super.statusCode, this.data}) {
    if (data != null) {
      final Map<String, dynamic> jsonData = jsonDecode(data!);
      if (jsonData.containsKey('messages') && jsonData['messages'] != null) {
        super.message = jsonData['messages'];
      }
    }
  }
}
