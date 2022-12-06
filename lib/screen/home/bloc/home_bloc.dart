import 'package:bloc/bloc.dart';
import 'package:cek_ongkir/data/model/city_model.dart';
import 'package:cek_ongkir/data/model/news_model.dart';
import 'package:cek_ongkir/data/repositories/api_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<HomeEvent>((event, emit) {
      // TODO: implement event handler
    });

    final ApiRepository apiRepository = ApiRepository();

    on<GetCityList>((event, emit) async {
      emit(CityListLoading());
      try {
        final CityModel cityModel = await apiRepository.fetchCityList();
        emit(CityListLoaded(cityModel: cityModel));
      } catch (e) {
        emit(CityListError(message: e.toString()));
      }
    });

    on<GetNewsList>((event, emit) async {
      emit(NewsListLoading());
      try {
        final NewsModel newsModel = await apiRepository.fetchNews();
        emit(NewsListLoaded(newsModel: newsModel));
      } catch (e) {
        emit(NewsListError(message: e.toString()));
      }
    });
  }
}
