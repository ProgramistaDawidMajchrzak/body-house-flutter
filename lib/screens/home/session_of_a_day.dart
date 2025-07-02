import 'package:flutter/material.dart';
import 'package:body_house_app/core/theme/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SessionOfADay extends StatelessWidget {
  const SessionOfADay({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 144.0,
      color: AppColors.secondBackground,
      child: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: SizedBox(
            width: 342,
            height: 120,
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(
                    'assets/images/session_sample1.jpg',
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                  ),
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: Container(
                    width: 175,
                    height: 24,
                    decoration: BoxDecoration(
                      color: AppColors.accent,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(30),
                        topLeft: Radius.circular(20),
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(0),
                      ),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      'тренировка этой недели',
                      style: TextStyle(
                        color: AppColors.darkBackground,
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),

                // Dolny overlay
                Align(
                  alignment: Alignment.bottomCenter,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                    child: SessionOfADayInfo(name: "кардио фитнес"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SessionOfADayInfo extends StatelessWidget {
  final String name;
  const SessionOfADayInfo({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    Widget iconWithText(String assetPath, String text) {
      return Row(
        children: [
          SvgPicture.asset(assetPath, width: 10.0, height: 10.0),
          const SizedBox(width: 2),
          Text(text, style: TextStyle(color: Colors.white, fontSize: 10)),
        ],
      );
    }

    return Container(
      height: 38,
      width: double.infinity,
      color: AppColors.darkBackground.withOpacity(0.8),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    color: AppColors.accent,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    height: 1.0,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    iconWithText('assets/images/time.svg', '45 минут'),
                    const SizedBox(width: 12),
                    iconWithText('assets/images/difficulty.svg', 'легкий'),
                    const SizedBox(width: 12),
                    iconWithText(
                      'assets/images/excercises.svg',
                      '5 упражнений',
                    ),
                  ],
                ),
              ],
            ),
            Icon(
              Icons.star, // pełna gwiazda
              color: Colors.white, // kolor biały
              size: 24, // rozmiar ikony
            ),
          ],
        ),
      ),
    );
  }
}
