import 'dart:developer';

import 'package:DevQuiz/challenge/widgets/anwser/answer_widget.dart';
import 'package:DevQuiz/core/app_text_styles.dart';
import 'package:DevQuiz/shared/question_model.dart';
import 'package:flutter/material.dart';

import '../challenge_controller.dart';

class QuizWidget extends StatefulWidget {
  final QuestionModel question;
  final bool isConfirmed;
  final void Function(bool) onSelectQuestion;
  const QuizWidget(
      {Key? key,
      required this.question,
      required this.isConfirmed,
      required this.onSelectQuestion})
      : super(key: key);

  @override
  _QuizWidgetState createState() => _QuizWidgetState();
}

class _QuizWidgetState extends State<QuizWidget> {
  final controller = ChallengeController();
  int? indexSelected;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              widget.question.title,
              style: AppTextStyles.heading,
            ),
            SizedBox(height: 24),
            for (var i = 0; i < widget.question.answers.length; i++)
              AnswerWidget(
                isCorrect: widget.question.answers[i].isCorrect,
                title: widget.question.answers[i].title,
                isSelected: indexSelected == i,
                disabled: indexSelected != null && widget.isConfirmed,
                isConfirmed: widget.isConfirmed,
                onTap: () {
                  indexSelected = i;
                  widget.onSelectQuestion(widget.question.answers[i].isCorrect);
                  setState(() {});
                },
              )
          ],
        ),
      ),
    );
  }
}
