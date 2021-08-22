import 'package:ad/core/models/course_details.dart';
import 'package:ad/utils/widgets/s_back_button.dart';
import 'package:flutter/material.dart';

class TranscriptPage extends StatefulWidget {
  final List<CourseDetails> courses;
  const TranscriptPage({Key key, this.courses}) : super(key: key);

  @override
  _TranscriptPageState createState() => _TranscriptPageState();
}

class _TranscriptPageState extends State<TranscriptPage> {
  @override
  void initState() {
    courses = widget.courses;
    calculateGPA();
    super.initState();
  }

  List<CourseDetails> courses;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SBackButton(),
              SizedBox(height: 10),
              Text(
                "Transcript",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 24,
                ),
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "Code",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      "Unit",
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      "Grade",
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: ListView(
                  children: List.generate(
                    courses.length,
                    (index) {
                      CourseDetails courseDetails = courses[index];
                      return Container(
                        margin: EdgeInsets.only(bottom: 5),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                courseDetails.code,
                                style: TextStyle(),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                courseDetails.unit.toString(),
                                textAlign: TextAlign.center,
                                style: TextStyle(),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                grades[5 - courseDetails.grade],
                                textAlign: TextAlign.center,
                                style: TextStyle(),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
              Divider(),
              Container(
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "GPA",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        gpa.toStringAsFixed(2),
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            children: [
                              Text(
                                "TC",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                tc.toString(),
                                style: TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Text(
                                "TWGP",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                twgp.toString(),
                                style: TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Text(
                                "NC",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                courses.length.toString(),
                                style: TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  final List<String> grades = ["A", "B", "C", "D", "E", "F"];

  int tc = 0;
  int twgp = 0;
  double gpa = 0;

  void calculateGPA() {
    tc = 0;
    twgp = 0;
    courses.forEach((e) {
      twgp += e.unit * e.grade;
      tc += e.unit;
    });
    setState(() {
      gpa = twgp / tc;
    });
  }
}
