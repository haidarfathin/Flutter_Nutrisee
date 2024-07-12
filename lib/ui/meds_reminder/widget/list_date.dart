import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:nutrisee/core/data/model/task_day/task_day.dart';
import 'package:nutrisee/core/utils/datetime_extension.dart';
import 'package:nutrisee/core/utils/theme_extension.dart';
import 'package:nutrisee/core/widgets/app_colors.dart';

class ListDate extends StatefulWidget {
  final Function(DateTime?) dateSelected;
  const ListDate({super.key, required this.dateSelected});

  @override
  State<ListDate> createState() => _ListDateState();
}

class _ListDateState extends State<ListDate> {
  final scroll = ScrollController(initialScrollOffset: (31 - 14.5) * 60);
  DateTime? selectedDate;
  List<TaskDay> listDate = [];

  @override
  void initState() {
    super.initState();
    listDate = generate30day();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      padding: const EdgeInsets.only(top: 12, left: 8, right: 12),
      child: ListView.builder(
        controller: scroll,
        scrollDirection: Axis.horizontal,
        itemCount: listDate.length,
        itemBuilder: (context, index) {
          final dateItem = listDate[index];
          return GestureDetector(
            onTap: () {
              setState(() {
                for (var element in listDate) {
                  element.selected = false;
                }
                dateItem.selected = true;
                selectedDate = dateItem.date;
                widget.dateSelected.call(dateItem.date);
              });
            },
            child: itemDay(dateItem, context),
          );
        },
      ),
    );
  }
}

Widget itemDay(TaskDay data, BuildContext context) {
  String todayDate = DateTime.now().dateFormat('DD');
  String todaySelected = DateTime.now().dateFormat('yyyy-MM-dd');
  Color bgDate;
  Color textDate;
  bool useBorder = false;
  if (data.selected == true || data.date.toString() == todaySelected) {
    useBorder = true;
  }

  if (data.date.dateFormat('DD') == todayDate) {
    bgDate = Colors.green;
    textDate = Colors.white;
  } else {
    bgDate = Colors.green.shade100;
    textDate = Colors.green.shade700;
  }
  return Container(
    width: 60,
    margin: const EdgeInsets.symmetric(horizontal: 8),
    alignment: Alignment.center,
    decoration: BoxDecoration(
      color: bgDate,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(
        width: 3,
        color: useBorder ? AppColors.primary : Colors.transparent,
      ),
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          data.date.dateFormat('MMM'),
          style: context.textTheme.bodyMedium?.copyWith(
            color: textDate,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          data.date.dateFormat('dd'),
          style: context.textTheme.bodyLarge?.copyWith(
            color: textDate,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    ),
  );
}

List<TaskDay> generate30day() {
  List<DateTime> days = [];
  final today = DateTime.now();
  int month = today.month;

  Map<int, int> daysOfMonth = {
    1: 31,
    2: 28,
    3: 31,
    4: 30,
    5: 31,
    6: 30,
    7: 31,
    8: 31,
    9: 30,
    10: 31,
    11: 30,
    12: 31,
  };

  final int daysToShow = daysOfMonth[month] ?? 0;

  const int daysBefore = 15;
  final int daysAfter = daysToShow - daysBefore;

  final startDate = today.subtract(const Duration(days: daysBefore));
  final endDate = today.add(Duration(days: daysAfter));

  for (DateTime date = startDate;
      date.isBefore(endDate);
      date = date.add(const Duration(days: 1))) {
    days.add(date);
  }

  final removeDuplicat = days.toSet().toList();
  removeDuplicat.sort(
    (a, b) => a.compareTo(b),
  );

  List<TaskDay> data = [];
  for (var element in removeDuplicat) {
    bool selected = element.dateFormat('yyyy-MM-dd') ==
            DateTime.now().dateFormat('yyyy-MM-dd')
        ? true
        : false;
    data.add(TaskDay(date: element, selected: selected));
  }

  return data;
}
