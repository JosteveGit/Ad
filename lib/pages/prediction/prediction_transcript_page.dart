import 'package:ad/core/models/course_details.dart';
import 'package:ad/utils/widgets/s_back_button.dart';
import 'package:flutter/material.dart';

class PredictionTranscriptPage extends StatefulWidget {
  final List<List<CourseDetails>> predictions;
  final double aimingCGPA;
  const PredictionTranscriptPage({Key key, this.predictions, this.aimingCGPA})
      : super(key: key);

  @override
  _PredictionTranscriptPageState createState() =>
      _PredictionTranscriptPageState();
}

class _PredictionTranscriptPageState extends State<PredictionTranscriptPage>
    with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    controller = TabController(length: widget.predictions.length, vsync: this);
  }

  List<CourseDetails> courses;

  TabController controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
                  fontSize: 30,
                ),
              ),
              SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Color(0xFF040415).withOpacity(0.1),
                ),
                child: Theme(
                  data: Theme.of(context).copyWith(
                    splashColor: Colors.white,
                    shadowColor: Colors.white,
                    highlightColor: Colors.white,
                  ),
                  child: TabBar(
                    controller: controller,
                    labelColor: Colors.blue,
                    unselectedLabelColor: Colors.black,
                    isScrollable: true,
                    tabs: List.generate(
                      widget.predictions.length,
                      (index) => Tab(
                        child: Text("Prediction ${index + 1}"),
                      ),
                    ),
                    indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(90),
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Expanded(
                child: TabBarView(
                  controller: controller,
                  children: List.generate(
                    widget.predictions.length,
                    (index) {
                      List<CourseDetails> courses = widget.predictions[index];
                      List gpaStuff = _calculateGPA(courses);
                      double gpa = gpaStuff.first;
                      int tc = gpaStuff[1];
                      int twgp = gpaStuff.last;
                      return Container(
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "Code",
                                    style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    "Unit",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    "Grade",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Expanded(
                              child: ListView(
                                children: List.generate(
                                  courses.length,
                                  (index) {
                                    CourseDetails courseDetails =
                                        courses[index];
                                    return Container(
                                      margin: EdgeInsets.only(bottom: 10),
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
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
                      );
                    },
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

  static List _calculateGPA(List<CourseDetails> courses) {
    int tc = 0;
    int twgp = 0;
    courses.forEach((e) {
      twgp += e.unit * e.grade;
      tc += e.unit;
    });
    return [twgp / tc, tc, twgp];
  }
}
