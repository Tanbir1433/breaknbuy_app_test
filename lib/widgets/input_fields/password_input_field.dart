import 'package:flutter/material.dart';
import '../../../const_config/color_config.dart';
import '../../../const_config/text_config.dart';
import '../../Utils/validators.dart';

class PasswordInputField extends StatefulWidget {
  final TextEditingController password;
  final String fieldTitle;
  final String hintText;
  final Color? backgroundColor;
  final TextInputAction? textInputAction;
  const PasswordInputField({
    super.key,
    required this.password,
    required this.fieldTitle,
    required this.hintText,
    this.textInputAction,
    this.backgroundColor,
  });

  @override
  State<PasswordInputField> createState() => _PasswordInputFieldState();
}

class _PasswordInputFieldState extends State<PasswordInputField> {
  bool hidePassword = true;
  bool hasSomePassword = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.fieldTitle, style: TextDesign().bodyTitle),
        const SizedBox(height: 5),
        TextFormField(
          cursorColor: MyColor.mtMainGreen,
          autofocus: false,
          obscureText: hidePassword,
          controller: widget.password,
          style: TextDesign().bodyTextSmall,
          onSaved: (value) {
            widget.password.text = value!;
          },
          onChanged: (value) {
            if (widget.password.text.isNotEmpty) {
              setState(() {
                hasSomePassword = true;
              });
            } else {
              setState(() {
                hasSomePassword = false;
              });
            }
          },
          autofillHints: widget.hintText == 'Enter password'
              ? [AutofillHints.password]
              : null,
          textInputAction: widget.textInputAction ?? TextInputAction.done,
          validator: ValidatorClass().validatePassword,
          decoration: InputDecoration(
            focusColor: MyColor.mtMainGreen,
            filled: true,
            fillColor: widget.backgroundColor ?? MyColor.mtSubGreen,
            suffixIcon: hasSomePassword
                ? IconButton(
              onPressed: () {
                setState(() {
                  hidePassword = !hidePassword;
                });
              },
              icon: const Icon(Icons.visibility),
            )
                : null,
            contentPadding:
            const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
            hintText: widget.hintText,
            hintStyle: TextDesign()
                .bodyTextSmall
                .copyWith(color: MyColor.textLightBlack),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: const BorderSide(
                  color: MyColor.bnbGrey,
                  width: 1,
                )),
            // focusedBorder: OutlineInputBorder(
            //   borderRadius: BorderRadius.circular(5),
            //   borderSide: const BorderSide(
            //     color:MyColor.bnbGrey,
            //     width: 1,
            //   ),
            // ),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: const BorderSide(
                  color: MyColor.bnbGrey,
                  width: 1,
                )),
          ),
        ),
      ],
    );
  }
}
