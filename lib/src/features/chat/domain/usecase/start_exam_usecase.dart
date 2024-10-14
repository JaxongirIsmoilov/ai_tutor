import 'package:ai_tutor/src/features/chat/domain/repository/chat_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';

import '../../../../core/http/failure.dart';
import '../../data/models/remote/response/response_model.dart';

abstract class StartExamCase {
  Future<Either<Failure, ResponseModel>> execute({required BuildContext context});
}

class StartExamUseCase extends StartExamCase{

  final ChatRepository _chatRepository;


  StartExamUseCase(this._chatRepository);

  @override
  Future<Either<Failure, ResponseModel>> execute({required BuildContext context}) async {
   return await _chatRepository.startExam(context: context);
  }

}

