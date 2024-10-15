import 'dart:async';

import 'package:ai_tutor/src/features/chat/data/repository/chat_repository_impl.dart';
import 'package:ai_tutor/src/features/chat/domain/repository/chat_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<HomeInitialEvent>(startquiz);
  }

  FutureOr<void> startquiz(HomeInitialEvent event, Emitter<HomeState> emit) {
    var result=ChatRepositoryImpl().startExam(context: event.context);

  }
}
