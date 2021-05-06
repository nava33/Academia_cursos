import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:tarea_cursos/model/Course.dart';
import 'dart:async' show Future;
import 'package:tarea_cursos/screens/DetailsPage.dart';

class CoursesPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => CoursesPageState();
}

class CoursesPageState extends State<CoursesPage> {
  Course course;
  List<bool> _selectedList;

  void _onValueChanged(bool value, int index) {
    setState(() {
      _selectedList[index] = value;
    });
  }

  Future<String> _loadCourseAsset() async {
    return rootBundle.loadString('assets/json/courses.json');
  }

  Future<CourseList> _loadCourse() async {
    String jsonString = await _loadCourseAsset();
    final jsonResponse = json.decode(jsonString);
    final course = CourseList.fromJson(jsonResponse);
    return course;
  }

  void initState() {
    _loadCourse().then((value) {
      _selectedList = List.generate(
          value.courses.length,
          (index) => value.courses[index]
              .selected); //Genera una lista con los valores de inicio para los checkbox de cada curso
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nuestros cursos'),
      ),
      body: Center(
        child: FutureBuilder<CourseList>(
            future: _loadCourse(),
            builder: (BuildContext context, snapshot) {
              if (snapshot.hasData) {
                final list = snapshot.data;
                return ListView.builder(
                  itemCount: list.courses.length,
                  itemBuilder: (BuildContext context, int index) {
                    final course = list.courses[index];
                    return CourseWidget(
                        course, _selectedList, index, _onValueChanged);
                  },
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            }),
      ),
    );
  }
}

typedef OnPressCallback = void Function(bool value, int index);

class CourseWidget extends StatelessWidget {
  final Course course;
  final List<bool> selectedList;
  final int index;
  final OnPressCallback onPressCallback;

  CourseWidget(
      this.course, this.selectedList, this.index, this.onPressCallback);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _showCourse(context);
      },
      child: Card(
        margin: EdgeInsets.only(top: 10, left: 10, right: 10),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: <Widget>[
              Image.asset(
                course.image,
                width: 100,
                height: 100,
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('por ${course.instructor}'),
                    Text('Curso: ${course.name}'),
                    Row(
                      children: <Widget>[
                        Text('${course.numLessons} Lecciones'),
                        SizedBox(
                          width: 5,
                        ),
                        Text('Aprox.: ${course.curseDuration}hrs')
                      ],
                    )
                  ],
                ),
              ),
              Checkbox(
                value: selectedList[index],
                onChanged: (bool value) {
                  onPressCallback(value, index);
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  _showCourse(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (BuildContext context) => DetailsPage(course)));
  }
}
