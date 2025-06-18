class Activesubscriptionmodel {
  final bool status;
  final Plan data;

  Activesubscriptionmodel({
    required this.status,
    required this.data,
  });

  factory Activesubscriptionmodel.fromJson(Map<String, dynamic> json) {
    return Activesubscriptionmodel(
      status: json['status'],
      data: Plan.fromJson(json['data']),
    );
  }
}

class Plan {
  final int id;
  final String name;
  final String description;
  final String price;
  final int duration;
  final String createdAt;
  final String updatedAt;

  Plan({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.duration,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Plan.fromJson(Map<String, dynamic> json) {
    return Plan(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      price: json['price'],
      duration: json['duration'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}
