class VerifyLogInOtpModel {
  bool? status;
  String? message;
  String? accessToken;
  String? tokenType;
  int? expiresIn;
  Data? data;

  VerifyLogInOtpModel(
      {this.status,
        this.message,
        this.accessToken,
        this.tokenType,
        this.expiresIn,
        this.data});

  VerifyLogInOtpModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    accessToken = json['access_token'];
    tokenType = json['token_type'];
    expiresIn = json['expires_in'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['access_token'] = this.accessToken;
    data['token_type'] = this.tokenType;
    data['expires_in'] = this.expiresIn;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? id;
  String? companyName;
  String? companyEmail;
  String? contactPersonName;
  String? establishedYear;
  String? state;
  String? location;
  String? logo;
  String? coverPhoto;
  bool? emailVerified;
  String? aboutCompany;
  String? industryType;
  int? yearsOfExperience;
  int? numberOfProjects;
  String? contactNumber;
  String? whatsappNumber;
  List<String>? specializations;
  String? portfolio;
  String? createdAt;
  String? updatedAt;
  bool? subscriber;

  Data(
      {this.id,
        this.companyName,
        this.companyEmail,
        this.contactPersonName,
        this.establishedYear,
        this.state,
        this.location,
        this.logo,
        this.coverPhoto,
        this.emailVerified,
        this.aboutCompany,
        this.industryType,
        this.yearsOfExperience,
        this.numberOfProjects,
        this.contactNumber,
        this.whatsappNumber,
        this.specializations,
        this.portfolio,
        this.createdAt,
        this.updatedAt,
        this.subscriber});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    companyName = json['company_name'];
    companyEmail = json['company_email'];
    contactPersonName = json['contact_person_name'];
    establishedYear = json['established_year'];
    state = json['state'];
    location = json['location'];
    logo = json['logo'];
    coverPhoto = json['cover_photo'];
    emailVerified = json['email_verified'];
    aboutCompany = json['about_company'];
    industryType = json['industry_type'];
    yearsOfExperience = json['years_of_experience'];
    numberOfProjects = json['number_of_projects'];
    contactNumber = json['contact_number'];
    whatsappNumber = json['whatsapp_number'];
    specializations = json['specializations'] != null
        ? List<String>.from(json['specializations'])
        : [];

    portfolio = json['portfolio'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    subscriber = json['subscriber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['company_name'] = this.companyName;
    data['company_email'] = this.companyEmail;
    data['contact_person_name'] = this.contactPersonName;
    data['established_year'] = this.establishedYear;
    data['state'] = this.state;
    data['location'] = this.location;
    data['logo'] = this.logo;
    data['cover_photo'] = this.coverPhoto;
    data['email_verified'] = this.emailVerified;
    data['about_company'] = this.aboutCompany;
    data['industry_type'] = this.industryType;
    data['years_of_experience'] = this.yearsOfExperience;
    data['number_of_projects'] = this.numberOfProjects;
    data['contact_number'] = this.contactNumber;
    data['whatsapp_number'] = this.whatsappNumber;
    data['specializations'] = this.specializations;
    data['portfolio'] = this.portfolio;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['subscriber'] = this.subscriber;
    return data;
  }
}
