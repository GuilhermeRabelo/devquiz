import 'package:DevQuiz/core/app_colors.dart';
import 'package:DevQuiz/core/app_text_styles.dart';
import 'package:flutter/material.dart';

class AnswerWidget extends StatelessWidget {
  final String title;
  final bool isCorrect;
  final bool isSelected;
  final bool isConfirmed;
  final bool disabled;
  final VoidCallback onTap;
  const AnswerWidget(
      {Key? key,
      required this.title,
      required this.onTap,
      this.isCorrect = false,
      this.isSelected = false,
      this.disabled = false,
      this.isConfirmed = false})
      : super(key: key);

  Color get _selectedCorretColor =>
      isCorrect ? AppColors.darkGreen : AppColors.darkRed;

  Color get _selectedCorretBorder =>
      isCorrect ? AppColors.lightGreen : AppColors.lightRed;

  Color get _selectedCorretColorCard =>
      isCorrect ? AppColors.lightGreen : AppColors.lightRed;

  Color get _selectedCorretBorderCard =>
      isCorrect ? AppColors.green : AppColors.red;

  TextStyle get _selectedCorretTextStyle =>
      isCorrect ? AppTextStyles.bodyDarkGreen : AppTextStyles.bodyDarkRed;

  IconData get _selectedCorretIcon => isCorrect ? Icons.check : Icons.close;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: IgnorePointer(
        ignoring: disabled,
        child: GestureDetector(
          onTap: onTap,
          child: Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: isSelected && isConfirmed
                  ? _selectedCorretColorCard
                  : AppColors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.fromBorderSide(
                BorderSide(
                    color: isSelected && isConfirmed
                        ? _selectedCorretBorderCard
                        : AppColors.border),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: isSelected && isConfirmed
                        ? _selectedCorretTextStyle
                        : AppTextStyles.body,
                  ),
                ),
                Container(
                  height: 24,
                  width: 24,
                  decoration: BoxDecoration(
                    color: isSelected && isConfirmed
                        ? _selectedCorretColor
                        : AppColors.white,
                    borderRadius: BorderRadius.circular(50),
                    border: Border.fromBorderSide(
                      BorderSide(
                          color: isSelected && isConfirmed
                              ? _selectedCorretBorder
                              : AppColors.border),
                    ),
                  ),
                  child: isSelected && !isConfirmed
                      ? Icon(
                          Icons.check,
                          size: 16,
                          color: AppColors.grey,
                        )
                      : (isSelected && isConfirmed)
                          ? Icon(
                              _selectedCorretIcon,
                              size: 16,
                              color: isConfirmed
                                  ? AppColors.white
                                  : AppColors.grey,
                            )
                          : Icon(
                              _selectedCorretIcon,
                              size: 16,
                              color: AppColors.white,
                            ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
