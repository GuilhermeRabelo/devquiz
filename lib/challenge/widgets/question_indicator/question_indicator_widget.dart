import 'package:DevQuiz/core/app_colors.dart';
import 'package:DevQuiz/core/app_text_styles.dart';
import 'package:DevQuiz/shared/progress_indicator_widget.dart';
import 'package:flutter/material.dart';

class QuestionIndicatorWidget extends StatelessWidget {
  final int currentQuestion;
  final int questionsLength;
  const QuestionIndicatorWidget(
      {Key? key, required this.currentQuestion, required this.questionsLength})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Questão $currentQuestion',
                  style: AppTextStyles.body,
                ),
                Text(
                  'de $questionsLength',
                  style: AppTextStyles.body,
                ),
              ],
            ),
            SizedBox(height: 16),
            LinearProgressIndicator(
              //trocar para o ProgressIndicatorWidget
              value: currentQuestion / questionsLength,
              backgroundColor: AppColors.chartSecondary,
              valueColor: AlwaysStoppedAnimation<Color>(AppColors.chartPrimary),
            )
          ],
        ),
      ),
    );
  }
}
