import 'package:flutter/material.dart';
import 'package:tarea_cursos/model/Course.dart';

class DetailsPage extends StatefulWidget {
  final Course course;

  DetailsPage(this.course);

  @override
  State<StatefulWidget> createState() => DetailsPageState(course);
}

class DetailsPageState extends State<DetailsPage> {
  final Course course;

  DetailsPageState(this.course);

  Color _changeColor(String courseName) {
    //Retornará un color de AppBar e iconos según el curso
    if (courseName == 'Flutter') {
      return Colors.blue;
    } else if (courseName == 'Firebase') {
      return Colors.orange[500];
    } else if (courseName == 'Dart') {
      return Colors.indigo;
    } else {
      return Colors.lightBlueAccent;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Curso ${course.name}'),
        backgroundColor: _changeColor(course.name),
        actions: <Widget>[
          FlatButton(
            child: Text(
              'Suscribir',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {},
          )
        ],
      ),
      body: Center(
        child: ListView.builder(
          itemCount: course.lesson.names.length,
          itemBuilder: (BuildContext context, int index) {
            return LessonWidget(course, index, _changeColor);
          },
        ),
      ),
    );
  }
}

typedef ChangeColorCallback = Color Function(String courseName);

class LessonWidget extends StatelessWidget {
  final Course course;
  final int index;
  final ChangeColorCallback changeColorCallback;

  LessonWidget(this.course, this.index, this.changeColorCallback);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(top: 10, left: 10, right: 10),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    course.lesson.names[index],
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text('${course.lesson.duration} minutos'),
                ],
              ),
            ),
            Icon(
              Icons.videocam,
              size: 50,
              color: changeColorCallback(course.name),
            )
          ],
        ),
      ),
    );
  }
}
