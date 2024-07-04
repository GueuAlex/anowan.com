import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

import '../../../config/app_text.dart';
import '../../../config/palette.dart';

class DateRangePicker extends StatefulWidget {
  @override
  _DateRangePickerState createState() => _DateRangePickerState();
}

class _DateRangePickerState extends State<DateRangePicker> {
  DateTime? _startDate;
  DateTime? _endDate;
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    setState(() {
      if (_startDate == null || (_startDate != null && _endDate != null)) {
        _startDate = selectedDay;
        _endDate = null;
      } else if (_endDate == null) {
        if (selectedDay.isBefore(_startDate!)) {
          _endDate = _startDate;
          _startDate = selectedDay;
        } else {
          _endDate = selectedDay;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(),
              Container(
                height: 35,
                width: 35,
                padding: EdgeInsets.all(1),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey.withOpacity(0.2),
                ),
                child: Center(
                  child: IconButton(
                    icon: Icon(Icons.close, size: 18),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ),
            ],
          ),
          AppText.medium(
            'Choose dates',
            fontSize: (size.width * 0.05),
            fontWeight: FontWeight.w600,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(child: selectedDateContainer(date: _startDate)),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: SizedBox(
                    width: 20,
                    child: Center(
                      child: Icon(
                        CupertinoIcons.arrow_right,
                        color: const Color.fromARGB(255, 104, 104, 104),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: selectedDateContainer(date: _endDate),
                ),
              ],
            ),
          ),
          TableCalendar(
            firstDay: DateTime.now(),
            lastDay: DateTime.utc(2100, 12, 31),
            //daysOfWeekVisible: false,
            headerStyle: HeaderStyle(
              formatButtonVisible: false,
              titleTextStyle:
                  TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
              leftChevronIcon: Icon(
                CupertinoIcons.chevron_left,
                size: 22,
                color: Palette.appRed,
              ),
              rightChevronIcon: Icon(
                CupertinoIcons.chevron_right,
                size: 22,
                color: Palette.appRed,
              ),
              //formatButtonShowsNext: false,
              headerMargin: EdgeInsets.zero,
              titleCentered: true,
            ),
            calendarStyle: CalendarStyle(
              outsideDaysVisible: false,
              selectedDecoration: BoxDecoration(
                color: Palette.appRed,
                shape: BoxShape.circle,
              ),
              selectedTextStyle: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 18,
                color: Colors.white,
              ),
              todayTextStyle: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 18,
                color: Palette.appRed,
              ),
              todayDecoration: BoxDecoration(
                color: Palette.appRed.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
            ),

            locale: 'fr',
            focusedDay: _focusedDay,
            calendarFormat: _calendarFormat,
            selectedDayPredicate: (day) {
              if (_startDate != null && _endDate == null) {
                return isSameDay(_startDate, day);
              } else if (_startDate != null && _endDate != null) {
                return day.isAfter(_startDate!.subtract(Duration(days: 1))) &&
                    day.isBefore(_endDate!.add(Duration(days: 1)));
              }
              return false;
            },
            onDaySelected: _onDaySelected,
            onPageChanged: (focusedDay) {
              _focusedDay = focusedDay;
            },
          ),
          SizedBox(height: 10),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Center(
                child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(
                        Palette.appRed,
                      ),
                      foregroundColor: WidgetStatePropertyAll(
                        Colors.white,
                      ),
                      shape: WidgetStatePropertyAll<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      )),
                  onPressed: () {
                    if (_startDate != null && _endDate != null) {
                      Navigator.pop(context, {
                        'start': _startDate,
                        'end': _endDate,
                      });
                    } else {
                      Fluttertoast.showToast(
                        msg: 'Selectionner un interval de date',
                        backgroundColor: Palette.appRed,
                        textColor: Colors.white,
                        gravity: ToastGravity.TOP,
                      );
                    }
                  },
                  child: Container(
                    width: (size.width),
                    height: (size.height * 0.055),
                    child: Center(
                      child: AppText.medium(
                        'Choose dates',
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container selectedDateContainer({required DateTime? date}) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 194, 194, 194).withOpacity(0.15),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Center(
        child: AppText.medium(
          date == null ? 'End Date' : DateFormat('dd MMM yyyy').format(date),
          fontWeight: FontWeight.w500,
          color: Palette.appRed,
          fontSize: 15,
        ),
      ),
    );
  }
}

void showCustomDateRangePicker(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (context) {
      return Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
        ),
        child: DateRangePicker(),
      );
    },
  ).then((result) {
    if (result != null) {
      // Handle the selected date range
      print("Start Date: ${result['start']}");
      print("End Date: ${result['end']}");
    }
  });
}
