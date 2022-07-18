import 'package:flutter/material.dart';
import 'package:super_todo/widget/home/header.dart';
import '../firebase.dart';
import 'Login.dart';

class Profile extends StatelessWidget {
  static const String route = "profile";

  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = fAuth.currentUser;

    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            CircleAvatar(
              radius: 70,
              backgroundImage: NetworkImage(user!.photoURL??''),
            ),
            SizedBox(
              height: 20,
            ),
            Text(user.displayName??'',
                style: Theme.of(context)
                    .textTheme
                    .headline5!
                    .copyWith(color: Colors.black)),
            Text('@username',
                style: Theme.of(context)
                    .textTheme
                    .bodyText2!
                    .copyWith(color: Colors.black)),
            SizedBox(
              height: 50,
            ),

            ListTile(
                title: Text('Change Username'),
                subtitle: Text('modify your current account username ')),

            SizedBox(
              height: 50,
            ),

            /// Logout Button
            ElevatedButton(
              child: Text('Logout'),
              onPressed: () async {
                await fAuth.signOut();
                Navigator.of(context).pushNamed(Login.route);
              },
            )
          ],
        ),
      ),
    ));
  }
}
