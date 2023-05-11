import 'package:barber_app/core.dart';
import 'package:flutter/material.dart';

enum TextFieldType {
  normal,
  password,
}

Map<String, TextEditingController> textFieldController = {};

class ExTextField extends StatefulWidget {
  final String id;
  final String label;
  final String? value;
  final String hintText;
  final TextFieldType textFieldType;
  final int? maxLines;
  final bool? enabled;

  final Function(String text)? onChanged;
  final Function(String text)? onSubmitted;

  ExTextField({
    required this.id,
    required this.label,
    this.value = "",
    this.hintText = "",
    this.textFieldType = TextFieldType.normal,
    this.onChanged,
    this.onSubmitted,
    this.maxLines = 1,
    this.enabled = true,
  });

  @override
  _ExTextFieldState createState() => _ExTextFieldState();
}

class _ExTextFieldState extends State<ExTextField>
    implements InputControlState {
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    controller.text = widget.value ?? "";
    textFieldController[widget.id] = controller;
    Input.set(widget.id, widget.value);
    Input.inputController[widget.id] = this;
  }

  setValue(value) {
    controller.text = value;
    Input.set(widget.id, value);
  }

  resetValue() {
    controller.text = "";
    Input.set(widget.id, "");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
          // color: Colors.white,
          ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(
              left: 4.0,
              right: 4.0,
              top: 4.0,
              bottom: 4.0,
            ),
            child: Text(widget.label),
          ),
          SizedBox(
            height: 4.0,
          ),
          Container(
            padding: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              border: Border.all(
                width: 1.0,
                color: Colors.grey[300]!,
              ),
              borderRadius: BorderRadius.all(Radius.circular(4.0)),
            ),
            child: TextField(
              controller: controller,
              maxLines: widget.textFieldType == TextFieldType.password
                  ? 1
                  : widget.maxLines,
              obscureText:
                  widget.textFieldType == TextFieldType.password ? true : false,
              readOnly: widget.enabled! ? false : true,
              decoration: InputDecoration.collapsed(
                hintText: widget.hintText,
              ),
              onChanged: (text) {
                Input.set(widget.id, text);
                if (widget.onChanged != null) return widget.onChanged!(text);
              },
              onSubmitted: (text) {
                Input.set(widget.id, text);
                if (widget.onSubmitted != null)
                  return widget.onSubmitted!(text);
              },
            ),
          ),
        ],
      ),
    );
  }
}
