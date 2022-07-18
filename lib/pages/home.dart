import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:super_todo/components/ChatList.dart';
import 'package:super_todo/components/ListOfUsers.dart';
import '../firebase.dart';
import 'package:super_todo/models/chat.dart';
import 'package:super_todo/models/message.dart';
import 'package:super_todo/module/utils.dart';
import 'package:super_todo/styles/colors.dart';
import 'package:cupertino_icons/cupertino_icons.dart';
import 'package:super_todo/widget/home/compose_chat.dart';
import 'package:super_todo/widget/home/header.dart';
import 'package:super_todo/widget/home/list_of_chat.dart';

import 'chat.dart';
import 'profile.dart';

class Home extends StatefulWidget {
  static final route = 'home';

  Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String to = "";
  String message = "";

  /// ----- On To Input Change ------
  /// This function get called each time the use types into to input box
  /// and the text in the box gets passed as an argument to out function
  /// which then save it to the @to variable in our widget using the
  /// setState() function
  void onToInputChange(String val) {
    print("In-APP to: " + val);
    setState(() {
      to = val;
    });
  }

  /// --- On To Input Change End    -----

  /// ------ On Message Input Change -------
  ///  each time the user types into the message input this function get called and the message
  ///   gets passed as an argument to the function
  ///
  /// Which we then save to the variable @to using the setState function
  void onMessageInputChange(String val) {
    print("In-APP MessageHw: " + val);

    setState(() {
      message = val;
    });
  }

  /// ----- On Message Input Change End

  /// ----- On Floating Action Button Click ------
  ///  Shows dialog to enter to and message text
  ///
  void onSendButtonClick(String? username) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("New Message"),
            content: ComposeChat(
              to: username ?? "",
              toChange: onToInputChange,
              messageChange: onMessageInputChange,
            ),
            actions: [
              ElevatedButton.icon(
                onPressed: () async {
                  try {
                    await sendMessage(context, message, to);
                    Navigator.of(context).pop();
                  } catch (e) {
                    print('error occurred sending message');
                  }
                },
                icon: Icon(CupertinoIcons.paperplane, size: 20),
                label: Text("Send"),
              )
            ],
          );
        });
  }

  /// ---- End Floating Action Button Click -----

  /// ----- Widget Build Function --------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: SafeArea(
            child: Column(
          children: [
            SizedBox(
              height: 20,
            ),

            /// Header Widget
            InkWell(
                onTap: () {
                  Navigator.of(context).pushNamed(Profile.route);
                },
                child: HomeHeader()),

            SizedBox(
              height: 50,
            ),

            /// LIST OF USERS
            ListOfUsers(
              onUserClick: (String username) {
                onSendButtonClick(username);
              },
            ),

            SizedBox(
              height: 30,
            ),

            Expanded(
                child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                children: [ChatList()],
              ),
            )),
          ],
        )),
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(CupertinoIcons.chat_bubble_text),
          onPressed: () {
            onSendButtonClick(null);
          }),
    );
  }
}
