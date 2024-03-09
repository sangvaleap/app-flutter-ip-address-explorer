// ignore_for_file: unnecessary_getters_setters

import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';

const _baseUrlConst = 'https://geo.ipify.org/api/v2/';

const _headersConst = {
  HttpHeaders.contentTypeHeader: 'application/json',
};

/// A service for making HTTP requests to a specified API endpoint.
///
/// This class provides methods for performing common CRUD operations (GET, POST, PUT, DELETE).
class NetworkService {
  NetworkService({required String endpoint, String baseUrl = _baseUrlConst})
      : _baseUrl = baseUrl,
        _endpoint = endpoint,
        _headers = _headersConst;

  final String _endpoint;
  final String _baseUrl;
  Map<String, String>? _headers;

  /// Getter for headers. Returns the constant headers.
  Map<String, String>? get headers => _headers;

  /// Setter for headers. Allows updating the headers for this service.
  set headers(Map<String, String>? value) => _headers = value;

  /// Constructs a [Uri] by combining the [_baseUrl], [_endpoint], and optional parameters [suffix].
  ///
  /// The [suffix] is appended to the endpoint URL.
  _getUri({String suffix = ''}) {
    return Uri.parse('$_baseUrl$_endpoint$suffix');
  }

  /// Performs an HTTP GET request to retrieve a list of items from the API.
  ///
  /// The [params] parameter allows including additional query parameters in the request.
  /// params should look like 'param1=abc&param2=abc' or null
  Future<Response> getAll({String? params}) async {
    var uri = _getUri(suffix: params == null ? '' : '?$params');
    return await http.get(uri, headers: headers);
  }

  /// Performs an HTTP GET request to retrieve a specific item by its [id] from the API.
  Future<Response> getById(id) async {
    var uri = _getUri(suffix: '/$id');
    return await http.get(uri, headers: headers);
  }

  /// Performs an HTTP POST request to create a new item in the API.
  ///
  /// The [data] parameter is the JSON-encoded data to be sent in the request body.
  Future<Response> post(String data) async {
    var uri = _getUri();
    return await http.post(uri, body: data, headers: headers);
  }

  /// Performs an HTTP PUT request to update an item in the API.
  ///
  /// The [id] parameter specifies the item to be updated, and [data] is the updated data as JSON-encoded data.
  Future<Response> update(id, String data) async {
    var uri = _getUri();
    return await http.put(uri, body: data, headers: headers);
  }

  /// Performs an HTTP DELETE request to remove an item by its [id] from the API.
  Future<Response> delete(id) async {
    var uri = _getUri(suffix: '/$id');
    return http.delete(uri, headers: headers);
  }
}
