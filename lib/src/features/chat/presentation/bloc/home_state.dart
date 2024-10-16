part of 'home_bloc.dart';

@freezed
class HomeState with _$HomeState {
  const factory HomeState({
    String? question,
    File? speechAnswer,
    @Default(false) bool isGettingQuestion,
  }) = _HomeState;
}

