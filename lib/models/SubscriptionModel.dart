class SubscriptionModel {
  final bool status;
  final List<SubscriptionPlan> data;

  SubscriptionModel({
    required this.status,
    required this.data,
  });

  factory SubscriptionModel.fromJson(Map<String, dynamic> json) {
    return SubscriptionModel(
      status: json['status'],
      data: (json['data'] as List)
          .map((item) => SubscriptionPlan.fromJson(item))
          .toList(),
    );
  }
}

class SubscriptionPlan {
  final int id;
  final String name;
  final String description;
  final String price;
  final int duration;
  final DateTime createdAt;
  final DateTime updatedAt;

  SubscriptionPlan({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.duration,
    required this.createdAt,
    required this.updatedAt,
  });

  factory SubscriptionPlan.fromJson(Map<String, dynamic> json) {
    return SubscriptionPlan(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      price: json['price'],
      duration: json['duration'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }
}
