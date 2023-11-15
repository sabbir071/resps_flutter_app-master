import 'dart:convert' as convert;
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

import '../config/constant.dart';

class ApiService {
  Future<http.Response> get(String path,
      {Map<String, String?>? queryParams}) async {
    var uri = _makeUri(path, queryParams: queryParams);
    print(uri);
    final requester = await http.get(
      uri,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json'
      },
    );

    return requester;
  }

  Future<http.Response> post(String path,
      {Object? body, Map<String, String?>? queryParams}) async {
    var uri = _makeUri(path, queryParams: queryParams);
    print(uri);
    log(body.toString());
    final requester = http.post(
      uri,
      body: convert.jsonEncode(body),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json'
      },
    );

    return requester;
  }

  Future<http.Response> put(
    String path, {
    required Object body,
  }) async {
    var uri = _makeUri(path);
    print(uri);
    log(body.toString());
    final requester = http.put(
      uri,
      body: convert.jsonEncode(body),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json'
      },
    );

    return requester;
  }

  Future<http.Response> delete(String path,
      {Object? body, Map<String, String?>? queryParams}) async {
    var uri = _makeUri(path, queryParams: queryParams);
    print(uri);
    log(body.toString());
    final requester = http.delete(
      uri,
      body: convert.jsonEncode(body),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json'
      },
    );

    return requester;
  }

  Future<http.Response> postWithFile(String path, File file, String fieldName,
      {Map<String, String>? body, Map<String, String?>? queryParams}) async {
    var uri = _makeUri(path);

    ///MultiPart request
    var request = http.MultipartRequest('POST', uri);
    Map<String, String> headers = {
      "Content-type": "multipart/form-data",
      'Accept': 'application/json'
    };
    request.headers.addAll(headers);
    request.files.add(
      http.MultipartFile(
        fieldName,
        file.readAsBytes().asStream(),
        file.lengthSync(),
        filename: file.path.split("/").last,
        contentType: MediaType('image', 'jpeg'),
      ),
    );
    if (body != null) {
      request.fields.addAll(body);
    }
    var streamedResponse = await request.send();
    var requester = await http.Response.fromStream(streamedResponse);
    return requester;
  }

  Uri _makeUri(String path, {Map<String, String?>? queryParams}) {
    if (!path.startsWith('/')) {
      path = '/$path';
    }
    return Uri.https(
        apiURL, visibility + apiBase + apiVersion + path, queryParams);
  }
}
