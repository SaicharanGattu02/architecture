class ActiveSubscriptionModel {
  bool? status;
  String? message;
  List<Data>? data;
  int? upcomingPlansCount;

  ActiveSubscriptionModel(
      {this.status, this.message, this.data, this.upcomingPlansCount});

  ActiveSubscriptionModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    upcomingPlansCount = json['upcoming_plans_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['upcoming_plans_count'] = this.upcomingPlansCount;
    return data;
  }
}

class Data {
  int? id;
  String? name;
  String? description;
  String? price;
  int? duration;
  String? createdAt;
  String? updatedAt;
  bool? planActive;

  Data(
      {this.id,
        this.name,
        this.description,
        this.price,
        this.duration,
        this.createdAt,
        this.updatedAt,
        this.planActive});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    price = json['price'];
    duration = json['duration'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    planActive = json['plan_active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['price'] = this.price;
    data['duration'] = this.duration;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['plan_active'] = this.planActive;
    return data;
  }
}
