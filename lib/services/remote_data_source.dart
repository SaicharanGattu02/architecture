import 'dart:convert';
import 'dart:io';
import 'package:architect/models/ActiveSubscriptionmodel.dart';
import 'package:architect/models/SubscriptionModel.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import '../models/ArchitectModel.dart';
import '../models/SuccessModel.dart';
import 'ApiClient.dart';
import 'api_endpoint_urls.dart';

abstract class RemoteDataSource {
  Future<ArchitectModel?> getArchetic();
  Future<SuccessModel?> registerApi(Map<String,dynamic> data);
  Future<SuccessModel?> loginApi(Map<String,dynamic> data);
  Future<SuccessModel?> addPost(Map<String,dynamic> data);
  Future<SuccessModel?> editPost(Map<String,dynamic> data,id);
  Future<SuccessModel?> deletePost(id);
  Future<SubscriptionModel?> getsubplans();
  Future<Activesubscriptionmodel?> activesubplans(int Id);
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
  Future<SuccessModel?> editPost(Map<String,dynamic> data,id) async {
    try {
      Response res = await ApiClient.post("${APIEndpointUrls.editPost}/$id",data: data);
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
  Future<SuccessModel?> addPost(Map<String,dynamic> data) async {
    try {
      Response res = await ApiClient.post("${APIEndpointUrls.addPost}",data: data);
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

  @override
  Future<SuccessModel?> loginApi(Map<String,dynamic> data) async {
    try {
      Response res = await ApiClient.post("${APIEndpointUrls.login}",data: data);
      if (res.statusCode == 200) {
        debugPrint('loginApi:${res.data}');
        return SuccessModel.fromJson(res.data);
      } else {
        return null;
      }
    } catch (e) {
      debugPrint('Error loginApi::$e');
      return null;
    }
  }

  @override
  Future<SuccessModel?> registerApi(Map<String,dynamic> data) async {
    try {
      Response res = await ApiClient.post("${APIEndpointUrls.register}",data: data);
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
  Future<ArchitectModel?> getArchetic() async {
    try {
      Response res = await ApiClient.get("${APIEndpointUrls.getarchetic}");
      if (res.statusCode == 200) {
        debugPrint('getArchetic:${res.data}');
        return ArchitectModel.fromJson(res.data);
      } else {
        return null;
      }
    } catch (e) {
      debugPrint('Error getArchetic::$e');
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
  Future<Activesubscriptionmodel?> activesubplans(int Id) async {
    try {
      Response res = await ApiClient.get("${APIEndpointUrls.activesubplans}/Id");
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
