import 'dart:convert';
import 'dart:developer';

import 'package:DevQuiz/shared/question_model.dart';

// enum Level { flutter, angular, dificil, perito }

// extension LevelStringExt on String {
//   Level get parse => {
//         "flutter": Level.flutter,
//         "angular": Level.angular,
//         "dificil": Level.dificil,
//         "perito": Level.perito,
//       }[this]!;
// }

// extension LevelExt on Level {
//   String get parse => {
//         Level.flutter: "flutter",
//         Level.angular: "angular",
//         Level.dificil: "dificil",
//         Level.perito: "perito",
//       }[this]!;
// }

class QuizModel {
  final String title;
  final List<QuestionModel> questions;
  final int questionAnswered;
  final String image;
  final String level;
  // final Level level;

  QuizModel({
    required this.title,
    required this.questions,
    this.questionAnswered = 0,
    required this.image,
    required this.level,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'questions': questions.map((x) => x.toMap()).toList(),
      'questionAnswered': questionAnswered,
      'image': image,
      'level': level,
      // 'level': level.parse,
    };
  }

  factory QuizModel.fromMap(Map<String, dynamic> map) {
    return QuizModel(
      title: map['title'],
      questions: List<QuestionModel>.from(
          map['questions']?.map((x) => QuestionModel.fromMap(x))),
      questionAnswered: map['questionAnswered'],
      image: map['image'],
      level: map['level'],
      // level: map['level'].toString().parse,
    );
  }

  String toJson() => json.encode(toMap());

  factory QuizModel.fromJson(String source) =>
      QuizModel.fromMap(json.decode(source));
}
