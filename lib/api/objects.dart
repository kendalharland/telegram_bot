library telegram_bot.api.objects;

class APIObject {
  Map<String, Object> _map;

  APIObject(this._map) {
    _map ??= {};
  }

  toString() => '${this.runtimeType}: $_map';

  operator [](String key) => _map[key];
  operator []=(String key, Object value) => _map[key] = value;
}

class Audio extends APIObject {
  Audio(Map<String, Object> map) : super(map);

  String get fileId => super['file_id'];
  int get duration => super['duration'];
  String get performer => super['performer'];
  String get title => super['title'];
  String get mimeType => super['mime_type'];
  int get fileSize => super['file_size'];
}

class Chat extends APIObject {
  Chat(Map<String, Object> map) : super(map);
}

class ChosenInlineResult extends APIObject {
  ChosenInlineResult(Map<String, Object> map) : super(map) {
    if (super['from'] != null) {
      super['from'] = new User(super['from']);
    }
  }

  String get resultId => super['result_id'];
  User get from => super['from'];
  String get query => super['query'];
}

class Contact extends APIObject {
  Contact(Map<String, Object> map) : super(map);

  String get phoneNumber => super['phone_number'];
  String get firstName => super['first_name'];
  String get lastName => super['last_name'];
  int get userId => super['user_id'];
}

class Document extends APIObject {
  Document(Map<String, Object> map) : super(map) {
    if (super['thumb'] != null) {
      super['thumb'] = new PhotoSize(super['thumb']);
    }
  }

  String get fileId => super['file_id'];
  PhotoSize get thumb => super['thumb'];
  String get fileName => super['file_name'];
  String get mimeType => super['mime_type'];
  int get fileSize => super['file_size'];
}

class File extends APIObject {
  File(Map<String, Object> map) : super(map);

  String get fileId => super['file_id'];
  int get fileSize => super['file_size'];
  String get filePath => super['file_path'];
}

class ForceReply extends APIObject {
  ForceReply(Map<String, Object> map) : super(map);

  bool get forceReply => super['force_reply'];
  bool get selective => super['selective'];
}

class InlineQuery extends APIObject {
  InlineQuery(Map<String, Object> map) : super(map) {
    if (super['from'] != null) {
      super['from'] = new User(super['from']);
    }
  }

  String get id => super['id'];
  User get from => super['from'];
  String get query => super['query'];
  String get offset => super['offset'];
}

class InputFile {}

class Location extends APIObject {
  Location(Map<String, Object> map) : super(map);

  double get longitude => super['longitude'];
  double get latitude => super['latitude'];
}

class Message extends APIObject {
  static Message create(Map<String, Object> map) => new Message(map);

  Message(Map<String, Object> map) : super(map) {
    if (super['from'] != null) {
      super['from'] = new User(super['from']);
    }
    if (super['chat'] != null) {
      super['chat'] = new Chat(super['chat']);
    }
    if (super['forward_from'] != null) {
      super['forward_from'] = new User(super['forward_from']);
    }
    if (super['reply_to_message'] != null) {
      super['reply_to_message'] = new Message(super['reply_to_message']);
    }
    if (super['audio'] != null) {
      super['audio'] = new Audio(super['audio']);
    }
    if (super['document'] != null) {
      super['document'] = new Document(super['document']);
    }
    if (super['sticker'] != null) {
      super['sticker'] = new Sticker(super['sticker']);
    }
    if (super['video'] != null) {
      super['video'] = new Video(super['video']);
    }
    if (super['voice'] != null) {
      super['voice'] = new Voice(super['voice']);
    }
    if (super['contact'] != null) {
      super['contact'] = new Contact(super['contact']);
    }
    if (super['location'] != null) {
      super['location'] = new Location(super['location']);
    }
    if (super['new_chat_participant'] != null) {
      super['new_chat_participant'] = new User(super['new_chat_participant']);
    }
    if (super['left_chat_participant'] != null) {
      super['left_chat_participant'] = new User(super['left_chat_participant']);
    }
  }

