import 'dart:io';
import 'package:architect/models/ActiveSubscriptionmodel.dart';
import 'package:architect/models/SubscriptionModel.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import '../models/ArchitechCityModel.dart';
import '../models/ArchitechProfileModel.dart';
import '../models/ArchitechStatesModel.dart';
import '../models/ArchitectModel.dart';
import '../models/CategoryTypeModel.dart';
import '../models/CitiesModel.dart';
import '../models/PaymentHistoryModel.dart';
import '../models/StatesModel.dart';
import '../models/SuccessModel.dart';
import '../models/UserPosteDetailsModel.dart';
import '../models/UserPostedModel.dart';
import '../models/VerifyLogInOtpModel.dart';
import '../models/VerifyOtpModel.dart';
import 'ApiClient.dart';
import 'api_endpoint_urls.dart';

abstract class RemoteDataSource {
  Future<GetArchitectsModel?> getArchitect(
    String industrialType,
    String location,
  );
  Future<SuccessModel?> registerApi(Map<String, dynamic> data);
  Future<SuccessModel?> addPost(Map<String, dynamic> data);
  Future<SuccessModel?> editPost(Map<String, dynamic> data, id);
  Future<SuccessModel?> deletePost(id);
  Future<SubscriptionModel?> getsubplans();
  Future<List<StatesModel>?> getStates();
  Future<ArchitechStatesModel?> getArchitechStates();
  Future<List<CityModel>?> getCity();
  Future<ArchitechCityModel?> geArchitecttCity();
  Future<CategoryTypeModel?> getArchitectCategoryType(String cities);
  Future<ActiveSubscriptionModel?> getActiveSubplans(int id);
  Future<SuccessModel?> loginOtp(Map<String, dynamic> data);
  Future<SuccessModel?> resendLoginOtp(Map<String, dynamic> data);
  Future<SuccessModel?> resendVerifyCompanyOtp(Map<String, dynamic> data);
  Future<SuccessModel?> createProfile(Map<String, dynamic> data);
  Future<SuccessModel?> updateCompanyProfile(Map<String, dynamic> data);
  Future<VerifyLogInOtpModel?> verifyLoginOtp(Map<String, dynamic> data);
  Future<VerifyOtpModel?> companyVerifyOtp(Map<String, dynamic> data);
  Future<SuccessModel?> createPost(Map<String, dynamic> data);
  Future<UserPostedModel?> getUserPosts();
  Future<UserPosteDetailsModel?> getUserPostDetails(int id);
  Future<ArchitechProfileModel?> getArchitechProfile();
  Future<ArchitechProfileModel?> getArchitechProfileDetails(int id);
  Future<SuccessModel?> ArchitechCompanyAdditionalInfoPost(
    Map<String, dynamic> data,
  );
  Future<SuccessModel?> ArchitechCompanyAdditionalInfoUpdate(
    Map<String, dynamic> data,
  );
  Future<SuccessModel?> createPayment(Map<String, dynamic> data);
  Future<ArchitechProfileModel?> getUserArchitechProfileDetails(int id);
  Future<PaymentHistoryModel?> getArchitechPaymentsHistory(int id);
}

class RemoteDataSourceImpl implements RemoteDataSource {
  Future<FormData> buildFormData(Map<String, dynamic> data) async {
    final formMap = <String, dynamic>{};

    for (final entry in data.entries) {
      final key = entry.key;
      final value = entry.value;

      if (value == null) continue;

      // Handle list of files (e.g., portfolio[])
      if (value is List<File> && key == 'portfolio') {
        formMap.addAll({
          for (int i = 0; i < value.length; i++)
            'portfolio[]': await MultipartFile.fromFile(
              value[i].path,
              filename: value[i].path.split('/').last,
            ),
        });
      } else if (value is List<String> && key == 'specializations') {
        formMap.addAll({for (final item in value) 'specializations[]': item});
      }
      // Handle single file (e.g., document)
      else if (value is File) {
        formMap[key] = await MultipartFile.fromFile(
          value.path,
          filename: value.path.split('/').last,
        );
      }
      // Handle normal fields
      else {
        formMap[key] = value.toString().trim();
      }
    }

    return FormData.fromMap(formMap);
  }

