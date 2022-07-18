import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import "dart:math";

const isDebug = true;

/// Firebase Auth
final fAuth = FirebaseAuth.instance;

// Firestore database
final fDb = FirebaseFirestore.instance;

/// Firestore Collection Names
///

const String UserCollections = "users";

const String ChatCollectionsName = "chats";

const String MessageCollectionsName = "messages";

///
/// End Firestore Collection Names

/// Firestore Collections
///

final usersCollection = fDb.collection(UserCollections);

final chatsCollection = fDb.collection(ChatCollectionsName);

final messagesCollection = fDb.collection(MessageCollectionsName);

CollectionReference<Map<String, dynamic>> userChatCollection(String uid) {
  return usersCollection.doc(uid).collection(ChatCollectionsName);
}

CollectionReference<Map<String, dynamic>> userChatMessageCollection(
    String uid, String chatId) {
  return fDb.collection(UserCollections)
      .doc(uid)
      .collection(ChatCollectionsName)
      .doc(chatId)
      .collection(MessageCollectionsName);
}

///
/// End Firestore Collections

/// Firestore Documents
///

DocumentReference<Map<String, dynamic>> userChatDocument(
    String uid, String chatId) {
  return usersCollection.doc(uid).collection(ChatCollectionsName).doc(chatId);
}

DocumentReference<Map<String, dynamic>> userChatMessageDocument(
    String uid, String chatId, String messageId) {
  return usersCollection
      .doc(uid)
      .collection(ChatCollectionsName)
      .doc(chatId)
      .collection(MessageCollectionsName)
      .doc(messageId);
}
