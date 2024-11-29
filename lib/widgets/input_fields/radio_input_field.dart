import 'package:flutter/material.dart';
import '../../../const_config/color_config.dart';
import '../../../const_config/text_config.dart';

class RadioInputField extends StatefulWidget {
  ///Maximum input length is 3 items
  final Color? color;

  final List<String> items;
  final TextEditingController controller;
  const RadioInputField({
    super.key,
    required this.items,
    required this.controller,
    this.color,
  });

  @override
  State<RadioInputField> createState() => _RadioInputFieldState();
}

class _RadioInputFieldState extends State<RadioInputField> {
  void onClick(String titleName) {
    setState(() {
      widget.controller.text = titleName;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    widget.controller.text = widget.items.first.toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: widget.items
          .map((tileIdentifier) => RadioButtonModified(
                controller: widget.controller,
                tileName: tileIdentifier,
                maxLength: widget.items.length,
                index: widget.items.indexOf(tileIdentifier),
                onClick: onClick,
                color: widget.color,
              ))
          .toList(),
    );
  }
}

class RadioButtonModified extends StatefulWidget {
  final Color? color;
  final TextEditingController controller;
  final String tileName;
  final int maxLength;
  final int index;
  final Function onClick;
  const RadioButtonModified(
      {super.key,
      required this.controller,
      required this.tileName,
      required this.maxLength,
      required this.index,
      required this.onClick,
      this.color});

  @override
  State<RadioButtonModified> createState() => _RadioButtonModifiedState();
}

class _RadioButtonModifiedState extends State<RadioButtonModified> {
  final stateController = WidgetStatesController();
  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Padding(
        padding: (widget.maxLength == widget.index)
            ? const EdgeInsets.only(right: 0)
            : const EdgeInsets.only(right: 5),
        child: Material(
          color: widget.color ?? MyColor.scaffoldColor,
          borderRadius: BorderRadius.circular(10),
          child: RadioMenuButton(
            value: widget.tileName.toString(),
            toggleable: true,
            groupValue: widget.controller.text.toString(),
            statesController: stateController,
            onChanged: (value) {
              if (widget.tileName.toString().contains(value.toString())) {
                widget.onClick(value);
              }
            },
            child: Text(widget.tileName,
                style: TextDesign().bodySubText,
                overflow: TextOverflow.ellipsis),
          ),
        ),
      ),
    );
  }
}
