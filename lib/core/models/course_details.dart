class CourseDetails {
  int unit;
  int grade;
  String code;

  CourseDetails({this.unit, this.grade, this.code});

  @override
  String toString() {
    return "CourseDetails(unit: $unit, grade: $grade, code: $code)";
  }
}