  @override
  Future<SuccessModel?> deletePost(id) async {
    try {
      Response res = await ApiClient.post("${APIEndpointUrls.deletePost}/$id");
      if (res.statusCode == 200) {
        debugPrint('deletePost:${res.data}');
        return SuccessModel.fromJson(res.data);
      } else {
        return null;
      }
    } catch (e) {
      debugPrint('Error deletePost::$e');
      return null;
    }
  }

  @override
  Future<SuccessModel?> editPost(Map<String, dynamic> data, id) async {
    try {
      Response res = await ApiClient.post(
        "${APIEndpointUrls.editPost}/$id",
        data: data,
      );
      if (res.statusCode == 200) {
        debugPrint('editPost:${res.data}');
        return SuccessModel.fromJson(res.data);
      } else {
        return null;
      }
    } catch (e) {
      debugPrint('Error editPost::$e');
      return null;
    }
  }

  @override
  Future<SuccessModel?> addPost(Map<String, dynamic> data) async {
    try {
      Response res = await ApiClient.post(
        "${APIEndpointUrls.addPost}",
        data: data,
      );
      if (res.statusCode == 200) {
        debugPrint('addPost:${res.data}');
        return SuccessModel.fromJson(res.data);
      } else {
        return null;
      }
    } catch (e) {
      debugPrint('Error addPost::$e');
      return null;
    }
  }

  // @override
  // Future<SuccessModel?> loginApi(Map<String, dynamic> data) async {
  //   try {
  //     Response res = await ApiClient.post(
  //       "${APIEndpointUrls.login}",
  //       data: data,
  //     );
  //     if (res.statusCode == 200) {
  //       debugPrint('loginApi:${res.data}');
  //       return SuccessModel.fromJson(res.data);
  //     } else {
  //       return null;
  //     }
  //   } catch (e) {
  //     debugPrint('Error loginApi::$e');
  //     return null;
  //   }
  // }

  @override
  Future<SuccessModel?> registerApi(Map<String, dynamic> data) async {
    try {
      Response res = await ApiClient.post(
        "${APIEndpointUrls.register}",
        data: data,
      );
      if (res.statusCode == 200) {
        debugPrint('registerApi:${res.data}');
        return SuccessModel.fromJson(res.data);
      } else {
        return null;
      }
    } catch (e) {
      debugPrint('Error registerApi::$e');
      return null;
    }
  }

  @override
  Future<SuccessModel?> loginOtp(Map<String, dynamic> data) async {
    try {
      Response res = await ApiClient.post(
        "${APIEndpointUrls.login_otp}?company_email=${data['company_email']}",
      );
      if (res.statusCode == 200) {
        debugPrint('loginOtp:${res.data}');
        return SuccessModel.fromJson(res.data);
      } else {
        return null;
      }
    } catch (e) {
      debugPrint('Error loginOtp::$e');
      return null;
    }
  }

  @override
  Future<SuccessModel?> resendLoginOtp(Map<String, dynamic> data) async {
    try {
      Response res = await ApiClient.post(
        "${APIEndpointUrls.resend_login_otp}?company_email=${data['company_email']}",
      );
      if (res.statusCode == 200) {
        debugPrint('resend Login Otp:${res.data}');
        return SuccessModel.fromJson(res.data);
      } else {
        return null;
      }
    } catch (e) {
      debugPrint('Error resend Login Otp::$e');
      return null;
    }
  }

