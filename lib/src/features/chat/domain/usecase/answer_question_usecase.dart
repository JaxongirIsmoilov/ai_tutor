import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';

import '../../../../core/http/failure.dart';
import '../../data/models/remote/response/response_model.dart';
import '../repository/chat_repository.dart';

abstract class AnswerQuestionCase {
  Future<Either<Failure, ResponseModel>> execute({required BuildContext context, required String text, required String threadId});
}

class AnswerQuestionUseCase extends AnswerQuestionCase{

  final ChatRepository _chatRepository;


  AnswerQuestionUseCase(this._chatRepository);

  @override
  Future<Either<Failure, ResponseModel>> execute({required BuildContext context, required String text, required String threadId}) async {
    return await _chatRepository.answerQuestion(context: context, text: text, threadId: threadId);
  }

}