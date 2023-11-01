import 'dart:convert';
import 'package:hotel_booking/constants.dart';
import 'package:http/http.dart' as http;
import 'package:hotel_booking/models/manageClient/clientModel.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegiserClientService {
  late SharedPreferences logindata;
  late bool newuser;
  Future<Result<List<ClientclientModel>, Exception>> getAllClient() async {
    try {
      List<ClientclientModel> businessList = [];

      String url = "$domainUrl/business/";
      final response = await http.get(Uri.parse(url), headers: headers);

      if (response.statusCode == 200) {
        var json = jsonDecode(response.body.toString());
        for (var business in json["businesses"]) {
          businessList.add(ClientclientModel.fromJson(business));
        }

        return Success(businessList);
      } else if (response.statusCode == 404) {
        return Error(Exception(response.body));
      } else {
        return Error(Exception(response.body));
      }
    } catch (e) {
      return Error(Exception(e));
    }
  }

  // update
  Future<ClientclientModel> updateFruit(String title) async {
    logindata = await SharedPreferences.getInstance();
    var userdata = jsonDecode(logindata.getString('userData') ?? "");
    int userId = int.parse(userdata["id"].toString());
    String url = "$domainUrl/get_hotel_client/${userId}/index";
    final http.Response response = await http.put(
      Uri.parse(url),
      headers: headers,
      body: jsonEncode(<String, String>{
        'title': title,
      }),
    );

    if (response.statusCode == 200) {
      return ClientclientModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to update');
    }
  }

  Future<ClientclientModel> deleteAlbum(int id) async {
    logindata = await SharedPreferences.getInstance();
    var userdata = jsonDecode(logindata.getString('userData') ?? "");
    int userId = int.parse(userdata["id"].toString());

    String url = "$domainUrl/get_hotel_client/${userId}/index";
    final http.Response response = await http.delete(
      Uri.parse(url),
      headers: headers,
    );

    if (response.statusCode == 200) {
      return ClientclientModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to delete album.');
    }
  }

// get data
  Future<List<ClientclientModel>> fetchAlbum() async {
    logindata = await SharedPreferences.getInstance();
    var userdata = jsonDecode(logindata.getString('userData') ?? "");
    int userId = int.parse(userdata["id"].toString());
    String url = "$domainUrl/get_hotel_client/${userId}/index";
    final response = await http.get(Uri.parse(url), headers: headers);

    if (response.statusCode == 200) {
      final List result = json.decode(response.body);
      return result.map((e) => ClientclientModel.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<Result<ClientclientModel, Exception>> getByUserId() async {
    try {
      logindata = await SharedPreferences.getInstance();
      var userdata = jsonDecode(logindata.getString('userData') ?? "");
      int userId = int.parse(userdata["id"].toString());

      String url = "$domainUrl/get_hotel_client/${userId}/index";
      final response = await http.get(Uri.parse(url), headers: headers);

      if (response.statusCode == 200) {
        var json = jsonDecode(response.body.toString());
        print(json);
        return Success(ClientclientModel.fromJson(json["room_type"]));
      } else if (response.statusCode == 404) {
        return Error(Exception(response.body));
      } else {
        return Error(Exception(response.body));
      }
    } catch (e) {
      return Error(Exception(e));
    }
  }

// create client
  Future<Result<ClientclientModel, Exception>> registerClient(
      Map<String, dynamic> userData) async {
    try {
      String url = "$domainUrl/get_hotel_client/save";
      final response = await http.post(Uri.parse(url),
          body: jsonEncode(userData), headers: headers);
      if (response.statusCode == 201) {
        var json = jsonDecode(response.body.toString());

        return Success(ClientclientModel.fromJson(json));
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