  @override
  Future<SuccessModel?> resendVerifyCompanyOtp(
    Map<String, dynamic> data,
  ) async {
    try {
      Response res = await ApiClient.post(
        "${APIEndpointUrls.resend_verify_company_otp}?company_email=${data['company_email']}",
      );
      if (res.statusCode == 200) {
        debugPrint('resend Verify Company Otp:${res.data}');
        return SuccessModel.fromJson(res.data);
      } else {
        return null;
      }
    } catch (e) {
      debugPrint('Error resend Verify Company Otp::$e');
      return null;
    }
  }

  @override
  Future<VerifyLogInOtpModel?> verifyLoginOtp(Map<String, dynamic> data) async {
    try {
      Response res = await ApiClient.post(
        "${APIEndpointUrls.verify_login_otp}?company_email=${data["company_email"]}&otp=${data["otp"]}",
      );
      if (res.statusCode == 200) {
        debugPrint('verifyLoginOtp:${res.data}');
        return VerifyLogInOtpModel.fromJson(res.data);
      } else {
        return null;
      }
    } catch (e) {
      debugPrint('Error verifyLoginOtp::$e');
      return null;
    }
  }

  @override
  Future<VerifyOtpModel?> companyVerifyOtp(Map<String, dynamic> data) async {
    print('data:${data}');
    try {
      Response res = await ApiClient.post(
        "${APIEndpointUrls.verify_company_otp}?company_email=${data["company_email"]}&otp=${data["otp"]}",
      );
      if (res.statusCode == 200) {
        debugPrint('verifyLoginOtp:${res.data}');
        return VerifyOtpModel.fromJson(res.data);
      } else {
        return null;
      }
    } catch (e) {
      debugPrint('Error verifyLoginOtp::$e');
      return null;
    }
  }

  @override
  Future<SuccessModel?> createProfile(Map<String, dynamic> data) async {
    try {
      var formdata = await buildFormData(data);
      Response res = await ApiClient.post(
        "${APIEndpointUrls.create_profile}",
        data: formdata,
      );
      if (res.statusCode == 200) {
        debugPrint('createProfile:${res.data}');
        return SuccessModel.fromJson(res.data);
      } else {
        return null;
      }
    } catch (e) {
      debugPrint('Error createProfile::$e');
      return null;
    }
  }

  @override
  Future<SuccessModel?> updateCompanyProfile(Map<String, dynamic> data) async {
    try {
      var formdata = await buildFormData(data);
      Response res = await ApiClient.post(
        "${APIEndpointUrls.update_company_profile}",
        data: formdata,
      );
      if (res.statusCode == 200) {
        debugPrint('updateCompanyProfile:${res.data}');
        return SuccessModel.fromJson(res.data);
      } else {
        return null;
      }
    } catch (e) {
      debugPrint('Error updateCompanyProfile::$e');
      return null;
    }
  }

  @override
  Future<SuccessModel?> createPost(Map<String, dynamic> data) async {
    try {
      Response res = await ApiClient.post(
        "${APIEndpointUrls.create_post}",
        data: data,
      );
      if (res.statusCode == 200) {
        debugPrint('createPost:${res.data}');
        return SuccessModel.fromJson(res.data);
      } else {
        return null;
      }
    } catch (e) {
      debugPrint('Error createPost::$e');
      return null;
    }
  }

  @override
  Future<SuccessModel?> createPayment(Map<String, dynamic> data) async {
    try {
      Response res = await ApiClient.post(
        "${APIEndpointUrls.create_payment}",
        data: data,
      );
      if (res.statusCode == 200) {
        debugPrint('createPayment:${res.data}');
        return SuccessModel.fromJson(res.data);
      } else {
        return null;
      }
    } catch (e) {
      debugPrint('Error createPayment::$e');
      return null;
    }
  }

  @override
  Future<SuccessModel?> ArchitechCompanyAdditionalInfoPost(
    Map<String, dynamic> data,
  ) async {
    var formdata = await buildFormData(data);
    try {
      Response res = await ApiClient.post(
        "${APIEndpointUrls.architech_company_additional_info}",
        data: formdata,
      );
      if (res.statusCode == 200) {
        debugPrint('create comapny Additional Post:${res.data}');
        return SuccessModel.fromJson(res.data);
      } else {
        return null;
      }
    } catch (e) {
      debugPrint('Error comapny Additional Post ::$e');
      return null;
    }
  }

