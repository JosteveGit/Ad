import 'package:ad/core/models/course_details.dart';
import 'package:ad/utils/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';

class SemesterGpaItem extends StatefulWidget {
  final int semesterNumber;
  final ValueChanged<double> onChanged;
  final double initialGpa;
  SemesterGpaItem({
    Key key,
    this.onChanged,
    this.semesterNumber,
    this.initialGpa,
  }) : super(key: key);

  @override
  _SemesterGpaItemState createState() => _SemesterGpaItemState();
}

class _SemesterGpaItemState extends State<SemesterGpaItem> {
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    controller.text = widget.initialGpa.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      elevation: 1,
      child: Container(
        color: Colors.white,
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            CustomTextField(
              textEditingController: controller,
              header: "GPA for semester ${widget.semesterNumber}",
              keyboardType: TextInputType.numberWithOptions(
                signed: false,
                decimal: true,
              ),
              onChanged: (v) {
                widget.onChanged(v.isEmpty ? 0.0 : double.parse(v));
              },
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
