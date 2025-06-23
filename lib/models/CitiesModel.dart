class CityListModel {
  final List<CityModel> cities;

  CityListModel({required this.cities});

  factory CityListModel.fromJson(List<dynamic> jsonList) {
    return CityListModel(
      cities: jsonList.map((e) => CityModel.fromJson(e)).toList(),
    );
  }

  List<dynamic> toJson() {
    return cities.map((e) => e.toJson()).toList();
  }
}
class CityModel {
  final String name;

  CityModel({required this.name});

  factory CityModel.fromJson(dynamic json) {
    return CityModel(name: json.toString());
  }

  Map<String, dynamic> toJson() {
    return {'name': name};
  }
}

