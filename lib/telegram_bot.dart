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

  int get id => _self.id;

  String get username => _self.username;

  String get firstName => _self.firstName;

  Future<api.User> getMe() => api.getMe(token);

  Future<List<api.Update>> getUpdates({
    int offset,
    int limit: 100,
    int timeout: 0,
  }) =>
      api.getUpdates(token, offset: offset, limit: limit, timeout: timeout);

  Future<api.Message> sendMessage(
    int chatId,
    String text, {
    String parseMode: 'Markdown',
    bool disableWebPagePreview: false,
    int replyToMessageId,
  }) =>
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

  Future<api.Message> sendSticker(int chatId, dynamic sticker,
          {int replyToMessageId, dynamic replyMarkup}) =>
      api.sendSticker(token, chatId, sticker,
          replyToMessageId: replyToMessageId, replyMarkup: replyMarkup);

  Future<api.Message> sendVideo(int chatId, dynamic video,
          {int duration,
          String caption,
          int replyToMessageId,
          dynamic replyMarkup}) =>
      api.sendVideo(token, chatId, video,
          duration: duration,
          caption: caption,
          replyToMessageId: replyToMessageId,
          replyMarkup: replyMarkup);

  Future<api.Message> sendVoice(int chatId, dynamic voice,
          {int duration, int replyToMessageId, dynamic replyMarkup}) =>
      api.sendVideo(token, chatId, voice,
          duration: duration,
          replyToMessageId: replyToMessageId,
          replyMarkup: replyMarkup);

  Future<api.Message> sendLocation(
          int chatId, double latitude, double longitude,
          {int replyToMessageId, dynamic replyMarkup}) =>
      api.sendLocation(token, chatId, latitude, longitude,
          replyToMessageId: replyToMessageId, replyMarkup: replyMarkup);

  Future<api.UserProfilePhotos> getUserProfilePhotos(int userId,
          {int offset, int limit}) =>
      api.getUserProfilePhotos(token, userId, offset: offset, limit: limit);
}
