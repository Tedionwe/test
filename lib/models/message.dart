class Message {
  final String? id;

  final String? msg;

  final String? type;

  final String? sender;

  final String? recipient;

  final bool? isDelivered;

  final bool? isSeen;

  final String? sentAt;

  final num? timestamp;

  Message({
    this.id,
    this.msg,
    this.sender,
    this.recipient,
    this.sentAt,
    this.timestamp,
    this.type,
    this.isDelivered,
    this.isSeen,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
        id: json["id"],
        msg: json["msg"],
        sender: json["sender"],
        recipient: json["recipient"],
        sentAt: json["sentAt"],
        timestamp: json["timestamp"],
        isDelivered: json["isDelivered"],
        isSeen: json["isSeen"],
        type: json["type"]);
  }

  copyWith(Message message) {
    return Message(
        id: message.id ?? this.id,
        msg: message.msg ?? this.msg,
        sender: message.sender ?? this.sender,
        recipient: message.recipient ?? this.recipient,
        sentAt: message.sentAt ?? this.sentAt,
        timestamp: message.timestamp ?? this.timestamp,
        isDelivered: message.isDelivered ?? this.isDelivered,
        isSeen: message.isSeen ?? this.isSeen,
        type: message.type ?? this.type);
  }

  Map<String, dynamic> toMap() {
    return {
      "id": this.id,
      "msg": this.msg,
      "sender": this.sender,
      "recipient": this.recipient,
      "sentAt": this.sentAt,
      "timestamp": this.timestamp,
      "isDelivered": this.isDelivered,
      "isSeen": this.isSeen,
      "type": this.type,
    };
  }

  String toString() {
    return """
        id: ${this.id},
        msg: ${this.msg},
        sender: ${this.sender},
        recipient: ${this.recipient},
        sentAt: ${this.sentAt},
        timestamp: ${this.timestamp},
        isDelivered: ${this.isDelivered},
        isSeen: ${this.isSeen},
        type: ${this.type},
    """;
  }
}
