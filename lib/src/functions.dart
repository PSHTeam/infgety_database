import 'dart:convert';
import 'dart:typed_data';

import 'package:http/http.dart' as http;

bool isNull(Object? object) {
  return object == null;
}

Future<http.Response> post(
  Uri url, {
  Map<String, String>? headers,
  Object? body,
  Encoding? encoding,
}) => http.post(url, headers: headers, body: body, encoding: encoding);

Future<http.Response> get(Uri url, {Map<String, String>? headers}) =>
    http.get(url, headers: headers);

String uint8ListToHex(Uint8List input) {
  return input.map((byte) => byte.toRadixString(16).padLeft(2, '0')).join();
}
