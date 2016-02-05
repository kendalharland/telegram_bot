library telegram_bot.rpc;

import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;

const API_HOST = 'api.telegram.org';
const DEFAULT_SCHEME = 'http';

Uri buildUri(String token, String apiMethod,
        {Map<String, String> args,
        String scheme: DEFAULT_SCHEME,
        String host: API_HOST}) =>
    new Uri(
        scheme: scheme,
        host: host,
        path: 'bot$token/$apiMethod',
        queryParameters: args);

/// TODO(kharland): support more than just get.
/// TODO(kharland): evaluate the initial response for errors.
Future<Map<String, Object>> requestUri(Uri uri) async {
  var response = await http.get('$uri');
  var apiResponse;
  try {
    apiResponse = new JsonDecoder().convert(response.body);
  } catch (e) {
    /// TODO(kharland): wrap this in log function
    stderr.write('[telegram_bot:requestUri] $e');
  }

  if (apiResponse['ok']) {
    return apiResponse['result'];
  } else {
    throw "request for $uri returned 'ok'=false";
  }
}

Future<Map<String, Object>> requestMethod(String method, String token,
        {Map<String, String> args: const {}}) =>
    requestUri(buildUri(token, method, args: args));
