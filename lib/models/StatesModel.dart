class StatesListModel {
  List<StatesModel> states;

  StatesListModel({required this.states});

  factory StatesListModel.fromJson(List<dynamic> json) {
    return StatesListModel(
      states: json.map((e) => StatesModel.fromJson(e)).toList(),
    );
  }
}

class StatesModel {
  String? name;
  String? stateCode;

  StatesModel({this.name, this.stateCode});

  StatesModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    stateCode = json['state_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['state_code'] = this.stateCode;
    return data;
  }
}
