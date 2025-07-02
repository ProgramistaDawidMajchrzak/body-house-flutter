import 'package:body_house_app/core/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class MySessions extends StatelessWidget {
  const MySessions({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Nagłówek
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                "Мои тренировки",
                style: TextStyle(
                  color: AppColors.accent,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Icon(Icons.arrow_forward_ios, size: 16, color: AppColors.accent),
            ],
          ),
        ),
        const SizedBox(height: 12),
        // Lista pozioma
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            children: List.generate(5, (index) {
              return Padding(
                padding: const EdgeInsets.only(right: 12.0),
                child: SessionSmall(),
              );
            }),
          ),
        ),
      ],
    );
  }
}

class SessionSmall extends StatelessWidget {
  const SessionSmall({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 152,
      height: 135,
      decoration: ShapeDecoration(
        color: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(color: Colors.white, width: 2.0),
        ),
      ),
      child: Stack(
        children: [
          Container(
            width: 152,
            height: 85,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(20),
                topLeft: Radius.circular(20),
                bottomLeft: Radius.circular(0),
                bottomRight: Radius.circular(0),
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(20),
                topLeft: Radius.circular(20),
                bottomLeft: Radius.circular(0),
                bottomRight: Radius.circular(0),
              ),
              child: Image.asset(
                'assets/images/session_sample.jpg',
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
              child: SessionSmallInfo(name: "название тренинга"),
            ),
          ),
          Positioned(
            top: 8.0,
            right: 8.0,
            child: Icon(Icons.star, color: Colors.white, size: 24),
          ),
          Positioned(
            right: 8.0,
            bottom: 40,
            child: SvgPicture.asset(
              "assets/images/start_btn.svg",
              width: 28.0,
              height: 28.0,
            ),
          ),
        ],
      ),
    );
  }
}

class SessionSmallInfo extends StatelessWidget {
  final String name;
  const SessionSmallInfo({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    Widget iconWithText(String assetPath, String text) {
      return Row(
        children: [
          SvgPicture.asset(assetPath, width: 8.0, height: 8.0),
          const SizedBox(width: 2),
          Text(
            text,
            style: TextStyle(color: AppColors.fourthBackground, fontSize: 9),
          ),
        ],
      );
    }

    return Container(
      height: 50,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 10.0, top: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: TextStyle(
                color: AppColors.accent,
                fontSize: 12,
                fontWeight: FontWeight.w600,
                height: 0.9,
              ),
            ),
            SizedBox(height: 2.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                iconWithText('assets/images/time_blue.svg', '45 минут'),
                const SizedBox(width: 4.0),
                iconWithText('assets/images/difficulty_blue.svg', 'легкий'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
