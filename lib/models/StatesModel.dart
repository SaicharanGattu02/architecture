class Statesmodel {
  final String name;
  final String stateCode;

  Statesmodel({
    required this.name,
    required this.stateCode,
  });

  factory Statesmodel.fromJson(Map<String, dynamic> json) {
    return Statesmodel(
      name: json['name'],
      stateCode: json['state_code'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'state_code': stateCode,
    };
  }
}
