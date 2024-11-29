
import 'package:flutter/material.dart';

import '../../../const_config/color_config.dart';
import '../../../const_config/text_config.dart';
import '../../Utils/validators.dart';


class SimpleInputField extends StatefulWidget {

  final EdgeInsets? padding;
  final TextStyle? textStyle;
  final TextEditingController controller;
  final String fieldTitle;
  final String hintText;
  final bool needValidation;
  final String errorMessage;
  final TextInputAction? textInputAction;
  final TextInputType? inputType;
  final String? suffixText;
  final Color? backgroundColor;
  final bool? viewOnly;
  final bool? needTitle;
  final FormFieldValidator<String>? validatorClass;
  const SimpleInputField({super.key, required this.controller, required this.hintText, required this.needValidation, required this.errorMessage, this.textInputAction, this.inputType, this.suffixText, this.backgroundColor, this.viewOnly, required this.fieldTitle, this.validatorClass, this.needTitle, this.padding, this.textStyle, });

  @override
  State<SimpleInputField> createState() => _SimpleInputFieldState();
}

class _SimpleInputFieldState extends State<SimpleInputField> {
  @override
  Widget build(BuildContext context) {

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if(widget.needTitle ?? true)
          Text(widget.fieldTitle ,style: widget.textStyle?? TextDesign().bodyTitle),
        if(widget.needTitle ?? true)
          const SizedBox(height: 5),
        TextFormField(
          controller: widget.controller,
          keyboardType: widget.inputType ?? TextInputType.text,
          style:  TextDesign().bodyTextSmall,
          cursorColor: MyColor.bnbSpaceBlue,
          readOnly: widget.viewOnly ?? false,
          decoration: InputDecoration(

            errorStyle: TextDesign().bodyTextExtraSmall.copyWith(fontSize: 11 ,color: MyColor.red),
            contentPadding: widget.padding?? const EdgeInsets.symmetric( horizontal: 20,vertical: 20),
            //label: FocusScope.of(context).focusedChild != null ? Text(widget.hintText) : null,
            hintText: widget.hintText,
            hintStyle: TextDesign().bodyTextSmall.copyWith(color: MyColor.textLightBlack),
            filled: true,

            fillColor: widget.backgroundColor ?? MyColor.white,
            suffixText: widget.suffixText != null ? widget.suffixText.toString() : "",
            suffixIcon: null,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: const BorderSide(
                  color: MyColor.bnbGrey,
                  width: 1,
                ),
            ),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: const BorderSide(
                  color: MyColor.bnbGrey,
                  width: 1,
                ),
            ),
          ),
          textInputAction: widget.textInputAction ?? TextInputAction.next,
          onFieldSubmitted: (value){
            widget.controller.text = value;
          },
          onSaved: (value){
            widget.controller.text = value!;
          },
          validator: widget.validatorClass ?? ValidatorClass().noValidationRequired ,

          ///=== new added==

          autofillHints: widget.hintText == 'Enter email'
              ? [AutofillHints.username]
              : null,


        ),
      ],
    );
  }
}
