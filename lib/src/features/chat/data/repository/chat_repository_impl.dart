import 'dart:io';

import 'package:ai_tutor/src/core/constants/api_constants.dart';
import 'package:ai_tutor/src/core/http/api_service.dart';
import 'package:ai_tutor/src/core/http/failure.dart';
import 'package:ai_tutor/src/features/chat/data/models/remote/request/voice_answer.dart';
import 'package:ai_tutor/src/features/chat/data/models/remote/response/response_model.dart';
import 'package:ai_tutor/src/features/chat/domain/repository/chat_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../../../core/http/error_handler.dart';

class ChatRepositoryImpl extends ChatRepository{
  
  
  @override
  Future<Either<Failure, ResponseModel>> answerQuestion({required BuildContext context, required String text, required String threadId}) async {
    try{
      final response = await ApiService.post(endPoint: ApiConstants.answerQuestion, params: {
        'text' : text,
        'thread_id' : threadId
      });
      return Right(response.data as ResponseModel);
    }catch(e){
      return Left(ErrorHandler.handle(e).failure);
    }
  }

  @override
  Future<Either<Failure, ResponseModel>> answerVoice({required BuildContext context, required VoiceAnswer answer}) async {
    try{
      final formData = FormData.fromMap({
        'file' : answer.voice,
        'thread_id' : answer.threadId
      });
      final response = await ApiService.post(endPoint: ApiConstants.answerVoiceQuestion, params: formData);
      return Right(response.data as ResponseModel);
    }catch(error){
      return Left(ErrorHandler.handle(error).failure);
    }
  }

  @override
  Future<Either<Failure, File>> getSpeech({required BuildContext context, required String id}) async {
    try{
      final response = await ApiService.get(endPoint: '/speaking/speech/${id}');

      return Right(response.data as File);
    }catch(error){
      return Left(ErrorHandler.handle(error).failure);
    }
   }

  @override
  Future<Either<Failure, ResponseModel>> startExam({required BuildContext context}) async {
    try{
      final response = await ApiService.post(endPoint: ApiConstants.startExam);
      return Right(response.data as ResponseModel);
    }catch(error){
      return Left(ErrorHandler.handle(error).failure);
    }
  }
  
  
  
  
}