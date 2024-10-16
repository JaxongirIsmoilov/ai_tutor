part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {}

class StartQuizEvent extends HomeEvent{
  final BuildContext context;

  StartQuizEvent(this.context);
}

class AnswerQuestionEvent extends HomeEvent{
  final BuildContext context;
  final String text;

  AnswerQuestionEvent(this.context, this.text);
}

class AnswerVoiceQuestion extends HomeEvent{
  final BuildContext context;
  final File voice;

  AnswerVoiceQuestion(this.context, this.voice);
}

class GetSpeechEvent extends HomeEvent{
  final BuildContext context;

  GetSpeechEvent(this.context);
}