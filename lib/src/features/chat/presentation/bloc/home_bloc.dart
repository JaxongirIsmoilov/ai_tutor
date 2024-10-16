import 'dart:async';
import 'dart:io';

import 'package:ai_tutor/src/core/di/di.dart';
import 'package:ai_tutor/src/features/chat/data/models/remote/request/voice_answer.dart';
import 'package:ai_tutor/src/features/chat/domain/usecase/answer_question_usecase.dart';
import 'package:ai_tutor/src/features/chat/domain/usecase/answer_voice_usecase.dart';
import 'package:ai_tutor/src/features/chat/domain/usecase/get_speech_usecase.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/services/hive_service.dart';
import '../../domain/usecase/start_exam_usecase.dart';

part 'home_bloc.freezed.dart';
part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeState()) {
    on<StartQuizEvent>(_startQuiz);
    on<AnswerQuestionEvent>(_answerQuestions);
    on<AnswerVoiceQuestion>(_answerVoiceQuestions);
    on<GetSpeechEvent>(_getSpeech);
  }

  Future<void> _startQuiz(StartQuizEvent event, Emitter<HomeState> emit) async {
    final startQuizUseCase = di<StartExamCase>();
    emit(state.copyWith(isGettingQuestion: true));
     await startQuizUseCase.execute(context: event.context).then(
          (value) => value.fold(
            (l) => emit(
              state.copyWith(isGettingQuestion: false),
            ),
            (r){
              HiveService.saveThreadId(r.threadId);
              HiveService.saveUserId(r.id);
              emit(state.copyWith(isGettingQuestion: false, question: r.text),);
            },
          ),
        );
  }

  Future<void> _answerQuestions(AnswerQuestionEvent event, Emitter<HomeState> emit) async {
    final answerQuestions = di<AnswerQuestionCase>();
    final threadId = await HiveService.getThreadId();
    emit(state.copyWith(isGettingQuestion: true));
     answerQuestions.execute(context: event.context, text: event.text, threadId: threadId).then(
          (value) => value.fold(
            (l) => emit(
          state.copyWith(isGettingQuestion: false),
        ),
            (r) => emit(
          state.copyWith(question: r.text, isGettingQuestion: false),
        ),
      ),
    );



  }

  FutureOr<void> _answerVoiceQuestions(AnswerVoiceQuestion event, Emitter<HomeState> emit) async{
    final answerVoiceQuestions = di<AnswerVoiceCase>();
    final threadId = await HiveService.getThreadId();
    emit(state.copyWith(isGettingQuestion: true));
    answerVoiceQuestions.execute(context: event.context, answer: VoiceAnswer(voice: event.voice, threadId: threadId)).then(
          (value) => value.fold(
            (l) => emit(
          state.copyWith(isGettingQuestion: false),
        ),
            (r) => emit(
          state.copyWith(question: r.text, isGettingQuestion: false),
        ),
      ),
    );
  }

  FutureOr<void> _getSpeech(GetSpeechEvent event, Emitter<HomeState> emit) async{
    final getSpeech = di<GetSpeechCase>();
    final userId = await HiveService.getUserId();
    emit(state.copyWith(isGettingQuestion: true));
    getSpeech.execute(context: event.context, id: userId).then(
          (value) => value.fold(
            (l) => emit(
          state.copyWith(isGettingQuestion: false),
        ),
            (r) => emit(
          state.copyWith(speechAnswer: r, isGettingQuestion: false),
        ),
      ),
    );
  }
}
