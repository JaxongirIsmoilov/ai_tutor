import 'package:ai_tutor/src/features/chat/data/repository/chat_repository_impl.dart';
import 'package:ai_tutor/src/features/chat/domain/repository/chat_repository.dart';
import 'package:ai_tutor/src/features/chat/domain/usecase/answer_question_usecase.dart';
import 'package:ai_tutor/src/features/chat/domain/usecase/answer_voice_usecase.dart';
import 'package:ai_tutor/src/features/chat/domain/usecase/get_speech_usecase.dart';
import 'package:ai_tutor/src/features/chat/domain/usecase/start_exam_usecase.dart';
import 'package:get_it/get_it.dart';

final di = GetIt.instance;

setUpDependencies(){

  di.registerLazySingleton(() => ChatRepositoryImpl());
  di.registerFactory<ChatRepository>(() => ChatRepositoryImpl());

  final chatRepository = di.get<ChatRepository>();

  di.registerFactory<StartExamCase>(() => StartExamUseCase(chatRepository));
  di.registerFactory<AnswerQuestionCase>(() => AnswerQuestionUseCase(chatRepository));
  di.registerFactory<AnswerVoiceCase>(() => AnswerVoiceUseCase(chatRepository));
  di.registerFactory<GetSpeechCase>(() => GetSpeechUseCase(chatRepository));
}