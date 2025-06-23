class VerifyOtpModel {
  bool? status;
  String? message;
  int? companyId;
  String? companyEmail;

  VerifyOtpModel(
      {this.status, this.message, this.companyId, this.companyEmail});

  VerifyOtpModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    companyId = json['company_id'];
    companyEmail = json['company_email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['company_id'] = this.companyId;
    data['company_email'] = this.companyEmail;
    return data;
  }
}
