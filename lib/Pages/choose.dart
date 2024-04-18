import 'package:flutter/material.dart';
import 'package:world_time/Services/world_time.dart';

class ChooseLocation extends StatefulWidget {
  const ChooseLocation({super.key});

  @override
  State<ChooseLocation> createState() => _ChooseLocationState();
}

class _ChooseLocationState extends State<ChooseLocation> {
  int counter=0;
  List locations = [
    WorldTime(subUrl: 'Europe/London', location: 'London', flag: 'uk.png'),
    WorldTime(subUrl: 'Europe/Berlin', location: 'Berlin', flag: 'germany.png'),
    WorldTime(subUrl: 'Europe/Athens', location: 'Athens', flag: 'greece.png'),
    WorldTime(subUrl: 'Africa/Cairo', location: 'Cairo', flag: 'egypt.png'),
    WorldTime(subUrl: 'Africa/Nairobi', location: 'Nairobi', flag: 'kenya.png'),
    WorldTime(subUrl: 'America/Chicago', location: 'Chicago', flag: 'usa.png'),
    WorldTime(subUrl: 'America/New_York', location: 'New York', flag: 'usa.png'),
    WorldTime(subUrl: 'Asia/Seoul', location: 'Seoul', flag: 'south_korea.png'),
    WorldTime(subUrl: 'Asia/Jakarta', location: 'Jakarta', flag: 'indonesia.png'),
  ];
void updateTime(index) async{
  WorldTime instance=locations[index];
  await instance.getTime();
  Navigator.pop(context, {'location':instance.location, 'flag':instance.flag,
    'time':instance.time, 'isDayTime':instance.isDayTime,'subUrl':instance.subUrl,
  });

}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: locations.length,
        itemBuilder: (context, index){
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 1.0),
          child: Card(
            child: ListTile(
              onTap: (){updateTime(index);},
              title: Text(locations[index].location),
              leading: CircleAvatar(
                backgroundImage: AssetImage('assets/${locations[index].flag}'),
              ),
            ),
          ),
        );
      },
      ),
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: Text('Choose Location'),
        centerTitle: true,
        elevation: 0,
      ),
    );
  }
}
