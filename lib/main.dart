import 'package:flutter/material.dart';
import 'package:todo/screens/intro_screen.dart';
import 'package:todo/screens/todo_list_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Movies WishList',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: IntroOverboardPage(),
    );
  }
}
