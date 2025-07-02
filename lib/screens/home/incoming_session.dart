import 'package:body_house_app/core/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
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
          IncomingSessionBox(),
        ],
      ),
    );
  }
}

class IncomingSessionBox extends StatelessWidget {
  const IncomingSessionBox({super.key});

  Widget iconWithText(String assetPath, String text) {
    return Row(
      children: [
        SvgPicture.asset(assetPath, width: 10.0, height: 10.0),
        const SizedBox(width: 2),
        Text(
          text,
          style: TextStyle(color: AppColors.darkBackground, fontSize: 10),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
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
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 18.0,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "начало через: 1д 6ч 31м",
                            style: TextStyle(
                              color: AppColors.darkBackground,
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              height: 1.0,
                            ),
                          ),
                          SizedBox(height: 16.0),
                          Text(
                            "йога на открытом воздухе",
                            style: TextStyle(
                              color: AppColors.darkBackground,
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                              height: 0.8,
                            ),
                            textAlign: TextAlign.left,
                          ),
                          SizedBox(height: 4.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              iconWithText(
                                'assets/images/time_black.svg',
                                '45 минут',
                              ),
                              const SizedBox(width: 12),
                              iconWithText(
                                'assets/images/difficulty_black.svg',
                                'легкий',
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: 140,
                    height: 120,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20),
                        topLeft: Radius.circular(16),
                        bottomLeft: Radius.circular(16),
                        bottomRight: Radius.circular(20),
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20),
                        topLeft: Radius.circular(16),
                        bottomLeft: Radius.circular(16),
                        bottomRight: Radius.circular(20),
                      ),
                      child: Image.asset(
                        'assets/images/session_sample2.jpg',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              right: 126,
              bottom: 21,
              child: SvgPicture.asset(
                "assets/images/start_btn.svg",
                width: 28.0,
                height: 28.0,
              ),
            ),
          ],
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
  MiniCalendar({super.key});

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
