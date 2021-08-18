import 'dart:convert';

import 'package:DevQuiz/shared/quiz_model.dart';
import 'package:DevQuiz/shared/user_model.dart';
import 'package:flutter/services.dart';
import 'dart:developer';

class HomeRepository {
  Future<UserModel> getUser() async {
    final response = await rootBundle.loadString("assets/database/user.json");
    final user = UserModel.fromJson(response);
    return user;
  }

  Future<List<QuizModel>> getQuizzes(skill) async {
    final response =
        await rootBundle.loadString("assets/database/quizzes.json");
    final list = jsonDecode(response) as List;
    var quizzes = list
        .map((e) => QuizModel.fromMap(e))
        .where((element) => element.level == skill)
        .toList();
    // quizzes = quizzes.where((element) => element.level == 'angular').toList();
    return quizzes;
  }
}
