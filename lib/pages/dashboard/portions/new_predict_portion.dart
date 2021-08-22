import 'package:ad/pages/prediction/enter_current_semester_details.dart';
import 'package:ad/utils/navigation/navigator.dart';
import 'package:ad/utils/widgets/custom_button.dart';
import 'package:ad/utils/widgets/custom_text_field.dart';
import 'package:ad/utils/widgets/semester_gpa_item.dart';
import 'package:flutter/material.dart';

class NewPredictPortion extends StatefulWidget {
  const NewPredictPortion({Key key}) : super(key: key);

  @override
  _NewPredictPortionState createState() => _NewPredictPortionState();
}

class _NewPredictPortionState extends State<NewPredictPortion>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Predict",
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 35,
                    ),
                  ),
                  Text("Some random information will be here"),
                  SizedBox(height: 30),
                  CustomTextField(
                    header: "Aiming CGPA",
                    keyboardType: TextInputType.number,
                    onChanged: (v) {
                      setState(() {
                        aimingCgpa = v.isEmpty ? 0 : double.parse(v);
                      });
                    },
                  ),
                  SizedBox(height: 17),
                  Container(
                    height: 2,
                    color: Colors.grey[200],
                  ),
                  SizedBox(height: 20),
                  Expanded(
                    child: Container(
                      child: ListView(
                        children: List.generate(
                          semestersGpa.length,
                          (index) {
                            return Dismissible(
                              key: UniqueKey(),
                              onDismissed: (_) {
                                setState(() {
                                  semestersGpa.removeAt(index);
                                });
                              },
                              child: Container(
                                margin: EdgeInsets.only(bottom: 20),
                                child: SemesterGpaItem(
                                  initialGpa: semestersGpa[index],
                                  semesterNumber: index + 1,
                                  onChanged: (v) {
                                    semestersGpa[index] = v;
                                  },
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
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
                    text: "Add Semester",
                    onPressed: () {
                      setState(() {
                        semestersGpa.add(0.0);
                      });
                    },
                  ),
                ),
                SizedBox(width: 5),
                Expanded(
                  child: CustomButton(
                    text: "Proceed",
                    onPressed: () {
                      pushTo(
                        context,
                        EnterCurrentSemesterDetailsPage(
                          semestersGPA: semestersGpa,
                          aimingCGPA: aimingCgpa,
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<double> semestersGpa = [];
  double aimingCgpa = 0.0;
  double currentGpa = 0.0;

  @override
  bool get wantKeepAlive => true;
}
