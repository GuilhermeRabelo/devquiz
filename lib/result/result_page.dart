import 'package:DevQuiz/challenge/widgets/next_button/next_button_widget.dart';
import 'package:DevQuiz/core/app_colors.dart';
import 'package:DevQuiz/core/app_images.dart';
import 'package:DevQuiz/core/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class ResultPage extends StatelessWidget {
  final String title;
  final int questionsLength;
  final int result;
  const ResultPage(
      {Key? key,
      required this.title,
      required this.questionsLength,
      required this.result})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                children: [
                  Image.asset(AppImages.trophy),
                  Text(
                    'Parabéns!',
                    style: AppTextStyles.heading40,
                  ),
                  SizedBox(height: 16),
                  Text.rich(
                    TextSpan(
                      text: 'Você concluiu o\n',
                      style: AppTextStyles.body,
                      children: [
                        TextSpan(
                          text: '$title\n',
                          style: AppTextStyles.bodyBold,
                        ),
                        TextSpan(
                          text: 'com $result de $questionsLength acertos.',
                          style: AppTextStyles.body,
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 32),
                          child: NextButtonWidget(
                            backgroundColor: AppColors.purple,
                            label: 'Compartilhar',
                            fontColor: AppColors.white,
                            borderColor: AppColors.border,
                            onTap: () {
                              Share.share(
                                  'Eu acertei $result de $questionsLength no quiz de Flutter');
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 32),
                          child: NextButtonWidget(
                            backgroundColor: Colors.transparent,
                            label: 'Voltar ao início',
                            fontColor: AppColors.purple,
                            borderColor: AppColors.border,
                            onTap: () {
                              Navigator.pop(context);
                            },
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
