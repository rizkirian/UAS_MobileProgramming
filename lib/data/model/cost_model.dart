class CostModel {
  CostModel({
    required this.rajaongkir,
  });
  late final Rajaongkir rajaongkir;
  String? error;

  CostModel.fromJson(Map<String, dynamic> json) {
    rajaongkir = Rajaongkir.fromJson(json['rajaongkir']);
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['rajaongkir'] = rajaongkir.toJson();
    return data;
  }

  CostModel.withError(String s) {
    error = s;
  }
}

class Rajaongkir {
  Rajaongkir({
    required this.status,
    required this.originDetails,
    required this.destinationDetails,
    required this.results,
  });
  late final Status status;
  late final OriginDetails originDetails;
  late final DestinationDetails destinationDetails;
  late final List<Results> results;

  Rajaongkir.fromJson(Map<String, dynamic> json) {
    status = Status.fromJson(json['status']);
    originDetails = OriginDetails.fromJson(json['origin_details']);
    destinationDetails =
        DestinationDetails.fromJson(json['destination_details']);
    results =
        List.from(json['results']).map((e) => Results.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['status'] = status.toJson();
    data['origin_details'] = originDetails.toJson();
    data['destination_details'] = destinationDetails.toJson();
    data['results'] = results.map((e) => e.toJson()).toList();
    return data;
  }
}

class Status {
  Status({
    required this.code,
    required this.description,
  });
  late final int code;
  late final String description;

  Status.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['code'] = code;
    data['description'] = description;
    return data;
  }
}

class OriginDetails {
  OriginDetails({
    required this.cityId,
    required this.provinceId,
    required this.province,
    required this.type,
    required this.cityName,
    required this.postalCode,
  });
  late final String cityId;
  late final String provinceId;
  late final String province;
  late final String type;
  late final String cityName;
  late final String postalCode;

  OriginDetails.fromJson(Map<String, dynamic> json) {
    cityId = json['city_id'];
    provinceId = json['province_id'];
    province = json['province'];
    type = json['type'];
    cityName = json['city_name'];
    postalCode = json['postal_code'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['city_id'] = cityId;
    data['province_id'] = provinceId;
    data['province'] = province;
    data['type'] = type;
    data['city_name'] = cityName;
    data['postal_code'] = postalCode;
    return data;
  }
}

class DestinationDetails {
  DestinationDetails({
    required this.cityId,
    required this.provinceId,
    required this.province,
    required this.type,
    required this.cityName,
    required this.postalCode,
  });
  late final String cityId;
  late final String provinceId;
  late final String province;
  late final String type;
  late final String cityName;
  late final String postalCode;

  DestinationDetails.fromJson(Map<String, dynamic> json) {
    cityId = json['city_id'];
    provinceId = json['province_id'];
    province = json['province'];
    type = json['type'];
    cityName = json['city_name'];
    postalCode = json['postal_code'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['city_id'] = cityId;
    data['province_id'] = provinceId;
    data['province'] = province;
    data['type'] = type;
    data['city_name'] = cityName;
    data['postal_code'] = postalCode;
    return data;
  }
}

class Results {
  Results({
    required this.code,
    required this.name,
    required this.costs,
  });
  late final String code;
  late final String name;
  late final List<Costs> costs;

  Results.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    name = json['name'];
    costs = List.from(json['costs']).map((e) => Costs.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['code'] = code;
    data['name'] = name;
    data['costs'] = costs.map((e) => e.toJson()).toList();
    return data;
  }
}

class Costs {
  Costs({
    required this.service,
    required this.description,
    required this.cost,
  });
  late final String service;
  late final String description;
  late final List<Cost> cost;

  Costs.fromJson(Map<String, dynamic> json) {
    service = json['service'];
    description = json['description'];
    cost = List.from(json['cost']).map((e) => Cost.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['service'] = service;
    data['description'] = description;
    data['cost'] = cost.map((e) => e.toJson()).toList();
    return data;
  }
}

class Cost {
  Cost({
    required this.value,
    required this.etd,
    required this.note,
  });
  late final int value;
  late final String etd;
  late final String note;

  Cost.fromJson(Map<String, dynamic> json) {
    value = json['value'];
    etd = json['etd'];
    note = json['note'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['value'] = value;
    data['etd'] = etd;
    data['note'] = note;
    return data;
  }
}
