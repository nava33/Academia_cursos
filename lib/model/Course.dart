class CourseList {
  final List<Course> courses;

  CourseList({
    this.courses,
  });

  factory CourseList.fromJson(List<dynamic> parsedJson) {
    List<Course> courses = new List<Course>();
    courses = parsedJson.map((i) => Course.fromJson(i)).toList();

    return new CourseList(courses: courses);
  }
}

class Course {
  String instructor;
  String name;
  int numLessons;
  int curseDuration;
  String image;
  bool selected;
  Lesson lesson;

  Course({
    this.instructor,
    this.name,
    this.numLessons,
    this.curseDuration,
    this.image,
    this.selected,
    this.lesson,
  });

  factory Course.fromJson(Map<String, dynamic> json) => new Course(
        instructor: json["instructor"],
        name: json["name"],
        numLessons: json["numLessons"],
        curseDuration: json["curseDuration"],
        image: json["image"],
        selected: json["selected"],
        lesson: Lesson.fromJson(json["lesson"]),
      );

  Map<String, dynamic> toJson() => {
        "instructor": instructor,
        "name": name,
        "numLessons": numLessons,
        "curseDuration": curseDuration,
        "image": image,
        "selected": selected,
        "lesson": lesson.toJson(),
      };
}

class Lesson {
  List<String> names;
  int duration;

  Lesson({
    this.names,
    this.duration,
  });

  factory Lesson.fromJson(Map<String, dynamic> json) => new Lesson(
        names: new List<String>.from(json["names"].map((x) => x)),
        duration: json["duration"],
      );

  Map<String, dynamic> toJson() => {
        "names": new List<dynamic>.from(names.map((x) => x)),
        "duration": duration,
      };
}
