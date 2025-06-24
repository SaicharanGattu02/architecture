import 'dart:convert';
import 'dart:io';
import 'package:architect/models/ActiveSubscriptionmodel.dart';
import 'package:architect/models/SubscriptionModel.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import '../models/ArchitechProfileModel.dart';
import '../models/ArchitectModel.dart';
import '../models/CitiesModel.dart';
import '../models/StatesModel.dart';
import '../models/SuccessModel.dart';
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
  Future<List<CityModel>?> getCity(String state);
  Future<Activesubscriptionmodel?> activesubplans(int Id);
  Future<SuccessModel?> loginOtp(Map<String, dynamic> data);
  Future<SuccessModel?> createProfile(Map<String, dynamic> data);
  Future<VerifyLogInOtpModel?> verifyLoginOtp(Map<String, dynamic> data);
  Future<VerifyOtpModel?> companyVerifyOtp(Map<String, dynamic> data);
  Future<SuccessModel?> createPost(Map<String, dynamic> data);
  Future<UserPostedModel?> getUserPosts();
  Future<ArchitechProfileModel?> getArchitechProfile();
  Future<ArchitechProfileModel?> getArchitechProfileDetails(int id);
  Future<SuccessModel?> ArchitechCompanyAdditionalInfoPost(
    Map<String, dynamic> data,
  );
}

class RemoteDataSourceImpl implements RemoteDataSource {
  Future<FormData> buildFormData(Map<String, dynamic> data) async {
    final formMap = <String, dynamic>{};
    for (final entry in data.entries) {
      final key = entry.key;
      final value = entry.value;

      if (value == null) continue;

      if (value is File &&
          (key.contains('image') ||
              key.contains('file') ||
              key.contains('picture') ||
              key.contains('payment_screenshot'))) {
        formMap[key] = await MultipartFile.fromFile(
          value.path,
          filename: value.path.split('/').last,
        );
      } else {
        formMap[key] = value.toString();
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
        "${APIEndpointUrls.loginotp}?company_email=${data['company_email']}",
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
      Response res = await ApiClient.post(
        "${APIEndpointUrls.create_profile}?company_name=${data["company_name"]}&company_email=${data["company_email"]}&contact_person_name=${data["contact_person_name"]}&state=${data["state"]}&location=${data["location"]}&established_year=${data["established_year"]}",
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
  Future<SuccessModel?> ArchitechCompanyAdditionalInfoPost(
    Map<String, dynamic> data,
  ) async {
    try {
      Response res = await ApiClient.post(
        "${APIEndpointUrls.architech_company_additional_info}",
        data: data,
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
  Future<List<CityModel>?> getCity(String state) async {
    try {
      Response res = await ApiClient.get(
        "${APIEndpointUrls.get_city}/$state/cities",
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
  Future<Activesubscriptionmodel?> activesubplans(int Id) async {
    try {
      Response res = await ApiClient.get(
        "${APIEndpointUrls.activesubplans}/Id",
      );
      if (res.statusCode == 200) {
        debugPrint('get Active Subscription plans:${res.data}');
        return Activesubscriptionmodel.fromJson(res.data);
      } else {
        return null;
      }
    } catch (e) {
      debugPrint('Error Subscription plans::$e');
      return null;
    }
  }
}
