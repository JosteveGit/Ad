import 'package:ad/core/models/course_details.dart';
import 'package:ad/utils/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';

import 'custom_drop_down.dart';

class CourseItem extends StatefulWidget {
  final CourseDetails courseDetails;
  final ValueChanged<CourseDetails> onChanged;
  CourseItem({
    Key key,
    this.onChanged,
    this.courseDetails,
  }) : super(key: key);

  @override
  _CourseItemState createState() => _CourseItemState();
}

class _CourseItemState extends State<CourseItem> {
  final List<String> units = List.generate(7, (index) => "${index + 1}");

  final List<String> grades = ["A", "B", "C", "D", "E", "F"];

  bool init = true;

  @override
  void initState() {
    super.initState();
    courseDetails = widget.courseDetails;
    controller.text = courseDetails.code;
  }

  TextEditingController controller = TextEditingController();

  CourseDetails courseDetails;

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
              header: "Course code",
              onChanged: (v) {
                courseDetails.code = v;
                onChanged();
              },
            ),
            SizedBox(height: 20),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: CustomDropDown<String>(
                    onSelected: (v) {
                      courseDetails.unit = int.parse(v);
                      onChanged();
                    },
                    header: "Unit",
                    intialValue: CustomDropDownItem<String>(
                      value: widget.courseDetails.unit.toString(),
                      text: widget.courseDetails.unit.toString(),
                    ),
                    items: units
                        .map((e) => CustomDropDownItem(value: e, text: e))
                        .toList(),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: CustomDropDown<String>(
                    onSelected: (v) {
                      courseDetails.grade = 5 - grades.indexOf(v);
                      onChanged();
                    },
                    header: "Grade",
                    intialValue: CustomDropDownItem<String>(
                      value: grades[5 - widget.courseDetails.grade],
                      text: grades[5 - widget.courseDetails.grade],
                    ),
                    items: grades
                        .map((e) => CustomDropDownItem(value: e, text: e))
                        .toList(),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  void onChanged() {
    widget.onChanged(courseDetails);
  }
}
