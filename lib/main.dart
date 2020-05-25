import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'model.dart';
import 'views/add_event.dart';
import 'views/home.dart';

void main() {
  Provider.debugCheckInvalidValueType = null;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (BuildContext context) => Events(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primaryColor: Color(0xff2196f3),
          primaryColorLight: Color(0xffbbdefb),
          primaryColorDark: Color(0xff1976d2),
          accentColor: Color(0xffffc107),
        ),
        routes: {
          '/': (context) => Home(),
          '/add': (context) => AddEvent(),
        },
      ),
    );
  }
}
