library telegram_bot.rpc.exception;

class TelegramBotApiRequestException implements Exception {
  final String message;

  const TelegramBotApiRequestException(this.message);

  @override
  operator ==(other) =>
      other is TelegramBotApiRequestException && other.message == message;

  @override
  toString() => "Telegram Bot API request failed with $message";
}
