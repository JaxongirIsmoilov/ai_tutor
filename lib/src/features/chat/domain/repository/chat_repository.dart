import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:ai_tutor/src/core/http/failure.dart';
import 'package:ai_tutor/src/features/chat/data/models/remote/response/response_model.dart';
import 'package:flutter/material.dart';

import '../../data/models/remote/request/voice_answer.dart';

abstract class ChatRepository{
  Future<Either<Failure, ResponseModel>> startExam({required BuildContext context});
  Future<Either<Failure, ResponseModel>> answerQuestion({required BuildContext context, required String text, required String threadId});
  Future<Either<Failure, ResponseModel>> answerVoice({required BuildContext context, required VoiceAnswer answer});
  Future<Either<Failure, File>> getSpeech({required BuildContext context, required String id});

}