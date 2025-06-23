class GetArchitectsModel {
  bool? status;
  PaginatedData? data;

  GetArchitectsModel({this.status, this.data});

  GetArchitectsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? PaginatedData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class PaginatedData {
  int? currentPage;
  List<ArchitectData>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  List<Links>? links;
  String? nextPageUrl;
  String? path;
  int? perPage;
  String? prevPageUrl;
  int? to;
  int? total;

  PaginatedData({
    this.currentPage,
    this.data,
    this.firstPageUrl,
    this.from,
    this.lastPage,
    this.lastPageUrl,
    this.links,
    this.nextPageUrl,
    this.path,
    this.perPage,
    this.prevPageUrl,
    this.to,
    this.total,
  });

  PaginatedData.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <ArchitectData>[];
      json['data'].forEach((v) {
        data!.add(ArchitectData.fromJson(v));
      });
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    if (json['links'] != null) {
      links = <Links>[];
      json['links'].forEach((v) {
        links!.add(Links.fromJson(v));
      });
    }
    nextPageUrl = json['next_page_url'];
    path = json['path'];
    perPage = json['per_page'] is String ? int.tryParse(json['per_page']) : json['per_page'];
    prevPageUrl = json['prev_page_url'];
    to = json['to'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['current_page'] = currentPage;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['first_page_url'] = firstPageUrl;
    data['from'] = from;
    data['last_page'] = lastPage;
    data['last_page_url'] = lastPageUrl;
    if (links != null) {
      data['links'] = links!.map((v) => v.toJson()).toList();
    }
    data['next_page_url'] = nextPageUrl;
    data['path'] = path;
    data['per_page'] = perPage;
    data['prev_page_url'] = prevPageUrl;
    data['to'] = to;
    data['total'] = total;
    return data;
  }
}

class ArchitectData {
  int? id;
  String? companyName;
  String? companyEmail;
  String? contactPersonName;
  String? establishedYear;
  String? state;
  String? location;
  String? logo;
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

  ArchitectData({
    this.id,
    this.companyName,
    this.companyEmail,
    this.contactPersonName,
    this.establishedYear,
    this.state,
    this.location,
    this.logo,
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
  });

  ArchitectData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    companyName = json['company_name'];
    companyEmail = json['company_email'];
    contactPersonName = json['contact_person_name'];
    establishedYear = json['established_year'];
    state = json['state'];
    location = json['location'];
    logo = json['logo'];
    emailVerified = json['email_verified'];
    aboutCompany = json['about_company'];
    industryType = json['industry_type'];
    yearsOfExperience = json['years_of_experience'];
    numberOfProjects = json['number_of_projects'];
    contactNumber = json['contact_number'];
    whatsappNumber = json['whatsapp_number'];
    specializations = json['specializations'] != null
        ? List<String>.from(json['specializations'])
        : null;
    portfolio = json['portfolio'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['company_name'] = companyName;
    data['company_email'] = companyEmail;
    data['contact_person_name'] = contactPersonName;
    data['established_year'] = establishedYear;
    data['state'] = state;
    data['location'] = location;
    data['logo'] = logo;
    data['email_verified'] = emailVerified;
    data['about_company'] = aboutCompany;
    data['industry_type'] = industryType;
    data['years_of_experience'] = yearsOfExperience;
    data['number_of_projects'] = numberOfProjects;
    data['contact_number'] = contactNumber;
    data['whatsapp_number'] = whatsappNumber;
    data['specializations'] = specializations;
    data['portfolio'] = portfolio;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class Links {
  String? url;
  String? label;
  bool? active;

  Links({this.url, this.label, this.active});

  Links.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    label = json['label'];
    active = json['active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['url'] = url;
    data['label'] = label;
    data['active'] = active;
    return data;
  }
}
