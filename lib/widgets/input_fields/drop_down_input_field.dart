import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import '../../../const_config/color_config.dart';
import '../../../const_config/text_config.dart';

class DropDownInputField extends StatefulWidget {
  final TextEditingController controller;
  final BorderRadius? borderRadius;
  final String fieldTitle;
  final String hintText;
  final bool needValidation;
  final String errorMessage;
  final TextInputAction? textInputAction;
  final String? suffixText;
  final Color? backgroundColor;
  final bool? needTitle;
  final bool? setInitialValue;
  final List<String> items;
  final TextStyle? textStyle;
  final TextStyle? textStyleInput;
  final EdgeInsets? padding;

  ///Common Error factor
  /// 1=> If item list contains duplicate values

  const DropDownInputField(
      {super.key,
      required this.controller,
      required this.hintText,
      required this.needValidation,
      required this.errorMessage,
      this.textInputAction,
      this.suffixText,
      this.backgroundColor,
      required this.fieldTitle,
      this.needTitle,
      required this.items,
      this.setInitialValue,
      this.textStyle,
      this.padding,
      this.borderRadius,
      this.textStyleInput});

  @override
  State<DropDownInputField> createState() => _DropDownInputFieldState();
}

class _DropDownInputFieldState extends State<DropDownInputField> {
  List<DropdownMenuItem<String>> itemsForList = [];

  @override
  void initState() {
    // TODO: implement initState
    if (widget.setInitialValue ?? false) {
      widget.controller.text = widget.items[0].toString();
    }

    itemsForList = widget.items
        .map((e) => DropdownMenuItem(
            value: e.toString(),
            child: Text(
              e,
              style: widget.textStyleInput ?? TextDesign().bodyTextSmall,
            )))
        .toList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.needTitle ?? true)
          Text(widget.fieldTitle,
              style: widget.textStyle ?? TextDesign().bodyTitle),
        if (widget.needTitle ?? true) const SizedBox(height: 5),
        DropdownButtonFormField2(
          items: itemsForList,
          style: widget.textStyleInput ?? TextDesign().bodyTextSmall,
          decoration: InputDecoration(
            errorStyle: TextDesign()
                .bodyTextExtraSmall
                .copyWith(fontSize: 11, color: MyColor.red),
            contentPadding: widget.padding ??
                (widget.controller.text.isNotEmpty
                    ? const EdgeInsets.only(
                        right: 10, left: 5, bottom: 18, top: 18)
                    : const EdgeInsets.only(
                        right: 10, left: 20, bottom: 18, top: 18)),
            hintText: widget.hintText,
            hintStyle: widget.textStyleInput ??
                TextDesign()
                    .bodyTextSmall
                    .copyWith(color: MyColor.textLightBlack),
            filled: true,
            fillColor: widget.backgroundColor ?? MyColor.white,
            suffixText:
                widget.suffixText != null ? widget.suffixText.toString() : "",
            suffixIcon: null,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: MyColor.red, width: 1.0),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide:
                  const BorderSide(color: MyColor.vdCharcoal, width: 1.0),
            ),
          ),
          value: (widget.setInitialValue ?? false) && widget.items.isNotEmpty
              ? widget.items[0]
              : null,
          onChanged: (value) {
            widget.controller.text = value.toString();
          },
          onSaved: (value) {
            widget.controller.text = value!.toString();
          },
          validator: (value) {
            if (!widget.needValidation) return null;
            if (value == null || value.toString().isEmpty) {
              return widget.errorMessage;
            }
            return null;
          },
          dropdownStyleData: DropdownStyleData(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: MyColor.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    spreadRadius: 1,
                    offset: const Offset(0, 3),
                    blurRadius: 13,
                  )
                ]),
          ),
        ),
      ],
    );
  }
}
