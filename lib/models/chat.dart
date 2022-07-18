import 'package:super_todo/models/message.dart';

class Chat {
  final String? id;
  final String? lastMsg;

  final bool? isBlock;
  final bool? isVerified;

  final String? createdAt;
  final String? updatedAt;
  final num? lastModified;
  final num? timestamp;

  Chat({
    this.id,
    this.lastMsg,
    this.isBlock,
    this.isVerified,
    this.createdAt,
    this.updatedAt,
    this.lastModified,
    this.timestamp,
  });

  factory Chat.fromJson(Map<String, dynamic> json) {
 

    return Chat(
      id: json['id'], 
      lastMsg: json['lastMsg'] ?? "",
     
      isBlock: json['isBlock'] ?? false,
      isVerified: json['isVerified'] ?? false,
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      lastModified: json['lastModified'],
      timestamp: json['timestamp'],
    );
  }

  // copyWith(Chat chat) {
  //   return Chat(
  //       id: chat.id ?? this.id,
  //       lastMsg: chat.lastMsg ?? this.lastMsg,
  //       isBlock: chat.isBlock ?? this.isBlock,
  //       isVerified: chat.isVerified ?? this.isVerified,
  //       createdAt: chat.createdAt ?? this.createdAt,
  //       updatedAt: chat.updatedAt ?? this.updatedAt,
  //       lastModified: chat.lastModified ?? this.lastModified,
  //       timestamp: chat.timestamp ?? this.timestamp);
  // }


  copyWith(Chat chat) {
    return Chat(
        id: chat.id ?? this.id,
        lastMsg: chat.lastMsg ?? this.lastMsg,
        isBlock: chat.isBlock ?? this.isBlock,
        isVerified: chat.isVerified ?? this.isVerified,
        createdAt: chat.createdAt ?? this.createdAt,
        updatedAt: chat.updatedAt ?? this.updatedAt,
        lastModified: chat.lastModified ?? this.lastModified,
        timestamp: chat.timestamp ?? this.timestamp);
  }

  Map<String, dynamic> toMap() {
    return {
      "id": this.id,   
      "lastMsg": this.lastMsg,
      "isBlock": this.isBlock,
      "isVerified": this.isVerified,
      "createdAt": this.createdAt,
      "updatedAt": this.updatedAt,
      "lastModified": this.lastModified,
      "timestamp": this.timestamp
    };
  }

  String toString() {
    return """
     id: ${this.id},
      lastMsg: ${this.lastMsg},
      isBlock: ${this.isBlock},
      isVerified: ${this.isVerified},
      createdAt: ${this.createdAt},
      updatedAt: ${this.updatedAt},
      lastModified: ${this.lastModified},
      timestamp: ${this.timestamp}
    """;
  }
}
