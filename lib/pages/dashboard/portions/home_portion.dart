import 'package:ad/pages/gpa_calculation/gpa_calculation_page.dart';
import 'package:ad/utils/navigation/navigator.dart';
import 'package:flutter/material.dart';

class HomePortion extends StatefulWidget {
  const HomePortion({Key key}) : super(key: key);

  @override
  _HomePortionState createState() => _HomePortionState();
}

class _HomePortionState extends State<HomePortion>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Good\nDay",
            style: TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: 35,
            ),
          ),
          SizedBox(height: 10),
          Expanded(
            child: PageView(
              controller: PageController(viewportFraction: 0.9),
              children: [
                GestureDetector(
                  onTap: (){
                    pushTo(context, GPACalculationPage());
                  },
                  child: Container(
                    color: Colors.white,
                    child: Center(
                      child: Text(
                        "Add Semester",
                      ),
                    ),
                  ),
                ),
                ...List.generate(
                  3,
                  (index) {
                    return Container(
                      margin: EdgeInsets.only(right: 10),
                      padding: EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Semester 1",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "4 courses",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            "20 units",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                          Spacer(),
                          Text(
                            "4.0",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      ),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Colors.blue, Colors.pink],
                        ),
                        borderRadius: BorderRadius.circular(16),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
