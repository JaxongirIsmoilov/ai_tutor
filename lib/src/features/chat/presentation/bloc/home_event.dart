part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {}

class HomeInitialEvent extends HomeEvent{
  BuildContext context;
  HomeInitialEvent({required this.context});

}
