import 'package:body_house_app/core/theme/colors.dart';
import 'package:body_house_app/screens/home/my_sessions.dart';
import 'package:flutter/material.dart';

class Recommendations extends StatelessWidget {
  const Recommendations({super.key});

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
                "Рекомендации",
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
