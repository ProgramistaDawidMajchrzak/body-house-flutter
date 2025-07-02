import 'package:body_house_app/core/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(IncomingSession());
}

class IncomingSession extends StatelessWidget {
  const IncomingSession({super.key});

  List<DateTime> getNext7Days() {
    DateTime today = DateTime.now();
    return List.generate(7, (index) => today.add(Duration(days: index)));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          SizedBox(height: 8),
          MiniCalendar(),
          SizedBox(height: 16),
          Rectangle17(),
        ],
      ),
    );
  }
}

class Rectangle17 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 342,
          height: 100,
          decoration: ShapeDecoration(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
      ],
    );
  }
}

class MiniCalendar extends StatelessWidget {
  final List<DateTime> days = () {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final weekday = today.weekday;
    final startOfWeek = today.subtract(Duration(days: weekday - 1));

    return List.generate(7, (index) => startOfWeek.add(Duration(days: index)));
  }();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children:
              days.map((date) {
                final weekday = DateFormat.E('ru_RU').format(date);
                return Expanded(
                  child: Center(
                    child: Text(
                      weekday,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                      ),
                    ),
                  ),
                );
              }).toList(),
        ),
        SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children:
              days.map((date) {
                final now = DateTime.now();
                final today = DateTime(now.year, now.month, now.day);
                final isToday = DateUtils.isSameDay(date, today);
                final isInTwoDays = DateUtils.isSameDay(
                  date,
                  today.add(Duration(days: 2)),
                );
                final isPast = date.isBefore(today);

                return Expanded(
                  child: Center(
                    child: Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color:
                              isToday
                                  ? Colors.white
                                  : isInTwoDays
                                  ? AppColors.accent
                                  : isPast
                                  ? Colors.white.withOpacity(0.15)
                                  : Colors.white.withOpacity(0.6),
                          width: 1,
                        ),
                      ),
                      alignment: Alignment.center, // 👈 centrowanie numerka
                      child: Text(
                        '${date.day}',
                        style: TextStyle(
                          fontSize: 12,
                          color:
                              isToday
                                  ? Colors.white
                                  : isInTwoDays
                                  ? AppColors.accent
                                  : isPast
                                  ? Colors.white.withOpacity(0.15)
                                  : Colors.white.withOpacity(0.6),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
        ),
      ],
    );
  }
}
