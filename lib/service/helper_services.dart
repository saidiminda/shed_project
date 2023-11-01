// ignore_for_file: use_build_context_synchronously

import 'package:dio/dio.dart';
import 'package:hotel_booking/models/user_type.dart';
import 'package:hotel_booking/service/apis.dart';

class HelperService {
  final Dio _dio = Dio();
  final String host = apis.host;

  Future<List<UserType>> getUserTypes() async {
    List<UserType> userTypes = [];
    final response = await _dio.get("$host/register");

    if (response.statusCode == 200) {
      final results = response.data as Map<dynamic, dynamic>;
      results.forEach((key, value) {
        final type = UserType.fromMap(value);
        userTypes.add(type);
      });
      return userTypes;
    } else {
      return userTypes;
    }
  }

 


}

HelperService helper = HelperService();
