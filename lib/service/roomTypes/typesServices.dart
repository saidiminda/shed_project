import 'dart:convert';
import 'package:hotel_booking/models/types/house_typeModel.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:http/http.dart' as client;
import 'package:hotel_booking/models/types/bedroomType.dart';
import '../../constants.dart';
class HouseTypeController {
  Future<Result<List<House>, Exception>> getAllHouses() async {
    try {
      List<House> houseList = [];
      String url = "$domainUrl/house_type/index";
      final response = await client.get(Uri.parse(url), headers: headers);

      if (response.statusCode == 200) {
        var json = jsonDecode(response.body.toString());
        for (var house in json["house_type"]) {
          houseList.add(House.fromJson(house));
        }
        return Success(houseList);
        
      } else if (response.statusCode == 404) {
        return Error(Exception(response.body));
      } else {
        return Error(Exception(response.body));
      }
    } catch (e) {
      return Error(Exception(e));
    }
  }
  
   Future<Result<List<BedRoom>, Exception>> getAllBedRooms() async {
    try {
      List<BedRoom> bedRoomList = [];
      String url = "$domainUrl/bedroom_type/index";
      final response = await client.get(Uri.parse(url), headers: headers);

      if (response.statusCode == 200) {
        var json = jsonDecode(response.body.toString());
        for (var room_type in json["room_type"]) {
          bedRoomList.add(BedRoom.fromJson(room_type));
        }
        return Success(bedRoomList);
      } else if (response.statusCode == 404) {
        return Error(Exception(response.body));
      } else {
        return Error(Exception(response.body));
      }
    } catch (e) {
      return Error(Exception(e));
    }
  }
}
