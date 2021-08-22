
import 'package:ad/utils/navigation/navigator.dart';
import 'package:flutter/material.dart';


class SBackButton extends StatelessWidget {
  final VoidCallback preferredBackAction;
  final Color color;
  final Color backgroundColor;
  final Border border;

  const SBackButton(
      {Key key,
      this.preferredBackAction,
      this.color,
      this.backgroundColor,
      this.border})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          color: backgroundColor ?? Colors.blue,
          border: border,
          shape: BoxShape.circle
        ),
        child: Icon(
          Icons.arrow_back_rounded,
          color: color ?? Colors.white,
          size: 20,
        ),
      ),
      onTap: preferredBackAction ??
          () {
            pop(context);
          },
    );
  }
}