  @override
  Future<SuccessModel?> ArchitechCompanyAdditionalInfoUpdate(
    Map<String, dynamic> data,
  ) async {
    var formdata = await buildFormData(data);
    try {
      Response res = await ApiClient.post(
        "${APIEndpointUrls.architech_company_additional_info_update}",
        data: formdata,
      );
      if (res.statusCode == 200) {
        debugPrint('create comapny Additional Update:${res.data}');
        return SuccessModel.fromJson(res.data);
      } else {
        return null;
      }
    } catch (e) {
      debugPrint('Error comapny Additional Update ::$e');
      return null;
    }
  }

  @override
  Future<GetArchitectsModel?> getArchitect(
    String industrialType,
    String location,
  ) async {
    try {
      Response res = await ApiClient.get(
        "${APIEndpointUrls.get_architect}?industry_type=${industrialType}&location=${location}",
      );
      if (res.statusCode == 200) {
        debugPrint('getArchitect:${res.data}');
        return GetArchitectsModel.fromJson(res.data);
      } else {
        return null;
      }
    } catch (e) {
      debugPrint('Error getArchitect::$e');
      return null;
    }
  }

  @override
  Future<SubscriptionModel?> getsubplans() async {
    try {
      Response res = await ApiClient.get("${APIEndpointUrls.getsubplans}");
      if (res.statusCode == 200) {
        debugPrint('get Subscription plans:${res.data}');
        return SubscriptionModel.fromJson(res.data);
      } else {
        return null;
      }
    } catch (e) {
      debugPrint('Error Subscription plans::$e');
      return null;
    }
  }

  @override
  Future<ActiveSubscriptionModel?> getActiveSubplans(int id) async {
    try {
      Response res = await ApiClient.get(
        "${APIEndpointUrls.get_subplans_architecture}/${id}",
      );

      if (res.statusCode == 200) {
        debugPrint('getArchitech Active Plans Response: ${res.data}');

        return ActiveSubscriptionModel.fromJson(res.data);
      } else {
        return null;
      }
    } catch (e) {
      debugPrint('Error getArchitech Active Plans Response: $e');
      return null;
    }
  }

  @override
  Future<PaymentHistoryModel?> getArchitechPaymentsHistory(int id) async {
    try {
      Response res = await ApiClient.get(
        "${APIEndpointUrls.get_architecture_payments_history}/${id}",
      );

      if (res.statusCode == 200) {
        debugPrint('get Architech payments History  Response: ${res.data}');

        return PaymentHistoryModel.fromJson(res.data);
      } else {
        return null;
      }
    } catch (e) {
      debugPrint('Error get Architech payments History Plans Response: $e');
      return null;
    }
  }

  @override
  Future<List<StatesModel>?> getStates() async {
    try {
      Response res = await ApiClient.get("${APIEndpointUrls.get_states}");

      if (res.statusCode == 200 && res.data is List) {
        debugPrint('getStates Response: ${res.data}');
        List<dynamic> dataList = res.data;
        return dataList.map((e) => StatesModel.fromJson(e)).toList();
      } else {
        return null;
      }
    } catch (e) {
      debugPrint('Error getStates: $e');
      return null;
    }
  }

  @override
  Future<ArchitechStatesModel?> getArchitechStates() async {
    try {
      Response res = await ApiClient.get("${APIEndpointUrls.architec_states}");

      if (res.statusCode == 200) {
        debugPrint('getArchitechStates Response: ${res.data}');

        return ArchitechStatesModel.fromJson(res.data);
      } else {
        return null;
      }
    } catch (e) {
      debugPrint('Error getArchitechStates: $e');
      return null;
    }
  }

