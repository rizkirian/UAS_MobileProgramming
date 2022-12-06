import 'package:cek_ongkir/config/Config.dart';
import 'package:cek_ongkir/data/model/city_model.dart';
import 'package:cek_ongkir/data/model/cost_model.dart';
import 'package:cek_ongkir/data/model/news_model.dart';
import 'package:cek_ongkir/data/model/province_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class ApiProvider {
  final Dio dio = Dio();

  Future<ProvinceModel> fetchProvinceList() async {
    try {
      final Response response = await dio.get(
        '${Config.baseUrl}/province',
        options: Options(
          headers: {
            'key': Config.apiKey,
          },
        ),
      );

      return ProvinceModel.fromJson(response.data);
    } catch (error, stackTrace) {
      debugPrint("Exception occured: $error stackTrace: $stackTrace");
      return ProvinceModel.withError("Data not found / connection issue");
    }
  }

  Future<CityModel> fetchCityList() async {
    try {
      final Response response = await dio.get(
        '${Config.baseUrl}/city',
        options: Options(
          headers: {
            'key': Config.apiKey,
          },
        ),
      );

      return CityModel.fromJson(response.data);
    } catch (error, stackTrace) {
      debugPrint("Exception occured: $error stackTrace: $stackTrace");
      return CityModel.withError("Data not found / connection issue");
    }
  }

  Future<CostModel> fetchCostList({
    required String origin,
    required String destination,
    required int weight,
    required String courier,
  }) async {
    try {
      final Response response = await dio.post(
        '${Config.baseUrl}/cost',
        options: Options(
          headers: {
            'key': Config.apiKey,
          },
        ),
        data: {
          'origin': origin,
          'destination': destination,
          'weight': weight,
          'courier': courier,
        },
      );

      return CostModel.fromJson(response.data);
    } catch (error, stackTrace) {
      debugPrint("Exception occured: $error stackTrace: $stackTrace");
      return CostModel.withError("Data not found / connection issue");
    }
  }

  Future<NewsModel> fetchNews() async {
    try {
      final Response response = await dio.get(Config.baseUrlNews);
      return NewsModel.fromJson(response.data);
    } catch (error, stackTrace) {
      debugPrint("Exception occured : $error stackTrace $stackTrace");
      return NewsModel.withError("Data not found");
    }
  }
}
