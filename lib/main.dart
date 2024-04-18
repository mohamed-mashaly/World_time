import 'dart:js';

import 'package:flutter/material.dart';
import 'package:world_time/Pages/choose.dart';
import 'package:world_time/Pages/home.dart';
import 'package:world_time/Pages/loading.dart';

void main() {
  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/':(context) => Loading(),
      '/home':(context) => Home(),
      '/Location':(context)=> ChooseLocation(),
    },
  ));
}
