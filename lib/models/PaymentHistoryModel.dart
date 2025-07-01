class PaymentHistoryModel {
  bool? status;
  String? message;
  List<Data>? data;
  bool? activePlanExists;
  int? upcomingPlansCount;
  int? expiredPlansCount;

  PaymentHistoryModel(
      {this.status,
        this.message,
        this.data,
        this.activePlanExists,
        this.upcomingPlansCount,
        this.expiredPlansCount});

  PaymentHistoryModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    activePlanExists = json['active_plan_exists'];
    upcomingPlansCount = json['upcoming_plans_count'];
    expiredPlansCount = json['expired_plans_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['active_plan_exists'] = this.activePlanExists;
    data['upcoming_plans_count'] = this.upcomingPlansCount;
    data['expired_plans_count'] = this.expiredPlansCount;
    return data;
  }
}

class Data {
  int? id;
  int? companyId;
  int? planId;
  String? amount;
  String? paymentMethod;
  String? transactionId;
  String? expireDate;
  String? status;
  String? paidAt;
  String? createdAt;
  String? updatedAt;
  String? planName;
  int? planDurationDays;
  bool? isActive;

  Data(
      {this.id,
        this.companyId,
        this.planId,
        this.amount,
        this.paymentMethod,
        this.transactionId,
        this.expireDate,
        this.status,
        this.paidAt,
        this.createdAt,
        this.updatedAt,
        this.planName,
        this.planDurationDays,
        this.isActive});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    companyId = json['company_id'];
    planId = json['plan_id'];
    amount = json['amount'];
    paymentMethod = json['payment_method'];
    transactionId = json['transaction_id'];
    expireDate = json['expire_date'];
    status = json['status'];
    paidAt = json['paid_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    planName = json['plan_name'];
    planDurationDays = json['plan_duration_days'];
    isActive = json['is_active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['company_id'] = this.companyId;
    data['plan_id'] = this.planId;
    data['amount'] = this.amount;
    data['payment_method'] = this.paymentMethod;
    data['transaction_id'] = this.transactionId;
    data['expire_date'] = this.expireDate;
    data['status'] = this.status;
    data['paid_at'] = this.paidAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['plan_name'] = this.planName;
    data['plan_duration_days'] = this.planDurationDays;
    data['is_active'] = this.isActive;
    return data;
  }
}
