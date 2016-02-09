library telegram_bot.api.rpc;

import 'dart:async';
import 'dart:io';
import 'dart:convert';

import 'package:telegram_bot/rpc/exception.dart';

import 'package:http/http.dart' as http;

enum HttpMethod { GET, POST }

typedef Future<String> Request(Uri uri);

/// Telegram API 'requries' https (even though queries will still work over http).
/// see https://core.telegram.org/bots/api#making-requests
const _API_PROTOCOL = 'https';
const _API_HOST = 'api.telegram.org';

/// TODO(kharland): Maybe write a converter that decodes directly from JSON to
/// the Telegram bot API Object type?
Map<String, Object> _decodeResponse(String text) {
  try {
    return new JsonDecoder().convert(text);
  } on FormatException catch (e) {
    stderr.write('could not decode Telegram Bot API response: $e');
  }
}

/// Construct a uri from a telegram bot [token], a telegram bot [apiMethod],
/// the method [args], an [scheme], and the hostname telegram's bot api [host].
Uri buildUri(String token, String apiMethod, {Map<String, String> args}) =>
    new Uri(
        scheme: _API_PROTOCOL,
        host: _API_HOST,
        path: 'bot$token/$apiMethod',
        queryParameters: args);

/// Request [uri] using the [HttpMethod] [method]. Defaults to GET.
Future<Map<String, Object>> requestUri(Uri uri, {Request request: GET}) async {
  String response = await request(uri);
  Map<String, Object> apiResponse = _decodeResponse(response);
  if (!apiResponse['ok']) {
    throw new TelegramBotApiRequestException(apiResponse['description']);
  }
  return apiResponse['result'];
}

Future<String> GET(Uri uri) async => (await http.get('$uri')).body;
Future<String> POST(Uri uri) async => (await http.post('$uri')).body;

