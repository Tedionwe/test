import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:super_todo/components/ChatMessages.dart';
import 'package:super_todo/models/chat.dart';
import 'package:super_todo/models/message.dart';
import 'package:super_todo/module/utils.dart';
import 'package:super_todo/styles/colors.dart';
import 'package:super_todo/widget/chat/bubble.dart';

import '../firebase.dart';

class ChatPage extends StatefulWidget {
  static final String route = "chat";

  const ChatPage({Key? key}) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  Chat? chatInfo;
  Map<String, dynamic>? chattingWithUser;

  final textController = TextEditingController();

  String messageString = '';

  void onSend() async {
    if (messageString.trim().length == 0) return;
    await sendMessage(context, messageString, chattingWithUser!['username']);
    setState(() {
      messageString = "";
      textController.clear();
    });
  }

  @override
  void dispose() {
    super.dispose();
    textController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as List;

    chatInfo ??= args[0] as Chat;
    chattingWithUser ??= args[1] as Map<String, dynamic>;

    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: SafeArea(
          child: Container(
              child: Column(
        children: [
          ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(chattingWithUser!['photo']),
            ),
            title: Text(chattingWithUser!['name'], style: textTheme.headline5),
            subtitle: Text("Online",
                style: textTheme.bodyText1!.copyWith(color: Colors.white)),
            tileColor: cPrimary,
          ),
          Expanded(
              child: ChatMessages(
            chatInfo: chatInfo!,
          )),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: textController,
                    onChanged: (val) {
                      messageString = val;
                    },
                    style: TextStyle(letterSpacing: 1),
                    decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(0),
                        hintText: "type here....",
                        hintStyle: textTheme.bodyText2!.copyWith(color: cMute),
                        suffix: IconButton(
                            onPressed: onSend,
                            icon: Icon(CupertinoIcons.paperplane, size: 20))),
                  ),
                ),
              ],
            ),
          )
        ],
      ))),
    );
  }
}

Future<void> sendMessage(
    BuildContext context, String messageText, String toUsername) async {
  final currentUser = fAuth.currentUser;

  if (currentUser == null) return;

  final toUsernameDoc = await usersCollection
      .where('username', isEqualTo: toUsername.toLowerCase().trim())
      .get();

  if (toUsernameDoc.docs.length == 0) return;

  final String to = toUsernameDoc.docs[0].data()['uid'];

  String messageId = idGenerator(len: 16);
  final date = DateTime.now();

  final chat = Chat(
      lastMsg: messageText,
      createdAt: date.toString(),
      updatedAt: date.toString(),
      lastModified: date.millisecondsSinceEpoch,
      timestamp: date.millisecondsSinceEpoch);

  final senderChat = chat.copyWith(Chat(id: to));

  final receiverChat = chat.copyWith(Chat(id: currentUser.uid));

  final message = Message(
      id: messageId,
      msg: messageText,
      isSeen: false,
      isDelivered: false,
      recipient: to,
      sender: currentUser.uid,
      sentAt: date.toString(),
      timestamp: date.millisecondsSinceEpoch,
      type: "text");

  final batch = fDb.batch();

  batch.set(
      userChatDocument(currentUser.uid, senderChat.id), senderChat.toMap());

  batch.set(userChatDocument(to, receiverChat.id), receiverChat.toMap());

  batch.set(userChatMessageDocument(currentUser.uid, to, message.id!),
      message.toMap());

  batch.set(userChatMessageDocument(to, currentUser.uid, message.id!),
      message.toMap());

  await batch.commit();

  print("Message sent");
}
