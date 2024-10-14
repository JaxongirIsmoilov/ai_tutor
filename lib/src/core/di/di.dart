import 'package:ai_tutor/src/features/chat/data/repository/chat_repository_impl.dart';
import 'package:ai_tutor/src/features/chat/domain/repository/chat_repository.dart';
import 'package:get_it/get_it.dart';

final di = GetIt.instance;

setUpDependencies(){

  di.registerLazySingleton<ChatRepository>(() => ChatRepositoryImpl());

}