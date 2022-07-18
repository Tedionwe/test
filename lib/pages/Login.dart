import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:super_todo/components/EditNameAndUsername.dart';
import 'package:super_todo/firebase.dart';
import 'package:super_todo/models/user.dart';
import 'package:super_todo/module/crypto.dart';
import 'package:super_todo/module/utils.dart';
import 'package:super_todo/pages/home.dart';
import 'package:super_todo/styles/colors.dart';

class Login extends StatefulWidget {
  static final String route = 'login';

  Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  late TextTheme textTheme;

  void loginAsGuest() async {
    final nameAndUsername = await showDialog<List<String>>(
            context: context,
            barrierDismissible: false,
            useSafeArea: true,
            builder: (BuildContext context) {
              return EditNameAndUsername();
            }) ??
        [];

    if (nameAndUsername.length < 2) return;

    final user = await signInAsGuest(nameAndUsername[0], nameAndUsername[1]);

    if (user == null) return;

    Navigator.of(context).pushNamedAndRemoveUntil(Home.route, (route) => false);
  }

  void loginWithGoogle() async {
    final user = await signInWithGoogle();

    if (user == null) return;

    Navigator.of(context).pushNamedAndRemoveUntil(Home.route, (route) => false);
  }

  Future<UserCredential?> signInAsGuest(String name, String username) async {
    final guestAccount = await fAuth.signInAnonymously();
    final userAuth = guestAccount.user;

    if (userAuth == null) return null;

    final email = '$username@tungar.com';

    final photoUrl =
        "https://www.gravatar.com/avatar/${Crypto.hash(email, CryptoAlg.md5)}?d=identicon&s=250";

    final userData = UserModel(
        email: email,
        username: username,
        photo: photoUrl,
        name: name,
        uid: userAuth.uid,
        timestamp: DateTime.now().millisecondsSinceEpoch);

    await usersCollection.doc(userData.uid).set(userData.toMap());

    try {
     await userAuth.updateEmail(userData.email);
    await  userAuth.updatePhotoURL(userData.photo);
   await   userAuth.updateDisplayName(userData.name);
    } catch (err) {
      print(err);
    }

    // update profile photo

    return guestAccount;
  }

  /// Sign In With Google Auth
  Future<UserCredential?> signInWithGoogle() async {
    try {
      final googleSignIn = await GoogleSignIn().signIn();

      if (googleSignIn == null) return null;

      final googleAuth = await googleSignIn.authentication;

      final googleAuthProviderCredential = GoogleAuthProvider.credential(
          idToken: googleAuth.idToken, accessToken: googleAuth.accessToken);

      return fAuth.signInWithCredential(googleAuthProviderCredential);
    } catch (e) {
      print(e);
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: Container(
          color: Colors.white,
          padding: const EdgeInsets.all(15),
          child: SingleChildScrollView(
            physics: NeverScrollableScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/bg1.png",
                  height: 250,
                ),
                SizedBox(
                  height: 50,
                ),
                Text(
                  "Welcome to Tungar Messenger",
                  style: textTheme.headline3?.copyWith(
                      color: Colors.red.shade500, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Sign in to Get Started",
                  style: textTheme.headline4?.copyWith(color: cMute),
                ),
                SizedBox(
                  height: 50,
                ),
                Center(
                  child: OutlinedButton.icon(
                      onPressed: loginAsGuest,
                      style: ButtonStyle(
                          shape: MaterialStateProperty.all(StadiumBorder()),
                          elevation: MaterialStateProperty.all(0),
                          padding: MaterialStateProperty.all(
                              const EdgeInsets.only(
                                  top: 10, bottom: 10, left: 30, right: 30))),
                      icon: Icon(
                        Icons.person,
                        size: 25,
                      ),
                      label: Text("Continue As Guest")),
                ),
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: ElevatedButton.icon(
                      onPressed: loginWithGoogle,
                      style: ButtonStyle(
                          shape: MaterialStateProperty.all(StadiumBorder()),
                          elevation: MaterialStateProperty.all(0),
                          padding: MaterialStateProperty.all(
                              const EdgeInsets.only(
                                  top: 10, bottom: 10, left: 30, right: 30))),
                      icon: Image.asset(
                        'assets/google.png',
                        width: 25,
                        height: 25,
                        color: Colors.white,
                        fit: BoxFit.cover,
                      ),
                      label: Text("Sign In With Google")),
                ),
              ],
            ),
          )),
    );
  }
}
