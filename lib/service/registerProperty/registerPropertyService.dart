import 'dart:convert';
import 'package:hotel_booking/models/registerProperty/registerProperty_model.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:http/http.dart' as client;
import 'package:shared_preferences/shared_preferences.dart';
import '../../constants.dart';

class RegiserPropertyService {
  late SharedPreferences logindata;

  Future<List<RegisterPropertyModel>> fetchAlbum() async {
    logindata = await SharedPreferences.getInstance();
    var userdata = jsonDecode(logindata.getString('userData') ?? "");
    String? username = userdata["id"] ?? "";

    final response =
        await client.get(Uri.parse('$domainUrl/${int.parse(username!)}'));
    if (response.statusCode == 200) {
      final List result = json.decode(response.body);
      return result.map((e) => RegisterPropertyModel.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<Result<RegisterPropertyModel, Exception>> registerProperty(
      Map<String, dynamic> userData) async {
    try {
      String url = "$domainUrl/hotel/save";
      final response = await client.post(Uri.parse(url),
          body: jsonEncode(userData), headers: headers);

      if (response.statusCode == 201) {
        var json = jsonDecode(response.body.toString());
        print(json['email']);
        logindata.setString('hotelData', jsonEncode(json['hotel']));
        return Success(RegisterPropertyModel.fromJson(json));
      } else if (response.statusCode == 400) {
        return Error(Exception(response.body));
      } else {
        return Error(Exception(response.body));
      }
    } catch (e) {
      return Error(Exception(e));
    }
  }
}
