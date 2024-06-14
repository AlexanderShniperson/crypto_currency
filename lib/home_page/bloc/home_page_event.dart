part of 'home_page_bloc.dart';

abstract class HomePageEvent {
  const HomePageEvent();
}

class LoadAllRatesEvent extends HomePageEvent {}

class LoadNextPageEvent extends HomePageEvent {}
