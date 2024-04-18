import 'dart:async';

import 'package:flutter/material.dart';
import 'package:world_time/Services/world_time.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Map data={};
  static const oneSec = Duration(seconds:10);
  void updateNow() async{
    print(data);
    WorldTime instance=WorldTime(location: data['location'], flag: data['flag'], subUrl: data['subUrl']);
    await instance.getTime();
    setState(() {
      data['time']=instance.time;
      data['location']=instance.location;
      data['isDayTime']=instance.isDayTime;
      data['flag']=instance.flag;
      data['subUrl']=instance.subUrl;
    });

  }
  @override
  Widget build(BuildContext context) {
    Timer.periodic(oneSec,(timer){updateNow();});
    data=data.isNotEmpty? data:ModalRoute.of(context)?.settings.arguments as Map;
    //print(data);
    String bgImage =data['isDayTime'] ? 'Day.jpg':'Night.jpg';
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage('assets/$bgImage'),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 120.0, 0, 0),
            child: Column(
              children: <Widget>[
                TextButton.icon(
                    onPressed: () async{
                      dynamic result= await Navigator.pushNamed(context, '/Location');
                      setState(() {
                        data['time']=result['time'];
                        data['location']=result['location'];
                        data['isDayTime']=result['isDayTime'];
                        data['flag']=result['flag'];
                        data['subUrl']=result['subUrl'];
                      });

                    },
                    icon: Icon(
                      Icons.edit_location,
                      color: Colors.grey[300],
                    ),
                    label: Text(
                      'Edit Location',
                      style: TextStyle(
                        color: Colors.grey[300],
                      ),
                    ),
                ),
                SizedBox(height: 20.0,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      data['location'],
                      style: TextStyle(
                        fontSize: 28,
                        letterSpacing: 2.0,
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
                SizedBox(height: 20.0),
                Text(
                  data['time'],
                  style: TextStyle(
                    fontSize: 66.0,
                    color: Colors.white,
                  ),
                )

              ],
            ),
          ),
        ),
      ),
    );
  }
}
