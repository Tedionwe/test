import 'dart:convert';

class UserModel {
  final String uid;
  final String name;
  final String photo;
  final String email;
  final String username;
  final num timestamp;
  UserModel({
    required this.uid,
    required this.name,
    required this.photo,
    required this.email,
    required this.username,
    required this.timestamp,
  });

  UserModel copyWith({
    String? uid,
    String? name,
    String? photo,
    String? email,
    String? username,
    num? timestamp,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      name: name ?? this.name,
      photo: photo ?? this.photo,
      email: email ?? this.email,
      username: username ?? this.username,
      timestamp: timestamp ?? this.timestamp,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'photo': photo,
      'email': email,
      'username': username,
      'timestamp': timestamp,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'],
      name: map['name'],
      photo: map['photo'],
      email: map['email'],
      username: map['username'],
      timestamp: map['timestamp'] ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserModel(uid: $uid, name: $name, photo: $photo, email: $email, username: $username, timestamp: $timestamp)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is UserModel &&
      other.uid == uid &&
      other.name == name &&
        other.photo == photo &&
      other.email == email &&
      other.username == username &&
        other.timestamp == timestamp;
  }

  @override
  int get hashCode {
    return uid.hashCode ^
      name.hashCode ^
        photo.hashCode ^
        email.hashCode ^
      username.hashCode ^
        timestamp.hashCode;
  }
}
