import 'package:flutter/material.dart';

final inputDecoration = InputDecoration(
    alignLabelWithHint: true,
    floatingLabelBehavior: FloatingLabelBehavior.always,
    border: UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.black, width: 5)),
    labelText: "");

class EditNameAndUsername extends StatelessWidget {
  String name = '';
  String username = '';
  String password = '';

  EditNameAndUsername({Key? key}) : super(key: key);

  void onProceed(BuildContext context) {
    if (name.trim().length == 0) return;
    if (username.trim().length == 0) return;
    if (password.trim().length == 0) return;

    Navigator.of(context)
        .pop([name.trim(), username.toLowerCase().trim(), password]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Container(
          margin: EdgeInsets.only(left: 30, right: 30),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  children: [
                    Text("Enter Your Account Information",
                        style: Theme.of(context)
                            .textTheme
                            .headline6!
                            .copyWith(color: Colors.black)),
                    SizedBox(height: 30),
                    TextFormField(
                      onChanged: (val) {
                        name = val;
                      },
                      style: TextStyle(letterSpacing: 1),
                      decoration: inputDecoration.copyWith(labelText: "Name: "),
                    ),
                    TextFormField(
                      onChanged: (val) {
                        username = val;
                      },
                      style: TextStyle(letterSpacing: 1),
                      decoration:
                          inputDecoration.copyWith(labelText: "Username: "),
                    ),
                    TextFormField(
                      onChanged: (val) {
                        password = val;
                      },
                      style: TextStyle(letterSpacing: 1),
                      decoration:
                          inputDecoration.copyWith(labelText: "Password: "),
                    ),
                    SizedBox(height: 30),
                    ElevatedButton(
                        onPressed: () {
                          onProceed(context);
                        },
                        child: Text("Proceed"))
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
