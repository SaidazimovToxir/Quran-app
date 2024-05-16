import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class TimeAPI {
  late String hijriDate;
  late String gregorianDate;

  Future<String> getTime() async {
    try {
      DateTime currentTime = DateTime.now();
      String formattedDate = DateFormat('dd-MM-yyyy').format(currentTime);

      String url = "http://api.aladhan.com/v1/gToH/$formattedDate";
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.body);
        hijriDate = _formatHijriDate(data['data']['hijri']);
        gregorianDate = _formatGregorianDate(data['data']['gregorian']);
        return "";
      } else {
        return "Failed to fetch time: ${response.statusCode}";
      }
    } catch (e) {
      print("ERROR: $e");
      return "Error fetching time: $e";
    }
  }

  static String _formatHijriDate(Map<String, dynamic> hijri) {
    String hDay = hijri['day'];
    String hMonth = hijri['month']['en'];
    String hYear = hijri['year'];
    String hDes = hijri['designation']['abbreviated'];

    return "$hDay $hMonth $hYear $hDes";
  }

  static String _formatGregorianDate(Map<String, dynamic> gregorian) {
    String gWeek = gregorian['weekday']['en'];
    String gDay = gregorian['day'];
    String gMonth = gregorian['month']['en'];
    String gYear = gregorian['year'];

    return "$gWeek, $gDay $gMonth $gYear";
  }
}
