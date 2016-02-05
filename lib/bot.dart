library telegram_bot;

import 'dart:async';
import 'package:telegram_bot/api/api.dart' as api;

class TelegramBot {
  final String token;
  api.User _self;

  TelegramBot(this.token);

  Future initialize() async {
    _self = await api.getMe(token);
  }

  @override
  int get id => _self.id;

  @override
  String get username => _self.username;

  @override
  String get firstName => _self.firstName;

  Future<List<api.Update>> getUpdates({int offset, int limit, int timeout}) =>
      api.getUpdates(token, offset: offset, limit: limit, timeout: timeout);

  Future<api.Message> sendMessage(int chatId, String text,
          {String parseMode,
          bool disableWebPagePreview,
          int replyToMessageId}) =>
      api.sendMessage(token, chatId, text,
          parseMode: parseMode,
          disableWebPagePreview: disableWebPagePreview,
          replyToMessageId: replyToMessageId);

  Future<api.Message> forwardMessge(
          int chatId, int fromChatId, int messageId) =>
      api.forwardMessage(token, chatId, fromChatId, messageId);

  Future<api.Message> sendPhoto(int chatId, dynamic photo,
          {String caption, int replyToMessageId, dynamic replyMarkup}) =>
      api.sendPhoto(token, chatId, photo,
          caption: caption, replyToMessageId: replyToMessageId);

  Future<api.Message> sendAudio(int chatId, dynamic audio,
          {int duration,
          String performer,
          String title,
          int replyToMessageId,
          dynamic replyMarkup}) =>
      api.sendAudio(token, chatId, audio,
          duration: duration,
          performer: performer,
          title: title,
          replyToMessageId: replyToMessageId,
          replyMarkup: replyMarkup);

  Future<api.Message> sendDocument(int chatId, document,
          {int replyToMessageId, dynamic replyMarkup}) =>
      api.sendDocument(token, chatId, document,
          replyToMessageId: replyToMessageId, replyMarkup: replyMarkup);
}
