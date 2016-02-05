library telegram_bot.api;

import 'dart:async';

import 'package:telegram_bot/rpc.dart';
import 'package:telegram_bot/api/objects.dart';

export 'package:telegram_bot/api/objects.dart';

void _forceType(object, List<Type> types) {
  if (!types.any((Type T) => object.runtimeType == T)) {
    throw new TypeError();
  }
}

/// A simple method for testing your bot's auth token. Requires no parameters.
/// Returns basic information about the bot in form of a User object.
Future<User> getMe(String token) =>
    requestMethod('getMe', token).then(User.create);

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
    {int offset, int limit: 100, int timeout: 0}) {
  var args = <String, String>{'limit': '$limit', 'timeout': '$timeout'};

  if (offset != null) {
    args['offset'] = '$offset';
  }

  return requestMethod('getUpdates', token, args: args)
      .then((updateMaps) => updateMaps.map(Update.create).toList());
}

/// Use this method to send text messages. On success, the sent Message is
/// returned.
///
/// Todo(kharland): Support replyMarkup optional parameter
Future<Message> sendMessage(String token, int chatId, String text,
    {String parseMode: 'Markdown',
    bool disableWebPagePreview: false,
    int replyToMessageId}) async {
  var args = {
    'chat_id': '$chatId',
    'text': text,
    'parse_mode': parseMode,
    'disable_web_page_preview': '$disableWebPagePreview',
  };

  if (replyToMessageId != null) {
    args['reply_to_message_id'] = '$replyToMessageId';
  }

  var messageMap = await requestMethod('sendMessage', token, args: args);
  return new Message(messageMap);
}

/// Use this method to forward messages of any kind. On success, the sent
/// Message is returned.
Future<Message> forwardMessage(
    String token, int chatId, int fromChatId, int messageId) {
  var args = {
    'chat_id': '$chatId',
    'from_chat_id': '$fromChatId',
    'message_id': '$messageId'
  };

  return requestMethod('forwardMessage', token, args: args)
      .then(Message.create);
}

/// Use this method to send photos. On success, the sent Message is returned.
Future<Message> sendPhoto(String token, int chatId, dynamic photo,
    {String caption, int replyToMessageId, dynamic replyMarkup}) {
  _forceType(photo, [String, InputFile]);
  var args = {'chat_id': '$chatId', 'photo': '$photo',};

  if (caption != null) {
    args['caption'] = caption;
  }
  if (replyToMessageId != null) {
    args['reply_to_message_id'] = '$replyToMessageId';
  }
  if (replyMarkup != null) {
    _forceType(
        replyMarkup, [ReplyKeyboardMarkup, ReplyKeyboardHide, ForceReply]);
    args['reply_markup'] = '$replyMarkup';
  }

  return requestMethod('sendPhoto', token, args: args).then(Message.create);
}

/// Use this method to send audio files, if you want Telegram clients to display
/// them in the music player. Your audio must be in the .mp3 format. On
/// success, the sent Message is returned. Bots can currently send audio files
/// of up to 50 MB in size, this limit may be changed in the future.

/// For backward compatibility, when the fields title and performer are both
/// empty and the mime-type of the file to be sent is not audio/mpeg, the file
/// will be sent as a playable voice message. For this to work, the audio must
/// be in an .ogg file encoded with OPUS. This behavior will be phased out in
/// in the future. For sending voice messages, use the sendVoice method instead.
Future<Message> sendAudio(String token, int chatId, dynamic audio,
    {int duration,
    String performer,
    String title,
    int replyToMessageId,
    dynamic replyMarkup}) {
  _forceType(audio, [String, InputFile]);
  var args = {'chat_id': '$chatId', 'audio': '$audio',};

  if (duration != null) {
    audio['duration'] = '$duration';
  }
  if (performer != null) {
    audio['performer'] = performer;
  }
  if (title != null) {
    audio['title'] = title;
  }
  if (replyToMessageId != null) {
    args['reply_to_message_id'] = '$replyToMessageId';
  }
  if (replyMarkup != null) {
    _forceType(
        replyMarkup, [ReplyKeyboardMarkup, ReplyKeyboardHide, ForceReply]);
    args['reply_markup'] = '$replyMarkup';
  }

  return requestMethod('sendAudio', token, args: args).then(Message.create);
}

/// Use this method to send general files. On success, the sent Message is
/// returned. Bots can currently send files of any type of up to 50 MB in size,
/// this limit may be changed in the future.
Future<Message> sendDocument(String token, int chatId, document,
    {int replyToMessageId, dynamic replyMarkup}) {
  _forceType(document, [String, InputFile]);
  var args = {'chat_id': '$chatId', 'document': '$document'};

  if (replyToMessageId != null) {
    args['reply_to_message_id'] = '$replyToMessageId';
  }
  if (replyMarkup != null) {
    _forceType(
        replyMarkup, [ReplyKeyboardMarkup, ReplyKeyboardHide, ForceReply]);
    args['reply_markup'] = '$replyMarkup';
  }
  return requestMethod('sendDocument', token, args: args).then(Message.create);
}
