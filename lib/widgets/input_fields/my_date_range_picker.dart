import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';


import '../../const_config/color_config.dart';
import '../../const_config/text_config.dart';
import '../buttons/simple_icon_button.dart';

class MyDateRangePicker extends StatefulWidget {
  final String hint;
  final TextEditingController startDateController;
  final TextEditingController endDateController;
  final Function onClick;

  const MyDateRangePicker(
      {super.key,
      required this.startDateController,
      required this.endDateController,
      required this.hint,
      required this.onClick});

  @override
  State<MyDateRangePicker> createState() => _MyDateRangePickerState();
}

class _MyDateRangePickerState extends State<MyDateRangePicker> {
  DateTime selectedDate = DateTime.now();
  DateTimeRange selectedDates = DateTimeRange(
    start: DateTime.now(),
    end: DateTime.now(),
  );

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return size.width > 500
        ? Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              InkWell(
                hoverColor: MyColor.white,
                onTap: () async {
                  final DateTimeRange? dateTimeRange =
                      await showDateRangePicker(
                    context: context,
                    firstDate: DateTime(2020),
                    lastDate: DateTime(2100),
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
                        child: Dialog(
                            child: Material(
                                clipBehavior: Clip.hardEdge,
                                borderRadius: BorderRadius.circular(18),
                                child: SizedBox(
                                    width: size.width < 600 ? 300 : 500,
                                    child: child!))),
                      );
                    },
                  );
                  if (dateTimeRange != null) {
                    setState(() {
                      selectedDates = dateTimeRange;
                      widget.startDateController.text =
                          DateFormat('dd MMM yyy').format(dateTimeRange.start);
                      widget.endDateController.text =
                          DateFormat('dd MMM yyy').format(dateTimeRange.end);
                    });
                  }
                },
                child: size.width > 420
                    ? Row(
                        children: [
                          Column(
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
                                child: SizedBox(
                                    width: 150,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15, vertical: 15),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            widget.startDateController.text
                                                    .isNotEmpty
                                                ? widget
                                                    .startDateController.text
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
                            ],
                          ),
                          const SizedBox(width: 10),
                          Column(
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
                                child: SizedBox(
                                    width: 150,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15, vertical: 15),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            widget.endDateController.text
                                                    .isNotEmpty
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
                            ],
                          ),
                          const SizedBox(width: 10),
                        ],
                      )
                    : Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Start Date", style: TextDesign().bodyTitle),
                            const SizedBox(
                              height: 5,
                            ),
                            Material(
                              color: MyColor.mtSubGreen,
                              clipBehavior: Clip.hardEdge,
                              borderRadius: BorderRadius.circular(10),
                              child: SizedBox(
                                  width: 150,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15, vertical: 15),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          widget.startDateController.text
                                                  .isNotEmpty
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
                            const SizedBox(height: 10),
                            Text("End Date", style: TextDesign().bodyTitle),
                            const SizedBox(
                              height: 5,
                            ),
                            Material(
                              color: MyColor.mtSubGreen,
                              clipBehavior: Clip.hardEdge,
                              borderRadius: BorderRadius.circular(10),
                              child: SizedBox(
                                  width: 150,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15, vertical: 15),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          widget.endDateController.text
                                                  .isNotEmpty
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
                          ],
                        ),
                      ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: SimpleIconButton(
                  onClick: () {
                    widget.onClick();
                  },
                  width: 50,
                ),
              ),
            ],
          )
        : Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
                hoverColor: MyColor.white,
                onTap: () async {
                  final DateTimeRange? dateTimeRange =
                      await showDateRangePicker(
                    context: context,
                    firstDate: DateTime(2020),
                    lastDate: DateTime(2100),
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
                        child: Dialog(
                            child: Material(
                                clipBehavior: Clip.hardEdge,
                                borderRadius: BorderRadius.circular(18),
                                child: SizedBox(
                                    width: size.width < 600 ? 300 : 500,
                                    child: child!))),
                      );
                    },
                  );
                  if (dateTimeRange != null) {
                    setState(() {
                      selectedDates = dateTimeRange;
                      widget.startDateController.text =
                          DateFormat('dd MMM yyy').format(dateTimeRange.start);
                      widget.endDateController.text =
                          DateFormat('dd MMM yyy').format(dateTimeRange.end);
                    });
                  }
                },
                child: size.width > 420
                    ? Row(
                        children: [
                          Column(
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
                                child: SizedBox(
                                    width: 150,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15, vertical: 15),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            widget.startDateController.text
                                                    .isNotEmpty
                                                ? widget
                                                    .startDateController.text
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
                            ],
                          ),
                          const SizedBox(width: 10),
                          Column(
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
                                child: SizedBox(
                                    width: 150,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15, vertical: 15),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            widget.endDateController.text
                                                    .isNotEmpty
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
                            ],
                          ),
                          const SizedBox(width: 10),
                        ],
                      )
                    : Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Start Date", style: TextDesign().bodyTitle),
                            const SizedBox(
                              height: 5,
                            ),
                            Material(
                              color: MyColor.mtSubGreen,
                              clipBehavior: Clip.hardEdge,
                              borderRadius: BorderRadius.circular(10),
                              child: SizedBox(
                                  width: 150,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15, vertical: 15),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          widget.startDateController.text
                                                  .isNotEmpty
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
                            const SizedBox(height: 10),
                            Text("End Date", style: TextDesign().bodyTitle),
                            const SizedBox(
                              height: 5,
                            ),
                            Material(
                              color: MyColor.mtSubGreen,
                              clipBehavior: Clip.hardEdge,
                              borderRadius: BorderRadius.circular(10),
                              child: SizedBox(
                                  width: 150,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15, vertical: 15),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          widget.endDateController.text
                                                  .isNotEmpty
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
                          ],
                        ),
                      ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: SimpleIconButton(
                  onClick: () {
                    widget.onClick();
                  },
                  width: 50,
                ),
              ),
            ],
          );
  }
}
