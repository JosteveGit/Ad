import 'package:flutter/material.dart';

import 'portions/home_portion.dart';
import 'portions/new_home_portion.dart';
import 'portions/new_predict_portion.dart';
import 'portions/predict_portion.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key key}) : super(key: key);

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  PageController controller = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: PageView(
          controller: controller,
          physics: NeverScrollableScrollPhysics(),
          children: [
            NewHomePortion(),
            NewPredictPortion()
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
          controller.jumpToPage(index);
        },
        currentIndex: currentIndex,
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.w600),
        unselectedLabelStyle: TextStyle(fontWeight: FontWeight.w600),
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.calculate_rounded),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.batch_prediction_rounded),
            label: "Predict",
          ),
        ],
      ),
    );
  }

  int currentIndex = 0;
}
