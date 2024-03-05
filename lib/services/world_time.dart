import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {

  String location;
  String time = "";
  String flag;
  String url;
  bool isDaytime = false;


  WorldTime({
    required this.location,
    required this.flag,
    required this.url,
  });

  Future<void> getTime() async {
    await Future.delayed(const Duration(seconds: 1));

    try {
      Response res = await get(
          Uri.https(
              'worldtimeapi.org',
              '/api/timezone/$url'
          ));
      Map data = jsonDecode(res.body);
      // print(data);
      String datetime = data['datetime'];
      String offset = data['utc_offset'].substring(0,3);
      // print(datetime);
      // print(offset);
      DateTime now = DateTime.parse(datetime);
      now = now.add(Duration(hours: int.parse(offset)));

      isDaytime = now.hour > 6 && now.hour < 20;
      time = DateFormat.Hm().format(now);
    } catch (e) {
      time = 'Something went wrong...';
    }


  }

}