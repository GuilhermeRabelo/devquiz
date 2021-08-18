import 'dart:developer';

import 'package:DevQuiz/challenge/challenge_page.dart';
import 'package:DevQuiz/core/app_colors.dart';
import 'package:DevQuiz/home/home_controller.dart';
import 'package:DevQuiz/home/home_state.dart';
import 'package:DevQuiz/home/widgets/appbar/app_bar_widget.dart';
import 'package:DevQuiz/home/widgets/level_button/level_button_widget.dart';
import 'package:DevQuiz/home/widgets/quiz_card/quiz_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class HomePage extends StatefulWidget {
  String currentSkill;
  HomePage({Key? key, this.currentSkill = 'angular'}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final controller = HomeController();
  DateTime currentBackPressTime = DateTime.now();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.getUser();
    controller.stateNotifier.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    if (controller.state == HomeState.sucess ||
        controller.state == HomeState.loadingQuestion) {
      return Scaffold(
        // appBar: AppBarWidget(
        //   user: controller.user!,
        //   questionsLength: controller.questionsLength,
        //   questionsAwnsersLength: controller.questionsAwnsersLength,
        // ),
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(250),
          child: AppBarWidget(
            user: controller.user!,
            questionsLength: controller.questionsLength,
            questionsAwnsersLength: controller.questionsAwnsersLength,
          ),
        ),
        body: WillPopScope(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Column(
                children: [
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SkillButtonWidget(
                        label: "flutter",
                        currentSkill: widget.currentSkill,
                        onTap: () {
                          if (widget.currentSkill != 'flutter') {
                            controller.getQuizzes('flutter');
                            setState(() {
                              widget.currentSkill = 'flutter';
                            });
                          }
                        },
                      ),
                      SkillButtonWidget(
                        label: "angular",
                        currentSkill: widget.currentSkill,
                        onTap: () {
                          if (widget.currentSkill != 'angular') {
                            controller.getQuizzes('angular');
                            setState(() {
                              widget.currentSkill = 'angular';
                            });
                          }
                        },
                      ),
                      SkillButtonWidget(
                        label: "difícil",
                        currentSkill: widget.currentSkill,
                        onTap: () {},
                      ),
                      SkillButtonWidget(
                        label: "perito",
                        currentSkill: widget.currentSkill,
                        onTap: () {},
                      ),
                    ],
                  ),
                  SizedBox(height: 24),
                  Expanded(
                    child: controller.state == HomeState.loadingQuestion
                        ? Center(
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(
                                  AppColors.darkGreen),
                            ),
                          )
                        : Container(
                            child: GridView.count(
                              crossAxisCount: 2,
                              crossAxisSpacing: 16,
                              mainAxisSpacing: 16,
                              children: controller.quizzes!
                                  .map(
                                    (e) => QuizCardWidget(
                                      title: e.title,
                                      percentage: e.questionAnswered /
                                          e.questions.length,
                                      progress:
                                          "${e.questionAnswered}/${e.questions.length}",
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => ChallengePage(
                                              questions: e.questions,
                                              title: e.title,
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  )
                                  .toList(),
                            ),
                          ),
                  ),
                ],
              ),
            ),
            onWillPop: onWillPop),
      );
    } else {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(AppColors.darkGreen),
          ),
        ),
      );
    }
  }

  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (now.difference(currentBackPressTime) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      Fluttertoast.showToast(
        msg: 'Clique novamente para sair do app',
        backgroundColor: Color(0xFF8C948F),
      );
      return Future.value(false);
    }
    return Future.value(true);
  }
}
