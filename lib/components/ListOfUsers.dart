import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:super_todo/firebase.dart';
import 'package:super_todo/models/user.dart';

typedef OnUserClick = void Function(String username);

class ListOfUsers extends StatelessWidget {
  final OnUserClick onUserClick;

  const ListOfUsers({Key? key, required this.onUserClick}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: usersCollection
          .orderBy('timestamp', descending: true)
          .limit(20)
          .snapshots(),
      builder: (BuildContext context,
          AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
        if (snapshot.hasError) return ErrorLoadingUsers();

        if (snapshot.hasData) {
          if (snapshot.data == null) return Offstage();

          final users = snapshot.data!.docs
              .map((e) => UserModel.fromMap(e.data()))
              .toList();

          return Container(
            width: MediaQuery.of(context).size.width,
            color: Colors.grey.shade200,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  reverse: true,
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: users
                        .map((e) => Container(
                            child: InkWell(
                                onTap: () {
                                  onUserClick(e.username);
                                },
                                child: RecentUser(user: e))))
                        .toList(),
                  )),
            ),
          );
        }

        return LoadingUsers();
      },
    );
  }
}

class RecentUser extends StatelessWidget {
  final UserModel user;
  const RecentUser({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
          child: Column(
        children: [
          CircleAvatar(backgroundImage: NetworkImage(user.photo), radius: 30),
          SizedBox(
            height: 10,
          ),
          Text(user.name, style: Theme.of(context).textTheme.bodyText2)
        ],
      )),
    );
  }
}

/// To Be Shown When loading messages
class LoadingUsers extends StatelessWidget {
  const LoadingUsers({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator();
  }
}

/// To Be Shown When an error occurs loading messages
class ErrorLoadingUsers extends StatelessWidget {
  const ErrorLoadingUsers({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text("Error Loading Recent Users");
  }
}
