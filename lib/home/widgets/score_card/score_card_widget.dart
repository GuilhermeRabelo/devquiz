import 'package:DevQuiz/core/app_colors.dart';
import 'package:DevQuiz/core/app_text_styles.dart';
import 'package:DevQuiz/home/widgets/chart/chart_widget.dart';
import 'package:flutter/material.dart';

class ScoreCardWidget extends StatelessWidget {
  final double percentage;
  const ScoreCardWidget({Key? key, required this.percentage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      height: 120,
      decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(15),
          border: Border.fromBorderSide(BorderSide(color: AppColors.border))),
      child: Row(
        children: [
          Expanded(
            child: ChartWidget(
              percentage: percentage,
            ),
          ),
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Vamos começar", style: AppTextStyles.heading),
                  SizedBox(height: 8),
                  Text("Complete os desafios e avance no conhecimento",
                      style: AppTextStyles.body),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
