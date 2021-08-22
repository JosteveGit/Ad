import 'package:ad/algorithm/prediction_algorithm.dart';
import 'package:ad/core/models/course_details.dart';
import 'package:ad/pages/gpa_calculation/transcript_page.dart';
import 'package:ad/utils/functions/dialog_utils.dart';
import 'package:ad/utils/navigation/navigator.dart';
import 'package:ad/utils/widgets/course_item_without_grade.dart';
import 'package:ad/utils/widgets/custom_button.dart';
import 'package:ad/utils/widgets/s_back_button.dart';
import 'package:flutter/material.dart';

import 'prediction_transcript_page.dart';

class EnterCurrentSemesterDetailsPage extends StatefulWidget {
  final List<double> semestersGPA;
  final double aimingCGPA;
  const EnterCurrentSemesterDetailsPage(
      {Key key, this.semestersGPA, this.aimingCGPA})
      : super(key: key);

  @override
  _EnterCurrentSemesterDetailsPageState createState() =>
      _EnterCurrentSemesterDetailsPageState();
}

class _EnterCurrentSemesterDetailsPageState
    extends State<EnterCurrentSemesterDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SBackButton(),
                    SizedBox(height: 20),
                    Text(
                      "Current Semester",
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 35,
                      ),
                    ),
                    Text("Enter your current semester details"),
                    SizedBox(height: 20),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return Dismissible(
                      key: UniqueKey(),
                      onDismissed: (direction) {
                        setState(() {
                          courses.removeAt(index);
                        });
                      },
                      child: Container(
                        child: CourseItemWithoutGrade(
                          courseDetails: courses[index],
                          onChanged: (editedCoureDetails) {
                            courses[index] = editedCoureDetails;
                          },
                        ),
                        margin: EdgeInsets.only(bottom: 15),
                      ),
                    );
                  },
                  itemCount: courses.length,
                ),
              ),
              Container(
                height: 2,
                color: Colors.grey[200],
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: Row(
                  children: [
                    Expanded(
                      child: CustomButton(
                        text: "Add Course",
                        onPressed: () {
                          setState(() {
                            courses.add(CourseDetails(code: "", unit: 1));
                          });
                        },
                      ),
                    ),
                    SizedBox(width: 10),
                    GestureDetector(
                      onTap: () {
                        performPrediction();
                      },
                      child: Container(
                        padding: EdgeInsets.all(10),
                        child: Icon(
                          Icons.batch_prediction_rounded,
                          color: Colors.white,
                          size: 20,
                        ),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.blue,
                          border: Border.all(
                            color: Colors.blue[200],
                            width: 5,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void performPrediction() {
    showLoader(context);
    List<List<CourseDetails>> predictions = PredictionAlgorithm.predict(
      courses: courses,
      aimingCGPA: widget.aimingCGPA,
      previousSemesterGPA: widget.semestersGPA,
    );
    pop(context);
    pushTo(
      context,
      PredictionTranscriptPage(
        predictions: predictions,
        aimingCGPA: widget.aimingCGPA,
      ),
    );
  }

  List<CourseDetails> courses = [CourseDetails(code: "", unit: 1)];
}
