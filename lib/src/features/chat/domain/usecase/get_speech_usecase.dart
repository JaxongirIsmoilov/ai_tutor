import 'dart:io';

import 'package:ai_tutor/src/features/chat/domain/repository/chat_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';

import '../../../../core/http/failure.dart';

abstract class GetSpeechCase{
  Future<Either<Failure, File>> execute({required BuildContext context, required String id});
}

class GetSpeechUseCase extends GetSpeechCase{

  final ChatRepository _chatRepository;


  GetSpeechUseCase(this._chatRepository);

  @override
  Future<Either<Failure, File>> execute({required BuildContext context, required String id}) async {
    return await _chatRepository.getSpeech(context: context, id: id);
  }

}