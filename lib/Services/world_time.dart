import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime{
  String location;
  String time='';
  String flag;
  String subUrl;
  bool isDayTime=false;

  WorldTime({required this.location ,required this.flag ,required this.subUrl});
  Future<void> getTime() async{
    try {
      Uri url=Uri.https('worldtimeapi.org','api/timezone/$subUrl');
      Response response=await get(url);
      Map data=jsonDecode(response.body);
      //print(data);
      // get properties
      String datetime=data['datetime'];
      String offset=data['utc_offset'].substring(0,3);
      //create DateTime object
      DateTime now=DateTime.parse(datetime);
      now = now.add(Duration(hours: int.parse(offset)));
      //set the time property
      isDayTime= now.hour>6 && now.hour <20? true:false;
      //print(now);
      time = DateFormat.jm().format(now);
    } catch (e) {
      print('cought error:$e');
      time='could not get time data';
    }
    //print(now);
    //print(offset);
  }
}