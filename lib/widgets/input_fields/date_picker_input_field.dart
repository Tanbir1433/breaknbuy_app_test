import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import '../../const_config/color_config.dart';
import '../../const_config/text_config.dart';

class DatePickerInputField extends StatefulWidget {
  final String fieldTitle;
  final String hint;
  final TextStyle? textStyle;
  final TextEditingController dateController;

  const DatePickerInputField(
      {super.key,
      required this.dateController,
      required this.fieldTitle,
      this.textStyle,
      required this.hint});

  @override
  State<DatePickerInputField> createState() => _DatePickerInputFieldState();
}

class _DatePickerInputFieldState extends State<DatePickerInputField> {
  List<DateTime?> _singleDatePickerValueWithDefaultValue = [
    DateTime.now(),
  ];
  @override
  void initState() {
    widget.dateController.text =
        DateFormat('dd MMM yyy').format(DateTime.now());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.fieldTitle,
            style: widget.textStyle ?? TextDesign().bodyTitle),
        const SizedBox(
          height: 5,
        ),
        Material(
          color: MyColor.white,
          clipBehavior: Clip.hardEdge,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: const BorderSide(width: 2, color: MyColor.vdCharcoal)),
          child: InkWell(
            onTap: () {
              /// popup ===============
              showDialog(
                context: context,
                useSafeArea: true,
                builder: (BuildContext context) {
                  return Dialog(
                    child: Material(
                      color: MyColor.white,
                      clipBehavior: Clip.hardEdge,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: const BorderSide(
                              width: 1, color: MyColor.vdCharcoal)),
                      child: SizedBox(
                        width: size.width > 600 ? size.width * .55 : size.width,
                        child: CalendarDatePicker2(
                          config: CalendarDatePicker2Config(
                            selectedDayHighlightColor: MyColor.red,
                          ),
                          value: _singleDatePickerValueWithDefaultValue,
                          onValueChanged: (dates) {
                            _singleDatePickerValueWithDefaultValue = dates;

                            setState(() {
                              widget.dateController.text =
                                  DateFormat('dd MMM yyyy')
                                      .format(dates[0]);
                              Navigator.pop(context);
                            });

                            //print( DateFormat('MMMM dd, yyyy').format(dates[0] as DateTime));
                          },
                        ),
                      ),
                    ),
                  );
                },
              );
            },
            child: SizedBox(
                width: size.width * .55,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 17),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.dateController.text.isNotEmpty
                            ? widget.dateController.text
                            : widget.hint,
                        style: TextDesign().bodyTextSmall,
                      ),
                      const Icon(
                        FontAwesomeIcons.calendarDay,
                        color: MyColor.vdCharcoal,
                        size: 15,
                      )
                    ],
                  ),
                )),
          ),
        ),
      ],
    );
  }
}
