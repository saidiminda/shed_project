import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:hotel_booking/service/local_service/local_services.dart';
import '../../apis.dart';
import '../../models/user/user.dart';

class AuthServices {
  final Dio _dio = Dio();
  final String host = apis.host;

  Future authenticate({required Map<String, dynamic> userData}) async {
    final FormData data = FormData.fromMap(userData);
    final response = await _dio.post("$host/pms_login", data: data);
    if (response.statusCode == 200) {
      final results = response.data;
      if (results['success']) {
        final userResults = results['user'];
        await local.setInstance(key: "hasLogin", type: bool, value: true);
        await local.setInstance(key: "isNewUser", type: bool, value: false);
        await local.setInstance(
            key: "userData", type: String, value: json.encode(userResults));
        print(userResults);
        User user = User.fromMap(userResults);
        return user;
      } else {
        return results['message'];
      }
    } else {
      return "Connection error";
    }
  }

  Future createUser({required Map<String, dynamic> userData}) async {
    final FormData data = FormData.fromMap(userData);
    final response = await _dio.post("$host/register", data: data);
    if (response.statusCode == 200) {
      final results = response.data;
      if (results['success']) {
        final user = results['user'];
        final userDataMap = {
          "id": user['id'],
          "name": user['name'],
          "email": user['email'],
          "phone": user['phone'],
          "address": user['address'],
          "role": userData['role'],
          "country": userData['country'],
        };
        await local.setInstance(key: "hasLogin", type: bool, value: true);
        await local.setInstance(key: "isNewUser", type: bool, value: false);
        await local.setInstance(
            key: "userData", type: String, value: json.encode(userDataMap));

        User _user = User.fromMap(userDataMap);
        return _user;
      } else {
        return results['message'];
      }
    } else {
      final results = response.data;
      return results['message'];
    }
  }

  Future<bool> verifyEmail({required String email}) async {
    final response = await _dio.get("$host/user_email/$email/find");
    if (response.statusCode == 200) {
      final results = response.data;
      if (results['success']) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }
}

AuthServices auth = AuthServices();
