import 'dart:developer' as developer;
import 'package:flutter/material.dart';
import 'package:flutter_application/pages/list_patient_page.dart';
import 'themes.dart';
class Application extends StatefulWidget {
  static const ROUTE_NAME = 'Application';
  @override
  _ApplicationState createState() => _ApplicationState();
}

class _ApplicationState extends State<Application> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  static const TAG = 'Application';
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: light(context),
      darkTheme: dark(context),
      // navigatorKey: _navigatorKey,
      // initialRoute: Application.ROUTE_NAME,
      // builder: (context, child) {
      //   return Container(
      //     child: TextButton(
      //       child: Text('GO TO PATIENT'),
      //       onPressed: () =>
      //           // _navigatorKey.currentState!.pushNamed(ListPatientPage.ROUTE_NAME),
      //       Navigator.pushNamed(context, ListPatientPage.ROUTE_NAME)
      //     ),
      //   );
      // },
      home: ListPatientPage(),
    );
  }
}