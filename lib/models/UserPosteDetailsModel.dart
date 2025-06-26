class UserPosteDetailsModel {
  bool? status;
  String? message;
  Data? data;

  UserPosteDetailsModel({this.status, this.message, this.data});

  UserPosteDetailsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? state;
  String? location;
  String? landDetails;
  String? timeFrame;
  String? createdAt;
  String? updatedAt;

  Data(
      {this.id,
        this.name,
        this.email,
        this.phone,
        this.state,
        this.location,
        this.landDetails,
        this.timeFrame,
        this.createdAt,
        this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    state = json['state'];
    location = json['location'];
    landDetails = json['land_details'];
    timeFrame = json['time_frame'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['state'] = this.state;
    data['location'] = this.location;
    data['land_details'] = this.landDetails;
    data['time_frame'] = this.timeFrame;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
