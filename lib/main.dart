import 'package:flutter/material.dart';
import 'package:tarea_cursos/screens/CoursesPage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GCoding Academy',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CoursesPage(),
    );
  }
}
