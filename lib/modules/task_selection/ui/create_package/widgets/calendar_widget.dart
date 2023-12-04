import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CalendarWidget extends StatelessWidget {
  const CalendarWidget({
    super.key,
    this.weekends,
    this.nonWorkingDays,
    this.selectedDates,
    required this.isStart,
    this.onUpdateDates,
  });

  final List<int>? weekends;
  final List<DateTime>? nonWorkingDays;
  final List<DateTime?>? selectedDates;
  final bool isStart;
  final Function(List<DateTime?>?)? onUpdateDates;

  //
  //
  // List<DateTime?>? _dialogCalendarPickerValue;
  //
  //   if (widget.selectedDates != null && widget.selectedDates!.isNotEmpty) {
  //     _dialogCalendarPickerValue = widget.selectedDates!;
  //   }

  @override
  Widget build(BuildContext context) {
    final today = DateUtils.dateOnly(DateTime.now());
    final dateFormatter = DateFormat('dd MMMM yyyy');
    const dayTextStyle = TextStyle(color: Colors.black, fontWeight: FontWeight.w700);
    final weekendTextStyle = TextStyle(color: Colors.grey[500], fontWeight: FontWeight.w600);
    final anniversaryTextStyle = TextStyle(
      color: Colors.red[400],
      fontWeight: FontWeight.w700,
      // decoration: TextDecoration.underline,
    );
    final config = CalendarDatePicker2WithActionButtonsConfig(
      dayTextStyle: dayTextStyle,
      calendarType: CalendarDatePicker2Type.range,
      selectedDayHighlightColor: Colors.blue.shade700,
      closeDialogOnCancelTapped: true,
      firstDayOfWeek: 1,
      weekdayLabelTextStyle: const TextStyle(
        color: Colors.black87,
        fontWeight: FontWeight.bold,
      ),
      controlsTextStyle: const TextStyle(
        color: Colors.black,
        fontSize: 15,
        fontWeight: FontWeight.bold,
      ),
      centerAlignModePicker: true,
      customModePickerIcon: const SizedBox(),
      selectedDayTextStyle: dayTextStyle.copyWith(color: Colors.white),
      dayTextStylePredicate: ({required date}) {
        TextStyle? textStyle;

        if (weekends?.contains(date.weekday) == true) {
          textStyle = weekendTextStyle;
        }

        if (nonWorkingDays?.contains(date) == true) {
          textStyle = anniversaryTextStyle;
        }
        return textStyle;
      },
      dayBuilder: ({
        required date,
        textStyle,
        decoration,
        isSelected,
        isDisabled,
        isToday,
      }) {
        Widget? dayWidget;
        return dayWidget;
      },
      yearBuilder: ({
        required year,
        decoration,
        isCurrentYear,
        isDisabled,
        isSelected,
        textStyle,
      }) {
        return Center(
          child: Container(
            decoration: decoration,
            height: 36,
            width: 72,
            child: Center(
              child: Semantics(
                selected: isSelected,
                button: true,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      year.toString(),
                      style: textStyle,
                    ),
                    if (isCurrentYear == true)
                      Container(
                        padding: const EdgeInsets.all(5),
                        margin: const EdgeInsets.only(left: 5),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.redAccent,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );

    return InkWell(
      onTap: () async {
        final values = await showCalendarDatePicker2Dialog(
          context: context,
          config: config,
          dialogSize: const Size(325, 400),
          borderRadius: BorderRadius.circular(4),
          value: selectedDates ?? [today, today],
          dialogBackgroundColor: Colors.white,
        );
        if (values != null) {
          // ignore: avoid_print
          print(_getValueText(
            config.calendarType,
            values,
          ));
          // setState(() {
          //   log("set state");
          //   _dialogCalendarPickerValue = values;
          // });
            onUpdateDates?.call(values);
        }
      },
      child: Container(
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.symmetric(horizontal: 8),
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: Colors.black45),
          color: Colors.white,
        ),
        child: (selectedDates != null)
            ? Text(
                (isStart && selectedDates![0] != null)
                    ? dateFormatter.format(selectedDates![0]!)
                    : (!isStart && selectedDates!.length > 1 && selectedDates![1] != null)
                        ? dateFormatter.format(selectedDates![1]!)
                        : (!isStart && selectedDates!.length == 1)
                            ? dateFormatter.format(selectedDates![0]!)
                            : 'Select date',
                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black45),
              )
            : const Text(
                'Select date',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black45),
              ),
      ),
    );
  }

  String _getValueText(
    CalendarDatePicker2Type datePickerType,
    List<DateTime?> values,
  ) {
    values = values.map((e) => e != null ? DateUtils.dateOnly(e) : null).toList();
    var valueText = (values.isNotEmpty ? values[0] : null).toString().replaceAll('00:00:00.000', '');

    if (datePickerType == CalendarDatePicker2Type.multi) {
      valueText =
          values.isNotEmpty ? values.map((v) => v.toString().replaceAll('00:00:00.000', '')).join(', ') : 'null';
    } else if (datePickerType == CalendarDatePicker2Type.range) {
      if (values.isNotEmpty) {
        final startDate = values[0].toString().replaceAll('00:00:00.000', '');
        final endDate = values.length > 1 ? values[1].toString().replaceAll('00:00:00.000', '') : 'null';
        valueText = '$startDate to $endDate';
      } else {
        return 'null';
      }
    }

    return valueText;
  }
}

// if (date.day % 3 == 0 && date.day % 9 != 0) {
// dayWidget = Container(
// decoration: decoration,
// child: Center(
// child: Stack(
// alignment: AlignmentDirectional.center,
// children: [
// Text(
// MaterialLocalizations.of(context).formatDecimal(date.day),
// style: textStyle,
// ),
// Padding(
// padding: const EdgeInsets.only(top: 27.5),
// child: Container(
// height: 4,
// width: 4,
// decoration: BoxDecoration(
// borderRadius: BorderRadius.circular(5),
// color: isSelected == true ? Colors.white : Colors.grey[500],
// ),
// ),
// ),
// ],
// ),
// ),
// );
// }
