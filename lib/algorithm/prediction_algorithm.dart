import 'dart:math';

import 'package:ad/core/models/course_details.dart';

class _Permutter {
  static List<List<String>> _comb = [];

  static void _getSequence(int index, List<String> arr, int n) {
    var len = arr.length;
    List<String> sequence = [];
    for (var i = 0; i < n; i++) {
      sequence.add(arr[index % len]);
      index ~/= len;
    }
    _comb.add(sequence);
  }

  static void permutation(List<String> arr, int n) {
    for (var i = 0; i < pow(arr.length, n); i++) {
      _getSequence(i, arr, n);
    }
  }

  static List<List<String>> permute(int numberOfCourses) {
    permutation(["a", "b", "c", "d", "f"], numberOfCourses);
    return _comb;
  }
}

class PredictionAlgorithm {
  static List<List<CourseDetails>> predict({
    List<CourseDetails> courses,
    List<double> previousSemesterGPA,
    double aimingCGPA,
  }) {
    List<List<CourseDetails>> coursesList = [];
    List<List<String>> permuationList = _Permutter.permute(courses.length);
    for (int k = 0; k < permuationList.length; k++) {
      List<String> element = permuationList[k];
      List<CourseDetails> gradedCourses = [];
      if (coursesList.length >= 20) {
        break;
      }
      for (var i = 0; i < element.length; i++) {
        CourseDetails course = CourseDetails(
          code: courses[i].code,
          unit: courses[i].unit,
        );
        course.grade = _convertGradeToNumber(element[i]);
        gradedCourses.add(course);
      }
      double gpa = double.parse(_calculateGPA(gradedCourses).toStringAsFixed(2));
      double summationOfPreviousGPAs =previousSemesterGPA.reduce((v, e) => v + e);
      double estimatedCGPA = (summationOfPreviousGPAs + gpa) / (previousSemesterGPA.length + 1);
      estimatedCGPA = double.parse(estimatedCGPA.toStringAsFixed(2));
      if (estimatedCGPA == aimingCGPA) {
        coursesList.add(gradedCourses);
      }
    }

    return coursesList.toList();
  }

  static double _calculateGPA(List<CourseDetails> courses) {
    int tc = 0;
    int twgp = 0;
    courses.forEach((e) {
      twgp += e.unit * e.grade;
      tc += e.unit;
    });
    return twgp / tc;
  }

  static int _convertGradeToNumber(String grade) {
    var grades = ["a", "b", "c", "d", "e", "f"];
    return 5 - grades.indexOf(grade.toLowerCase());
  }
}
