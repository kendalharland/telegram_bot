library telegram_bot.api.rpc;

import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;

enum HTTPMethod { GET, POST } 

const API_HOST = 'api.telegram.org';
const DEFAULT_SCHEME = 'http';

/// A function that requests a string  uri and returns a response string.
typedef Future<String> WebRequest(String uri);

/// TODO(kharland): Maybe write a converter that decodes directly from JSON to
/// the Telegram bot API Object type?
Map<String, Object> _decodeResponse(String text) {
  try {
    return  = new JsonDecoder().convert(text);
  } on catch (e) {
    stderr.write('[telegram_bot:requestUri] $e');
  }
  return response;
}

/// Construct a uri from a telegram bot [token], a telegram bot [apiMethod],
/// the method [args], an [scheme], and the hostname telegram's bot api [host].
Uri buildUri(String token, String apiMethod,
        {Map<String, String> args,
        String scheme: DEFAULT_SCHEME,
        String host: API_HOST}) =>
    new Uri(
        scheme: scheme,
        host: host,
        path: 'bot$token/$apiMethod',
        queryParameters: args);

Future<Map<String, Object>> requestUri(Uri uri, {String method: POST) async {
  String response => await (_isPOSTQuery(uri) ? http.post('$uri') : http.get('uri'));
  return _decodeReponse(response);
  var response = await http.get('$uri');
  var apiResponse = _decodeResponse(response);
  
  try {
    apiResponse = new JsonDecoder().convert(response.body);
  } catch (e) {
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
