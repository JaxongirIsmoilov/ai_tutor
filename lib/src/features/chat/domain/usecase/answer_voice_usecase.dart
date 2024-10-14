import 'package:ai_tutor/src/features/chat/domain/repository/chat_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';

import '../../../../core/http/failure.dart';
import '../../data/models/remote/request/voice_answer.dart';
import '../../data/models/remote/response/response_model.dart';

abstract class AnswerVoiceCase {
  Future<Either<Failure, ResponseModel>> execute({required BuildContext context, required VoiceAnswer answer});
}

class AnswerVoiceUseCase extends AnswerVoiceCase{

  final ChatRepository _chatRepository;


  AnswerVoiceUseCase(this._chatRepository);

  @override
  Future<Either<Failure, ResponseModel>> execute({required BuildContext context, required VoiceAnswer answer}) async {
    return await _chatRepository.answerVoice(context: context, answer: answer);
  }

}