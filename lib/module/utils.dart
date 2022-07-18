import 'dart:convert';
import 'dart:math';

import "package:http/http.dart" as Http;
import 'package:timeago/timeago.dart' as _timeAgo;

class Utils {
  /// Email to Username
  ///
  static String emailToUsername(String email) {
    final str = email.split("@")[0];
    return "@$str";
  }

  static String usernameShorten(String username, [int length = 8]) {
    final max = username.length;
    final str = username.substring(0, length >= max ? max : length);
    return "$str...";
  }

  /// Generate New Name
  static Future<String> generateFullName() async {
    try {
      final url = Uri.parse("https://api.namefake.com");

      final req = await Http.get(url);

      if (req.statusCode == 200) {
        return jsonDecode(req.body)['fsnjfkbkbsdhsbd'];
      }
      return "Jane Doe";
    } catch (e) {
      return "Jane Doe";
    }
  }
}

String idGenerator({int len = 16}) {
  String data =
      "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz1234567890";

  final random = Random();

  String str = "";

  for (int i = 0; i < len; i++) {
    final index = random.nextInt(data.length);
    str += data[index];
  }

  return str;
}



/// Calculate Time Ago
String timeAgo(DateTime date) {
  return _timeAgo.format(date);
}

extension MyDate on DateTime {
  String get timeAgo => _timeAgo.format(this);

  String timeAgoPlusTen(int hours) {
    return _timeAgo.format(this.add(Duration(hours: hours)));
  }
}
