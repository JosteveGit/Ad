import 'package:ad/core/models/course_details.dart';
import 'package:ad/pages/gpa_calculation/transcript_page.dart';
import 'package:ad/utils/navigation/navigator.dart';
import 'package:ad/utils/widgets/course_item.dart';
import 'package:ad/utils/widgets/custom_button.dart';
import 'package:ad/utils/widgets/s_back_button.dart';
import 'package:flutter/material.dart';

class GPACalculationPage extends StatefulWidget {
  const GPACalculationPage({Key key}) : super(key: key);

  @override
  _GPACalculationPageState createState() => _GPACalculationPageState();
}

class _GPACalculationPageState extends State<GPACalculationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomAppBar(),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      SBackButton(),
                      Spacer(),
                      GestureDetector(
                        onTap: () {
                          pushTo(context, TranscriptPage(courses: courses));
                        },
                        child: Container(
                          padding: EdgeInsets.all(10),
                          child: Icon(
                            Icons.calculate_rounded,
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
                  SizedBox(height: 10),
                  Text(
                    "Add Semester",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 24),
                  ),
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
                      child: CourseItem(
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
                          courses
                              .add(CourseDetails(code: "", unit: 1, grade: 5));
                        });
                      },
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: CustomButton(
                      text: "Save",
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<CourseDetails> courses = [CourseDetails(code: "", unit: 1, grade: 5)];
}
