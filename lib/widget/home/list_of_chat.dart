import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:super_todo/models/chat.dart';
import 'package:super_todo/module/utils.dart';
import 'package:super_todo/pages/chat.dart';

import '../../firebase.dart';

class ListOfChat extends StatelessWidget {
  final Chat chat;
  const ListOfChat({Key? key, required this.chat}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return StreamBuilder(
        stream: usersCollection.doc(chat.id).snapshots(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text("Error occurred loading chat info");
          }

          if (snapshot.hasData) {
            final userDoc = snapshot.data!.data() as dynamic;

            if (userDoc == null) return Offstage();

            final String name = userDoc['name'];

            final date =
                DateTime.fromMillisecondsSinceEpoch(chat.lastModified!.toInt());

            final dateString = date.timeAgoPlusTen(20);

            // final initials = name.split(' ').map((word) => word[0]).join('');

            return Padding(
              padding: const EdgeInsets.only(bottom: 15),
              child: ListTile(
                onTap: () {
                  Navigator.of(context)
                      .pushNamed(ChatPage.route, arguments: [chat, userDoc]);
                },
                leading: CircleAvatar(
                  // child: Text(initials),
                  backgroundImage: NetworkImage(userDoc['photo']),
                ),
                title: Row(
                  children: [
                    Expanded(child: Text(userDoc['name'] ?? '')),
                    Text(
                      dateString,
                      style: textTheme.caption,
                    )
                  ],
                ),
                subtitle: Text(chat.lastMsg ?? ''),
                trailing: IconButton(
                    onPressed: () {}, icon: Icon(CupertinoIcons.bubble_right)),
              ),
            );
          }

          return CircularProgressIndicator();
        });
  }
}
