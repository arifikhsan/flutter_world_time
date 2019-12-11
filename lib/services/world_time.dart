import 'dart:convert';

import 'package:http/http.dart';
import 'package:intl/intl.dart';

class WorldTime {
  String location; // location name for the UI
  String time; // the time in that location
  String flag; // url to an assets image
  String url; // location url
  bool daytime;

  WorldTime({this.location, this.url, this.flag, this.time});

  Future<void> getTime() async {
    try {
      Response response =
          await get('http://worldtimeapi.org/api/timezone/$url');
      Map data = jsonDecode(response.body);
      String datetime = data['utc_datetime'];
      String offset = data['utc_offset'].substring(1, 3);
      DateTime now = DateTime.parse(datetime);
      now = now.add(Duration(hours: int.parse(offset)));
      // set the time property
      time = DateFormat.jm().format(now);
      daytime = now.hour > 6 && now.hour < 20 ? true : false;
      print(time);
    } catch (e) {
      print('caught error: $e');
      time = 'error nih';
    }
  }
}
