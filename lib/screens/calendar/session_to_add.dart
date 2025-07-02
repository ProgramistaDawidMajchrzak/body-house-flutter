import 'package:body_house_app/core/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SessionToAdd extends StatelessWidget {
  const SessionToAdd({super.key});

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
