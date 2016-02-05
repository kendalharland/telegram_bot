library telegram_bot;

import 'package:telegram_bot/api/api.dart' as api;

class TelegramBot implements api.User {
  final String token;
  User _self;

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

  Future<List<Updates>> getUpdates({int offset, int limit, int timeout}) =>
      api.getUpdates(token, offset: offset, limit: limit, timeout: timeout);

  Future<Message> sendMessage(int chatId, String text,
          {String parseMode,
          bool disableWebPagePreview,
          int replyToMessageId}) =>
      api.sendMessage(token, chatId, text,
          parseMode: parseMode,
          disableWebPagePreview: disableWebPagePreview,
          replyToMessageId: replyToMessageId);
}