  int get messageId => super['message_id'];
  User get from => super['from'];
  int get date => super['date'];
  Chat get chat => super['chat'];
  User get forwardFrom => super['forward_from'];
  int get forwardDate => super['forward_date'];
  Message get replyToMessage => super['reply_to_message'];
  String get text => super['text'];
  Audio get audio => super['audio'];
  Document get document => super['document'];
  List<PhotoSize> get photo => super['photo'];
  Sticker get sticker => super['sticker'];
  Video get video => super['video'];
  Voice get voice => super['voice'];
  String get caption => super['caption'];
  Contact get contact => super['contact'];
  Location get location => super['location'];
  User get newChatParticipant => super['new_chat_participant'];
  User get leftChatParticipant => super['left_chat_participant'];
  String get newChatTitle => super['new_chat_title'];
  List<PhotoSize> get newChatPhoto => super['new_chat_photo'];
  bool get deleteChatPhoto => super['delete_chat_photo'];
  bool get groupChatCreated => super['group_chat_created'];
  bool get supergroupChatCreated => super['supergroup_chat_created'];
  bool get channelChatCreated => super['channel_chat_created'];
  int get migrateToChatId => super['migrate_to_chat_id'];
  int get migrateFromChatId => super['migrate_from_chat_id'];
}

class PhotoSize extends APIObject {
  PhotoSize(Map<String, Object> map) : super(map);

  String get fileId => super['file_id'];
  int get width => super['width'];
  int get height => super['height'];
  int get fileSize => super['file_size'];
}

class ReplyKeyboardHide extends APIObject {
  ReplyKeyboardHide(Map<String, Object> map) : super(map);

  bool get hideKeyboard => super['hide_keyboard'];
  bool get selective => super['selective'];
}

class ReplyKeyboardMarkup extends APIObject {
  ReplyKeyboardMarkup(Map<String, Object> map) : super(map);

  List<List<String>> get keyboard => super['keyboard'];
  bool get resizeKeyboard => super['resize_keyboard'];
  bool get oneTimeKeyboard => super['one_time_keyboard'];
  bool get selective => super['selective'];
}

class Sticker extends APIObject {
  Sticker(Map<String, Object> map) : super(map) {
    if (super['thumb'] != null) {
      super['thumb'] = new PhotoSize(super['thumb']);
    }
  }

  String get fileId => super['file_id'];
  int get width => super['width'];
  int get height => super['height'];
  PhotoSize get thumb => super['thumb'];
  int get fileSize => super['file_size'];
}

class Update extends APIObject {
  static Update create(Map<String, Object> map) => new Update(map);

  Update(Map<String, Object> map) : super(map) {
    if (super['message'] != null) {
      super['message'] = new Message(super['message']);
    }
    if (super['inline_query'] != null) {
      super['inline_query'] = new InlineQuery(super['inline_query']);
    }
    if (super['chosen_inline_result'] != null) {
      super['chosen_inline_result'] =
          new ChosenInlineResult(super['chosen_inline_result']);
    }
  }

  int get id => super['update_id'];
  Message get message => super['message'];
  InlineQuery get inlineQuery => super['inline_query'];
  ChosenInlineResult get chosenInlineResult => super['chosen_inline_result'];
}

class User extends APIObject {
  static User create(Map<String, Object> map) => new User(map);

  User(Map<String, Object> map) : super(map);

  int get id => super['id'];
  String get firstName => super['first_name'];
  String get lastName => super['last_name'];
  String get username => super['username'];
}

class UserProfilePhotos extends APIObject {
  UserProfilePhotos(Map<String, Object> map) : super(map);

  int get totalCount => super['total_count'];
  List<PhotoSize> get photos => super['photos'];
}

class Video extends APIObject {
  Video(Map<String, Object> map) : super(map) {
    if (super['thumb'] != null) {
      super['thumb'] = new PhotoSize(super['thumb']);
    }
  }

  String get fileId => super['file_id'];
  int get width => super['width'];
  int get height => super['height'];
  int get duration => super['duration'];
  PhotoSize get thumb => super['thumb'];
  String get mimeType => super['mime_type'];
  int get fileSize => super['file_size'];
}

class Voice extends APIObject {
  Voice(Map<String, Object> map) : super(map);

  String get fileId => super['file_id'];
  int get duration => super['duration'];
  String get mimeType => super['mime_type'];
  int get fileSize => super['file_size'];
}
