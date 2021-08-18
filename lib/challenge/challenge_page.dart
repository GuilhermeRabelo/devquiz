import 'dart:developer';

import 'package:DevQuiz/challenge/widgets/challenge_controller.dart';
import 'package:DevQuiz/challenge/widgets/next_button/next_button_widget.dart';
import 'package:DevQuiz/challenge/widgets/question_indicator/question_indicator_widget.dart';
import 'package:DevQuiz/challenge/widgets/quiz/quiz_widget.dart';
import 'package:DevQuiz/core/app_colors.dart';
import 'package:DevQuiz/result/result_page.dart';
import 'package:DevQuiz/shared/question_model.dart';
import 'package:flutter/material.dart';

class ChallengePage extends StatefulWidget {
  final List<QuestionModel> questions;
  final String title;
  bool isConfirmed;
  bool isSelectedOption;
  bool isCorrectAnwser;
  ChallengePage(
      {Key? key,
      required this.questions,
      required this.title,
      this.isConfirmed = false,
      this.isSelectedOption = false,
      this.isCorrectAnwser = false})
      : super(key: key);

  @override
  _ChallengePageState createState() => _ChallengePageState();
}

class _ChallengePageState extends State<ChallengePage> {
  final controller = ChallengeController();
  final pageController = PageController();

  @override
  void initState() {
    // TODO: implement initState
    pageController.addListener(() {
      controller.currentQuestion = pageController.page!.toInt() + 1;
    });
    super.initState();
  }

  void nextPage() {
    pageController.nextPage(
      duration: Duration(milliseconds: 500),
      curve: Curves.linear,
    );

    setState(() {
      widget.isConfirmed = false;
      widget.isSelectedOption = false;
      widget.isCorrectAnwser = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(78),
        child: SafeArea(
          top: true,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BackButton(),
              ValueListenableBuilder(
                valueListenable: controller.currentQuestionNotifier,
                builder: (BuildContext context, dynamic value, Widget? child) {
                  return QuestionIndicatorWidget(
                    currentQuestion: value,
                    questionsLength: widget.questions.length,
                  );
                },
              ),
            ],
          ),
        ),
      ),
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        controller: pageController,
        children: widget.questions
            .map((e) => QuizWidget(
                  question: e,
                  isConfirmed: widget.isConfirmed,
                  onSelectQuestion: (value) {
                    setState(() {
                      widget.isSelectedOption = true;
                      if (value) {
                        widget.isCorrectAnwser = true;
                      }
                    });
                  },
                ))
            .toList(),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SafeArea(
          bottom: true,
          child: ValueListenableBuilder(
            valueListenable: controller.currentQuestionNotifier,
            builder: (BuildContext context, dynamic value, Widget? child) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  if (value < widget.questions.length)
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: NextButtonWidget(
                          label: 'Pular',
                          backgroundColor: AppColors.white,
                          fontColor: AppColors.grey,
                          borderColor: AppColors.border,
                          onTap: () {
                            pageController.nextPage(
                              duration: Duration(milliseconds: 500),
                              curve: Curves.linear,
                            );
                          },
                        ),
                      ),
                    ),
                  if (value < widget.questions.length) SizedBox(width: 16),
                  if (value != widget.questions.length)
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: NextButtonWidget(
                          label: 'Confirmar',
                          backgroundColor: AppColors.darkGreen,
                          fontColor: AppColors.white,
                          borderColor: AppColors.darkGreen,
                          onTap: () {
                            if (widget.isSelectedOption) {
                              setState(() {
                                widget.isConfirmed = true;
                                if (widget.isCorrectAnwser) {
                                  controller.correctAnwsers++;
                                }
                                Future.delayed(Duration(seconds: 2))
                                    .then((value) => nextPage());
                              });
                            } else {
                              return null;
                            }
                          },
                        ),
                      ),
                    ),
                  if (value == widget.questions.length)
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: NextButtonWidget(
                          label: 'Finalizar',
                          backgroundColor: AppColors.darkGreen,
                          fontColor: AppColors.white,
                          borderColor: AppColors.darkGreen,
                          onTap: () {
                            if (widget.isSelectedOption) {
                              setState(() {
                                widget.isConfirmed = true;
                                if (widget.isCorrectAnwser) {
                                  controller.correctAnwsers++;
                                }
                              });
                              Future.delayed(Duration(seconds: 2))
                                  .then((value) => Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => ResultPage(
                                            title: widget.title,
                                            questionsLength:
                                                widget.questions.length,
                                            result: controller.correctAnwsers,
                                          ),
                                        ),
                                      ));
                            } else {
                              return null;
                            }
                          },
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
