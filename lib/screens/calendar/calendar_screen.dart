import 'package:body_house_app/core/theme/colors.dart';
import 'package:body_house_app/layouts/layout.dart';
import 'package:body_house_app/screens/calendar/add_treining_flow.dart';
import 'package:body_house_app/screens/calendar/session_to_add.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

class CalendarScreen extends StatelessWidget {
  const CalendarScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Layout(
      type: 1,
      child: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 32, left: 16.0, right: 16.0),
        child: CalendarSection(),
      ),
    );
  }
}

class CalendarSection extends StatefulWidget {
  const CalendarSection({super.key});

  @override
  State<CalendarSection> createState() => _CalendarSectionState();
}

class _CalendarSectionState extends State<CalendarSection> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  void _showDayDetailsSheet(BuildContext context, DateTime day) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.6, // wysokość boxa
          minChildSize: 0.5,
          maxChildSize: 0.9,
          builder: (_, controller) {
            return Container(
              decoration: const BoxDecoration(
                color: AppColors.secondBackground,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
              ),
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Center(
                    child: Container(
                      width: 40,
                      height: 4,
                      margin: const EdgeInsets.only(bottom: 12),
                      decoration: BoxDecoration(
                        color: Colors.white24,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                  Text(
                    'добавить тренировку',
                    style: const TextStyle(
                      color: AppColors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    DateFormat.yMMMMd('ru_RU').format(day),
                    style: const TextStyle(
                      color: AppColors.accent,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 12),
                  Expanded(child: AddTrainingFlow()),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Nagłówek z miesiącem i nawigacją
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: Icon(Icons.chevron_left, color: AppColors.accent),
                onPressed: () {
                  setState(() {
                    _focusedDay = DateTime(
                      _focusedDay.year,
                      _focusedDay.month - 1,
                      1,
                    );
                  });
                },
              ),
              Text(
                DateFormat.yMMMM('ru_RU').format(_focusedDay),
                style: TextStyle(
                  color: AppColors.accent,
                  fontWeight: FontWeight.bold,
                  fontSize: 14.0,
                ),
              ),
              IconButton(
                icon: Icon(Icons.chevron_right, color: AppColors.accent),
                onPressed: () {
                  setState(() {
                    _focusedDay = DateTime(
                      _focusedDay.year,
                      _focusedDay.month + 1,
                      1,
                    );
                  });
                },
              ),
            ],
          ),
        ),

        // Własny TableCalendar
        TableCalendar(
          firstDay: DateTime.utc(2020, 1, 1),
          lastDay: DateTime.utc(2030, 12, 31),
          focusedDay: _focusedDay,
          selectedDayPredicate: (day) {
            return isSameDay(_selectedDay, day);
          },
          onDaySelected: (selectedDay, focusedDay) {
            setState(() {
              _selectedDay = selectedDay;
              _focusedDay = focusedDay;
            });

            _showDayDetailsSheet(context, selectedDay); // 👈 pokazujemy panel
          },
          rowHeight: 46,
          calendarStyle: CalendarStyle(
            todayTextStyle: TextStyle(
              color: AppColors.white,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
            todayDecoration: BoxDecoration(
              border: Border.all(color: AppColors.white, width: 1),
              shape: BoxShape.circle,
            ),
            selectedTextStyle: TextStyle(
              color: AppColors.white,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
            selectedDecoration: BoxDecoration(
              border: Border.all(color: AppColors.white, width: 1),
              color: AppColors.secondBackground,
              shape: BoxShape.circle,
            ),
            defaultTextStyle: TextStyle(color: Colors.white.withOpacity(0.6)),
            weekendTextStyle: TextStyle(color: Colors.white.withOpacity(0.6)),
            outsideDaysVisible: true,
            outsideDecoration: BoxDecoration(
              border: Border.all(
                color: Colors.white.withOpacity(0.15),
                width: 1,
              ),
              shape: BoxShape.circle,
            ),
            outsideTextStyle: TextStyle(
              color: Colors.white.withOpacity(0.15),
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
          headerVisible: false, // bo mamy własny header
          daysOfWeekStyle: DaysOfWeekStyle(
            weekdayStyle: TextStyle(
              color: AppColors.white,
              fontWeight: FontWeight.w600,
            ),
            weekendStyle: TextStyle(
              color: AppColors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
          calendarBuilders: CalendarBuilders(
            dowBuilder: (context, day) {
              final text = DateFormat.E('ru_RU').format(day);
              return Center(
                child: Text(
                  text,
                  style: TextStyle(
                    color: AppColors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                ),
              );
            },

            // 💡 Tutaj stylujemy każdy dzień
            defaultBuilder: (context, day, focusedDay) {
              return Center(
                child: Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white.withOpacity(0.6),
                      width: 1,
                    ),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    '${day.day}',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.6),
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
