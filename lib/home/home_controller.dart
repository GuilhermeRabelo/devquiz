import 'package:DevQuiz/home/home_repository.dart';
import 'package:DevQuiz/home/home_state.dart';
import 'package:DevQuiz/shared/quiz_model.dart';
import 'package:DevQuiz/shared/user_model.dart';
import 'package:flutter/cupertino.dart';

class HomeController {
  final stateNotifier = ValueNotifier<HomeState>(HomeState.empty);
  set state(HomeState state) => stateNotifier.value = state;
  HomeState get state => stateNotifier.value;

  UserModel? user;
  List<QuizModel>? quizzes;
  int questionsLength = 0;
  int questionsAwnsersLength = 0;

  final repository = HomeRepository();

  void getUser() async {
    state = HomeState.loading;
    user = await repository.getUser();
    this.getQuizzes('angular');
  }

  void getQuizzes(skill) async {
    if (state != HomeState.loading) {
      state = HomeState.loadingQuestion;
    }
    Future.delayed(Duration(seconds: 2), () async {
      quizzes = await repository.getQuizzes(skill);
      questionsAwnsersLength = 0;
      questionsLength = 0;
      quizzes!.forEach((element) {
        questionsAwnsersLength += element.questionAnswered;
        questionsLength += element.questions.length;
      });
      state = HomeState.sucess;
    });
  }
}
