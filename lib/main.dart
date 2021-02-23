import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:thirty_days_flutter/Screen/add_contacts.dart';
import 'package:thirty_days_flutter/Screen/contacts.dart';

void main() {
  runApp(MaterialApp(
      home: MyApp()));
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Database',
      theme: ThemeData(
        primaryColor: Colors.deepPurple,
        accentColor: Colors.redAccent,

      ),
      home: AddContacts(),
    );
  }
}
