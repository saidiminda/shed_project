
import 'package:hotel_booking/database/database_manager.dart';
import 'package:sqflite/sqflite.dart';

class RegisterroomsModel {
  int? hotel_id;
  String? roomsName;
  String? service;
  String? roomsType;
  String? roomsToilet;
  String? roomsPrice;
  String? roomsdescription;

  RegisterroomsModel(
      {this.hotel_id,
      this.roomsName,
      this.service,
      this.roomsType,
      this.roomsToilet  ,
      this.roomsPrice,
      this.roomsdescription,
      });
      
  RegisterroomsModel.fromJson(Map<String, dynamic> json) {
     roomsType = json['room_type'];
    roomsName = json['name'];
    service=json['service'];
    roomsdescription = json['description'];
    roomsToilet   = json['toilet'];
    roomsPrice = json['price'];
    
    hotel_id = json['hotel_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['hotel_id'] = hotel_id;
    data['name'] = roomsName;
    data['service']=service;
    data['room_type'] = roomsType;
    data['toilet'] = roomsToilet  ;
    data['price'] = roomsPrice;
    data['description'] = roomsdescription;
    return data;
  }

  saveToLocalDatabase(RegisterroomsModel roomHotel) async {
    Database db = await DatabaseManager.instance.database;
    await db.insert("roomHotel", {
      "hotel_id": roomHotel.hotel_id,
      "name": roomHotel.roomsName,
      "service": roomHotel.service,
      "room_type": roomHotel.roomsType,
      "toilet": roomHotel.roomsToilet,
      "price": roomHotel.roomsPrice,
      "description": roomHotel.roomsdescription,
    });
  }
}

RegisterroomsModel roomHotel = RegisterroomsModel();