  @override
  Future<List<CityModel>?> getCity() async {
    try {
      Response res = await ApiClient.get(
        "${APIEndpointUrls.get_city}/cities",
      );

      if (res.statusCode == 200 && res.data is List) {
        debugPrint('get getCity: ${res.data}');
        List<dynamic> data = res.data;
        return data.map((e) => CityModel.fromJson(e)).toList();
      } else {
        return null;
      }
    } catch (e) {
      debugPrint('Error getCity: $e');
      return null;
    }
  }

  @override
  Future<ArchitechCityModel?> geArchitecttCity() async {
    try {
      Response res = await ApiClient.get(
        "${APIEndpointUrls.architec_cities}/cities",
      );
      if (res.statusCode == 200) {
        debugPrint('get ArchitectCity: ${res.data}');
        return ArchitechCityModel.fromJson(res.data);
      } else {
        return null;
      }
    } catch (e) {
      debugPrint('Error getUserPosts: $e');
      return null;
    }
  }

  @override
  Future<CategoryTypeModel?> getArchitectCategoryType(String cities) async {
    try {
      Response res = await ApiClient.get(
        "${APIEndpointUrls.architec_category_type}/$cities",
      );

      if (res.statusCode == 200) {
        debugPrint('get Architect Category Type: ${res.data}');
        return CategoryTypeModel.fromJson(res.data);
      } else {
        return null;
      }
    } catch (e) {
      debugPrint('Error get Architect Category Type: $e');
      return null;
    }
  }

  @override
  Future<UserPostedModel?> getUserPosts() async {
    try {
      Response res = await ApiClient.get("${APIEndpointUrls.user_posts}");
      if (res.statusCode == 200) {
        debugPrint('get getUserPosts: ${res.data}');
        return UserPostedModel.fromJson(res.data);
      } else {
        return null;
      }
    } catch (e) {
      debugPrint('Error getUserPosts: $e');
      return null;
    }
  }

  @override
  Future<UserPosteDetailsModel?> getUserPostDetails(int id) async {
    try {
      Response res = await ApiClient.get(
        "${APIEndpointUrls.user_posts_detail}/${id}",
      );
      if (res.statusCode == 200) {
        debugPrint('get getUserPostDetails: ${res.data}');
        return UserPosteDetailsModel.fromJson(res.data);
      } else {
        return null;
      }
    } catch (e) {
      debugPrint('Error getUserPostDetails: $e');
      return null;
    }
  }

  @override
  Future<ArchitechProfileModel?> getArchitechProfile() async {
    try {
      Response res = await ApiClient.get(
        "${APIEndpointUrls.architech_profile}",
      );
      if (res.statusCode == 200) {
        debugPrint('get getArchitechProfile: ${res.data}');
        return ArchitechProfileModel.fromJson(res.data);
      } else {
        return null;
      }
    } catch (e) {
      debugPrint('Error getArchitechProfile: $e');
      return null;
    }
  }

  @override
  Future<ArchitechProfileModel?> getArchitechProfileDetails(int id) async {
    try {
      Response res = await ApiClient.get(
        '${APIEndpointUrls.architech_profile_details}/$id',
      );
      if (res.statusCode == 200) {
        debugPrint('getArchitech Profile Details: ${res.data}');
        return ArchitechProfileModel.fromJson(res.data);
      } else {
        return null;
      }
    } catch (e) {
      debugPrint('Error getArchitech Profile Details: $e');
      return null;
    }
  }

  @override
  Future<ArchitechProfileModel?> getUserArchitechProfileDetails(int id) async {
    try {
      Response res = await ApiClient.get(
        '${APIEndpointUrls.user_architech_by_id}/$id',
      );

      if (res.statusCode == 200) {
        debugPrint('get User Architech Profile Details: ${res.data}');
        return ArchitechProfileModel.fromJson(res.data);
      } else {
        return null;
      }
    } catch (e) {
      debugPrint('Error get User Architech Profile Details: $e');
      return null;
    }
  }
}
