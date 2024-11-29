import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';


import '../../const_config/color_config.dart';
import '../../const_config/text_config.dart';
import '../buttons/simple_icon_button.dart';

class DateRangePicker extends StatefulWidget {
  final String hint;
  final TextEditingController startDateController;
  final TextEditingController endDateController;

  const DateRangePicker(
      {super.key,
      required this.startDateController,
      required this.endDateController,
      required this.hint});

  @override
  State<DateRangePicker> createState() => _DateRangePickerState();
}

class _DateRangePickerState extends State<DateRangePicker> {
  DateTime selectedDate = DateTime.now();
  DateTimeRange selectedDates = DateTimeRange(
    start: DateTime.now(),
    end: DateTime.now(),
  );

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Flexible(
      child: Padding(
        padding: const EdgeInsets.only(left: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Flexible(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Start Date", style: TextDesign().bodyTitle),
                  const SizedBox(
                    height: 5,
                  ),
                  Material(
                    color: MyColor.mtSubGreen,
                    clipBehavior: Clip.hardEdge,
                    borderRadius: BorderRadius.circular(10),
                    child: InkWell(
                      onTap: () async {
                        //  pop up
                        final DateTimeRange? dateTimeRange =
                            await showDateRangePicker(
                          context: context,
                          firstDate: DateTime(2010),
                          lastDate: DateTime(2200),
                          confirmText: "Select",
                          builder: (context, child) {
                            //color changed here
                            return Theme(
                              data: Theme.of(context).copyWith(
                                colorScheme: const ColorScheme.light(
                                  primary: MyColor.mtMainGreen,
                                  onPrimary: Colors.white,
                                  onSurface: MyColor.mtDeepGreen,
                                ),
                              ),
                              child: child!,
                            );
                          },
                        );
                        if (dateTimeRange != null) {
                          setState(() {
                            selectedDates = dateTimeRange;
                            widget.startDateController.text =
                                DateFormat('yyyy-MMM-dd')
                                    .format(dateTimeRange.start);
                            widget.endDateController.text =
                                DateFormat('yyyy-MMM-dd')
                                    .format(dateTimeRange.end);
                          });
                        }
                      },
                      child: SizedBox(
                          width: size.width * .12,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 17),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  widget.startDateController.text.isNotEmpty
                                      ? widget.startDateController.text
                                      : widget.hint,
                                  style: TextDesign().bodyTextSmall,
                                ),
                                const Icon(
                                  FontAwesomeIcons.calendarDay,
                                  color: MyColor.mtMainGreen,
                                  size: 15,
                                )
                              ],
                            ),
                          )),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 10),
            Flexible(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("End Date", style: TextDesign().bodyTitle),
                  const SizedBox(
                    height: 5,
                  ),
                  Material(
                    color: MyColor.mtSubGreen,
                    clipBehavior: Clip.hardEdge,
                    borderRadius: BorderRadius.circular(10),
                    child: InkWell(
                      onTap: () async {
                        // pop up
                        final DateTimeRange? dateTimeRange =
                            await showDateRangePicker(
                          context: context,
                          firstDate: DateTime(2010),
                          lastDate: DateTime(2200),
                          confirmText: "Select",
                          builder: (context, child) {
                            //color changed here
                            return Theme(
                              data: Theme.of(context).copyWith(
                                colorScheme: const ColorScheme.light(
                                  primary: MyColor.mtMainGreen,
                                  onPrimary: Colors.white,
                                  onSurface: MyColor.mtDeepGreen,
                                ),
                              ),
                              child: child!,
                            );
                          },
                        );
                        if (dateTimeRange != null) {
                          setState(() {
                            selectedDates = dateTimeRange;
                            widget.startDateController.text =
                                DateFormat('yyyy-MM-dd')
                                    .format(dateTimeRange.start);
                            widget.endDateController.text =
                                DateFormat('yyyy-MM-dd')
                                    .format(dateTimeRange.end);
                          });
                        }
                      },
                      child: SizedBox(
                          width: size.width * .12,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 17),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  widget.endDateController.text.isNotEmpty
                                      ? widget.endDateController.text
                                      : widget.hint,
                                  style: TextDesign().bodyTextSmall,
                                ),
                                const Icon(
                                  FontAwesomeIcons.calendarDay,
                                  color: MyColor.mtMainGreen,
                                  size: 15,
                                )
                              ],
                            ),
                          )),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 10),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: SimpleIconButton(
                onClick: () {},
                width: 50,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
