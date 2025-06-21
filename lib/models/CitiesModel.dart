class Citiesmodel {
  final String name;
  final String stateCode;

  Citiesmodel({
    required this.name,
    required this.stateCode,
  });

  factory Citiesmodel.fromJson(Map<String, dynamic> json) {
    return Citiesmodel(
      name: json['name'],
      stateCode: json['Cities_code'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'Cities_code': stateCode,
    };
  }
}