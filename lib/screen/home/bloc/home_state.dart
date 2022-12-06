part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {}

class NewsListLoading extends HomeState {}

class NewsListLoaded extends HomeState {
  final NewsModel newsModel;
  const NewsListLoaded({required this.newsModel});

  @override
  List<Object> get props => [newsModel];
}

class NewsListError extends HomeState {
  final String message;
  const NewsListError({required this.message});

  @override
  List<Object> get props => [message];
}

class CityListLoading extends HomeState {}

class CityListLoaded extends HomeState {
  final CityModel cityModel;

  const CityListLoaded({required this.cityModel});

  @override
  List<Object> get props => [cityModel];
}

class CityListError extends HomeState {
  final String message;

  const CityListError({required this.message});

  @override
  List<Object> get props => [message];
}
