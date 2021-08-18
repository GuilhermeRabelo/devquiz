import 'package:DevQuiz/core/app_gradients.dart';
import 'package:DevQuiz/core/app_text_styles.dart';
import 'package:DevQuiz/home/widgets/score_card/score_card_widget.dart';
import 'package:DevQuiz/shared/user_model.dart';
import 'package:flutter/material.dart';

import '../../home_controller.dart';

class AppBarWidget extends StatelessWidget {
  final UserModel user;
  final int questionsLength;
  final int questionsAwnsersLength;

  const AppBarWidget(
      {Key? key,
      required this.user,
      required this.questionsLength,
      required this.questionsAwnsersLength})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        height: 250,
        decoration: BoxDecoration(),
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: AppGradients.linear,
              ),
              padding: EdgeInsets.symmetric(
                horizontal: 20,
              ),
              height: 161,
              width: double.maxFinite,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text.rich(
                    TextSpan(
                      text: 'Olá, ',
                      style: AppTextStyles.title,
                      children: [
                        TextSpan(
                          text: user.name,
                          style: AppTextStyles.titleBold,
                        )
                      ],
                    ),
                  ),
                  Container(
                    width: 58,
                    height: 58,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        image: NetworkImage(user.photoUrl),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(
              child: Align(
                alignment: Alignment(0.0, 1.0),
                child: ScoreCardWidget(
                  percentage: questionsAwnsersLength / questionsLength,
                ),
              ),
              padding: EdgeInsets.symmetric(
                horizontal: 20,
              ),
            )
          ],
        ),
      ),
    );
  }
}
