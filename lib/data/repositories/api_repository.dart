import 'package:cek_ongkir/data/datasource/api_provider.dart';
import 'package:cek_ongkir/data/model/city_model.dart';
import 'package:cek_ongkir/data/model/cost_model.dart';
import 'package:cek_ongkir/data/model/news_model.dart';
import 'package:cek_ongkir/data/model/province_model.dart';

class ApiRepository {
  final provider = ApiProvider();

  Future<ProvinceModel> fetchProvinceList() => provider.fetchProvinceList();

  Future<CityModel> fetchCityList() => provider.fetchCityList();

  Future<CostModel> fetchCostList({
    required String origin,
    required String destination,
    required int weight,
    required String courier,
  }) =>
      provider.fetchCostList(
        origin: origin,
        destination: destination,
        weight: weight,
        courier: courier,
      );

  Future<NewsModel> fetchNews() => provider.fetchNews();
}

class NetworkError extends Error {}
