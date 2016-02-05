library telegram_bot.api;

import 'dart:async';

import 'package:telegram_bot/rpc.dart';
import 'package:telegram_bot/api/objects.dart';
export 'package:telegram_bot/api/objects.dart';

/// A simple method for testing your bot's auth token. Requires no parameters.
/// Returns basic information about the bot in form of a User object.
Future<User> getMe(String token) =>
    requestMethod('getMe', token).then((userMap) => new User(userMap));

/// [offset] is an identifier of the first update to be returned. Must be
/// greater by one than the highest among the identifiers of previously received
/// updates. By default, updates starting with the earliest unconfirmed update
/// are returned. An update is considered confirmed as soon as getUpdates is
/// called with an offset higher than its update_id.
///
/// [limit] limits the number of updates to be retrieved. Values between 1—100
/// are accepted. Defaults to 100.
///
/// [timeout] is the timeout in seconds for long polling. Defaults to 0, i.e.
/// usual short polling
Future<List<Update>> getUpdates(String token,
    {int offset, int limit, int timeout}) {
  var args = _removeNullKeys(
      {'offset': '$offset', 'limit': '$limit', 'timeout': '$timeout'});

  return requestMethod('getUpdates', token, args: args)
      .then((updateMaps) => updateMaps.map((map) => new Update(map)).toList());
}

/// Use this method to send text messages. On success, the sent Message is
/// returned.
///
/// Todo(kharland): Support replyMarkup optional parameter
Future<Message> sendMessage(String token, int chatId, String text,
    {String parseMode,
    bool disableWebPagePreview,
    int replyToMessageId}) async {
  var args = _removeNullKeys({
    'chat_id': '$chatId',
    'text': text,
    'parse_mode': parseMode,
    'disable_web_page_preview': '$disableWebPagePreview',
    'reply_to_message_id': '$replyToMessageId',
  });

  var messageMap = await requestMethod('sendMessage', token, args: args);
  return new Message(messageMap);
}

Map<String, String> _removeNullKeys(Map<String, Object> fields) {
  var map = <String, String>{};

  fields.keys.forEach((String key) {
    if (fields[key] != null) map[key] = fields[key];
  });

  return map;
}
