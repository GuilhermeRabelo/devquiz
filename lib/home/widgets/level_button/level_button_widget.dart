import 'package:DevQuiz/core/app_colors.dart';
import 'package:DevQuiz/core/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SkillButtonWidget extends StatelessWidget {
  final String label;
  final String currentSkill;
  final VoidCallback onTap;
  SkillButtonWidget(
      {Key? key,
      required this.label,
      required this.onTap,
      required this.currentSkill})
      : assert(["flutter", "angular", "difícil", "perito"].contains(label)),
        super(key: key);

  final config = {
    "flutter": {
      "color": AppColors.levelButtonFacil,
      "borderColor": AppColors.levelButtonBorderFacil,
      "fontColor": AppColors.levelButtonTextFacil
    },
    "angular": {
      "color": AppColors.levelButtonMedio,
      "borderColor": AppColors.levelButtonBorderMedio,
      "fontColor": AppColors.levelButtonTextMedio
    },
    "difícil": {
      "color": AppColors.levelButtonDificil,
      "borderColor": AppColors.levelButtonBorderDificil,
      "fontColor": AppColors.levelButtonTextDificil
    },
    "perito": {
      "color": AppColors.levelButtonPerito,
      "borderColor": AppColors.levelButtonBorderPerito,
      "fontColor": AppColors.levelButtonTextPerito
    },
  };

  Color get color => config[label]!['color']!;
  Color get borderColor => config[label]!['borderColor']!;
  Color get fontColor => config[label]!['fontColor']!;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
          child: Text(
            label.capitalize(),
            style: GoogleFonts.notoSans(
                color: label == currentSkill
                    ? fontColor
                    : AppColors.darkGrey.withOpacity(0.4),
                fontSize: 13),
          ),
        ),
        decoration: BoxDecoration(
          color: label == currentSkill
              ? color
              : AppColors.lightGrey.withOpacity(0.2),
          border: Border.fromBorderSide(
            BorderSide(
                color: label == currentSkill
                    ? borderColor
                    : AppColors.grey.withOpacity(0.3)),
          ),
          borderRadius: BorderRadius.circular(28),
        ),
      ),
    );
  }
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1)}";
  }
}
