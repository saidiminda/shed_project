import 'dart:convert';
import 'package:hotel_booking/models/registerProperty/registerProperty_model.dart';
import 'package:hotel_booking/models/roomHotel/roomHotelModel.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:http/http.dart' as rooms;
import 'package:shared_preferences/shared_preferences.dart';
import '../../constants.dart';

class RegiserPropertyService {
  late SharedPreferences logindata;

  Future<List<RegisterroomsModel>> fetchRoom() async {
    logindata = await SharedPreferences.getInstance();
    var userdata = jsonDecode(logindata.getString('hotelData') ?? "");
    String? username = userdata["id"] ?? "";
    final response =
        await rooms.get(Uri.parse('$domainUrl/${int.parse(username!)}'));
    if (response.statusCode == 200) {
      final List result = json.decode(response.body);
      return result.map((e) => RegisterroomsModel.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load data');
    }
  }
  Future<Result<RegisterroomsModel, Exception>> registerRoom(
      Map<String, dynamic> userData) async {
    try {
      String url = "$domainUrl/hotel_rooms/save";
      final response = await rooms.post(Uri.parse(url),
          body: jsonEncode(userData), headers: headers);
      if (response.statusCode == 201) {
        var json = jsonDecode(response.body.toString());

        return Success(RegisterroomsModel.fromJson(json));
      } else if (response.statusCode == 400) {
        return Error(Exception(response.body));
      } else {
        return Error(Exception(response.body));
      }
    } catch (e) {
      return Error(Exception(e));
    }
  }
  // Future<Result<RegisterroomsModel, Exception>> registerRoom(
  //     Map<String, dynamic> userData) async {
  //   try {
  //     String url = "$domainUrl/hotel_rooms/save";
  //     final response = await rooms.post(Uri.parse(url),
  //         body: jsonEncode(userData), headers: headers);
  //     final result = json.decode(response.body);

  //     if (response.statusCode == 201 && result['success']) {
  //       var json = jsonDecode(response.body.toString());
        
  //        Map<String, dynamic> resposne = jsonDecode(response.body);
  //     logindata = await SharedPreferences.getInstance();
  //     logindata.setString('hotelRoomData', jsonEncode(resposne['hotel_room']));
  //     print(resposne['hotel_room']);
  //       print(json['name']);
  //       return Success(RegisterroomsModel.fromJson(json));
  //     } else if (response.statusCode == 400) {
  //       return Error(Exception(response.body));
  //     } else {
  //       return Error(Exception(response.body));
  //     }
  //   } catch (e) {
  //     return Error(Exception(e));
  //   }
  // }
}
