import 'package:flutter/material.dart';
import 'package:super_todo/styles/colors.dart';

class Screen2 extends StatelessWidget {
  final VoidCallback next;
  final VoidCallback skip;

  const Screen2({Key? key, required this.next, required this.skip})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
        color: Colors.white,
        padding: const EdgeInsets.all(15),
        child: SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AnimatedOpacity(
                  duration: Duration(seconds: 1),
                  opacity: 0.9,
                  curve: Curves.easeInBack,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 100,
                      ),
                      Image.asset(
                        "assets/bg2.png",
                        height: 250,
                      ),
                      SizedBox(
                        height: 100,
                      ),
                      Text(
                        "Live Village Update",
                        style: textTheme.headline4?.copyWith(
                            color: Colors.red.shade500,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Get realtime information from village people",
                        style: textTheme.caption?.copyWith(fontSize: 14),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(onPressed: this.skip, child: Text("Skip")),
                      FloatingActionButton(
                        onPressed: this.next,
                        elevation: 0,
                        child: Icon(Icons.navigate_next),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
