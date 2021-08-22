import 'dart:async';
import 'package:flutter/material.dart';

class CustomDropDownItem<T> {
  final T value;
  final String text;
  final Widget prefix;

  CustomDropDownItem({this.prefix, this.value, this.text});

  @override
  String toString() {
    return "CustomDropDownItem(value: $value, text: $text)";
  }
}

class CustomDropDown<T> extends StatefulWidget {
  final String header;
  final List<CustomDropDownItem<T>> items;
  final Function(T value) onSelected;
  final Widget suffix;
  final CustomDropDownItem intialValue;
  final double maxHeight;
  final bool defaultEmpty;

  const CustomDropDown({
    @required this.items,
    @required this.onSelected,
    @required this.header,
    @required this.intialValue,
    this.maxHeight,
    this.defaultEmpty = false,
    this.suffix,
  });

  @override
  _CustomDropDownState<T> createState() => _CustomDropDownState<T>();
}

class _CustomDropDownState<T> extends State<CustomDropDown<T>>
    with AutomaticKeepAliveClientMixin {
  bool expanded = false;
  List<CustomDropDownItem<T>> items = [];
  CustomDropDownItem<T> selectedItem;

  @override
  void initState() {
    initItems();
    Timer(
      Duration(milliseconds: 1),
      () {
        widget.onSelected(selectedItem.value);
      },
    );
    super.initState();
    if (widget.intialValue != null) {
      setState(() {
        selectedItem = widget.intialValue;

        expanded = false;

        widget.onSelected(selectedItem.value);
      });
    }
  }

  ScrollController controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    super.build(context);
    if (widget.items.toString() !=
        items.where((e) => e.value != null).toList().toString()) {
      initItems();
    }
    validateList();
    return IgnorePointer(
      ignoring: emptyList,
      child: GestureDetector(
        onTap: () {
          setState(() {
            expanded = !expanded;
            controller.animateTo(0,
                duration: Duration(milliseconds: 200), curve: Curves.ease);
          });
        },
        child: Stack(
          children: [
            AnimatedContainer(
              height: expanded
                  ? widget.maxHeight ?? (27.0 + (50.0 * (items.length)))
                  : 60,
              duration: Duration(milliseconds: 300),
              curve: Curves.fastOutSlowIn,
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 16),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey[200], width: 1.5),
                borderRadius: BorderRadius.circular(16),
              ),
              child: ListView(
                padding: EdgeInsets.zero,
                controller: controller,
                physics: widget.maxHeight != null
                    ? (expanded
                        ? BouncingScrollPhysics()
                        : NeverScrollableScrollPhysics())
                    : NeverScrollableScrollPhysics(),
                children: [
                  Row(
                    children: [
                      selectedItem.prefix ?? SizedBox(),
                      Expanded(
                        child: Text(
                          selectedItem.text,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(color: Colors.black, fontSize: 16),
                        ),
                      ),
                      widget.suffix ??
                          RotatedBox(
                            quarterTurns: expanded ? 2 : 0,
                            child: Icon(
                              Icons.keyboard_arrow_down,
                              color: Colors.black,
                            ),
                          )
                    ],
                  ),
                  SizedBox(height: 5),
                  Divider(),
                  SizedBox(height: 2),
                  ...items
                      .where((element) =>
                          selectedItem.value != element.value &&
                          element.value != null)
                      .map((e) {
                    return GestureDetector(
                      onTap: () async {
                        setState(() {
                          selectedItem = e;

                          controller.animateTo(
                            0,
                            duration: Duration(milliseconds: 200),
                            curve: Curves.ease,
                          );
                          expanded = false;

                          widget.onSelected(selectedItem.value);
                        });
                      },
                      child: Container(
                        height: 50,
                        color: Colors.white,
                        child: Row(
                          children: [
                            e.prefix ?? SizedBox(),
                            Expanded(
                              child: Text(
                                e.text,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList()
                ],
              ),
            ),
            Transform.translate(
              offset: Offset(15, -8),
              child: Container(
                color: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  "${widget.header}",
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool emptyList = false;

  void initItems() {
    items = widget.items;
    if (items.isEmpty) {
      setState(() {
        emptyList = true;
      });
      items.add(
        CustomDropDownItem(
          value: widget.intialValue.value,
          text: widget.intialValue.text ?? "Select",
        ),
      );
    } else {
      setState(() {
        emptyList = false;
      });
    }
    validateList();
    if (widget.defaultEmpty) {
      if (items.where((element) => element.value == null).length == 0) {
        setState(() {
          items.insert(0, CustomDropDownItem(value: null, text: ""));
        });
      }
    }
    selectedItem = items.first;
  }

  void validateList() {
    for (int i = 0; i < items.length; i++) {
      for (int j = i + 1; j < items.length; j++) {
        if (items[i].value.toString() == items[j].value.toString()) {
          throw Exception(
              "Duplicate values \'${items[i].value}\' at indices $i and $j");
        }
      }
    }
  }

  @override
  bool get wantKeepAlive => true;
}
