import 'package:ad/utils/widgets/custom_button.dart';
import 'package:ad/utils/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';

class PredictPortion extends StatefulWidget {
  const PredictPortion({Key key}) : super(key: key);

  @override
  _PredictPortionState createState() => _PredictPortionState();
}

class _PredictPortionState extends State<PredictPortion> {
  @override
  Widget build(BuildContext context) {
    return Container(
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
            header: "What's your current CGPA?",
            onChanged: (v) {
              setState(() {
                currentGpa = v.isEmpty ? 0 : double.parse(v);
              });
            },
          ),
          SizedBox(height: 17),
          CustomTextField(
            header: "Average number of unit per semester",
            onChanged: (v) {
              setState(() {
                averageNumberOfUnitPerSemester = v.isEmpty ? 0 : int.parse(v);
              });
            },
          ),
          SizedBox(height: 17),
          CustomTextField(
            header: "Number of semesters left",
            keyboardType: TextInputType.number,
            onChanged: (v) {
              setState(() {
                numberOfSemestersLeft = v.isEmpty ? 0 : int.parse(v);
              });
            },
          ),
          SizedBox(height: 17),
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
          CustomButton(
            expanded: true,
            text: "Predict",
            validator: () =>
                currentGpa != 0 &&
                numberOfSemestersLeft != 0 &&
                averageNumberOfUnitPerSemester != 0 &&
                aimingCgpa != 0,
            onPressed: () {
              predict(
                k: currentGpa,
                d: aimingCgpa,
                f: averageNumberOfUnitPerSemester,
                m: numberOfSemestersLeft + 1,
              );
            },
          ),
        ],
      ),
    );
  }

  double currentGpa = 0.0;
  int numberOfSemestersLeft = 0;
  int averageNumberOfUnitPerSemester = 0;
  double aimingCgpa = 0.0;

  void predict({
    double k,
    double d,
    int m,
    int f,
  }) {
    int n = m - 1;
    double b_7 = ((m * d) - k);
    double a = (b_7 * f) / n;
    double b = a / f;
    if (b > 5 || b < 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("It's not possible, my dear"),
          backgroundColor: Colors.red,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              "You need a minimum of ${b.toStringAsFixed(2)} GPA for the next $n semesters"),
          backgroundColor: Colors.green,
        ),
      );
    }
  }
}
