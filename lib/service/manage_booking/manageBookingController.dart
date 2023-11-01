import 'dart:convert';
import 'package:hotel_booking/constants.dart';
import 'package:hotel_booking/models/manageBooking/manageBookingModel.dart';
import 'package:http/http.dart' as http;
import 'package:hotel_booking/models/manageClient/clientModel.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegiserBookingService {
  late SharedPreferences logindata;
  late bool newuser;
  Future<Result<List<BookingModel>, Exception>> getAllClient() async {
    try {
      List<BookingModel> businessList = [];

      String url = "$domainUrl/business/";
      final response = await http.get(Uri.parse(url), headers: headers);

      if (response.statusCode == 200) {
        var json = jsonDecode(response.body.toString());
        for (var business in json["businesses"]) {
          businessList.add(BookingModel.fromJson(business));
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
  Future<BookingModel> updateFruit(String title) async {
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
      return BookingModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to update');
    }
  }

  Future<BookingModel> deleteAlbum(int id) async {
    logindata = await SharedPreferences.getInstance();
    var userdata = jsonDecode(logindata.getString('userData') ?? "");
    int userId = int.parse(userdata["id"].toString());

    String url = "$domainUrl/get_hotel_client/${userId}/index";
    final http.Response response = await http.delete(
      Uri.parse(url),
      headers: headers,
    );

    if (response.statusCode == 200) {
      return BookingModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to delete album.');
    }
  }

// get data
  Future<List<BookingModel>> fetchAlbum() async {
    logindata = await SharedPreferences.getInstance();
    var userdata = jsonDecode(logindata.getString('userData') ?? "");
    int userId = int.parse(userdata["id"].toString());
    String url = "$domainUrl/booking/${userId}/index";
    final response = await http.get(Uri.parse(url), headers: headers);

    if (response.statusCode == 200) {
      final List result = json.decode(response.body);
      return result.map((e) => BookingModel.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<Result<BookingModel, Exception>> getUserBooking() async {
    try {
      logindata = await SharedPreferences.getInstance();
      var userdata = jsonDecode(logindata.getString('userData') ?? "");
      int userId = int.parse(userdata["id"].toString());

      String url = "$domainUrl/booking/${userId}/index";
      final response = await http.get(Uri.parse(url), headers: headers);

      if (response.statusCode == 200) {
        var json = jsonDecode(response.body.toString());
        print(json);
        return Success(BookingModel.fromJson(json["invoice"]));
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
  Future<Result<BookingModel, Exception>> registerBooking(
      Map<String, dynamic> userData) async {
    try {
      String url = "$domainUrl/booking/save";
      final response = await http.post(Uri.parse(url),
          body: jsonEncode(userData), headers: headers);
      if (response.statusCode == 201) {
        Map<String, dynamic> resposne = jsonDecode(response.body);
        var json = jsonDecode(response.body.toString());
        if (!resposne['error']) {
          logindata.setString('userData', jsonEncode(resposne['invoice']));
          print(resposne['invoice']);

          // Navigator.pushNamed(context, AppRoutes.dashboard);
        }
        return Success(BookingModel.fromJson(json));
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
