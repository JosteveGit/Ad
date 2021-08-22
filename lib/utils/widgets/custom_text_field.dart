import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatefulWidget {
  final String header;
  final String hint;
  final ValueChanged<String> onChanged;
  final ValueChanged<String> onSubmitted;
  final bool headerLess;
  final TextEditingController textEditingController;
  final int lines;
  final bool readOnly;
  final bool obscureText;
  final Widget prefix;
  final TextInputType keyboardType;
  final List<TextInputFormatter> inputFormatters;
  final FocusNode focusNode;
  final Widget suffix;
  final TextInputAction textInputAction;
  final Border border;
  final Color backgroundColor;

  const CustomTextField({
    Key key,
    this.header,
    this.hint,
    this.onChanged,
    this.headerLess = false,
    this.textEditingController,
    this.lines = 1,
    this.readOnly = false,
    this.obscureText = false,
    this.prefix,
    this.keyboardType,
    this.inputFormatters,
    this.focusNode,
    this.suffix,
    this.onSubmitted,
    this.textInputAction = TextInputAction.done,
    this.border,
    this.backgroundColor,
  }) : super(key: key);

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  void initState() {
    _node = widget.focusNode ?? FocusNode();
    super.initState();
  }

  FocusNode _node;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(_node);
        },
        child: Stack(
          children: [
            Container(
              child: Row(
                children: [
                  widget.prefix ?? SizedBox(width: 15),
                  Expanded(
                    child: Container(
                      child: TextField(
                        focusNode: _node,
                        cursorColor: Colors.blue,
                        readOnly: widget.readOnly,
                        onChanged: widget.onChanged,
                        textInputAction: widget.textInputAction,
                        obscureText: widget.obscureText,
                        keyboardType: widget.keyboardType,
                        controller: widget.textEditingController,
                        onSubmitted: widget.onSubmitted,
                        inputFormatters: widget.inputFormatters,
                        maxLines:
                            widget.obscureText ? 1 : (widget.lines ?? null),
                        minLines:
                            widget.obscureText ? 1 : (widget.lines ?? null),
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black
                        ),
                        decoration: InputDecoration.collapsed(
                          hintText: widget.hint ?? "",
                          hintStyle: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ),
                  ),
                  widget.suffix ?? SizedBox()
                ],
              ),
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 18),
              decoration: BoxDecoration(
                border: widget.border ??
                    Border.all(color: Colors.grey.withOpacity(0.2), width: 1.5),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            if (!widget.headerLess ?? false)
              Transform.translate(
                offset: Offset(15, -8),
                child: Container(
                  color: widget.backgroundColor ?? Colors.white,
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
}
