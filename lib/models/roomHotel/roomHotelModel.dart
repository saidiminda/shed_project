
class RegisterroomsModel {
  int? hotel_id;
  String? roomsName;
  String? roomsType;
  String? roomsToilet;
  String? roomsPrice;
  String? roomsdescription;

  RegisterroomsModel(
      {this.hotel_id,
      this.roomsName,
      this.roomsType,
      this.roomsToilet  ,
      this.roomsPrice,
      this.roomsdescription,
      });
      
  RegisterroomsModel.fromJson(Map<String, dynamic> json) {
    hotel_id = json['hotel_id'];
    roomsName = json['name'];
    roomsType = json['room_type'];
    roomsToilet   = json['toilet'];
    roomsPrice = json['price'];
    roomsdescription = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['hotel_id'] = hotel_id;
    data['name'] = roomsName;
    data['room_type'] = roomsType;
    data['toilet'] = roomsToilet  ;
    data['price'] = roomsPrice;
    data['description'] = roomsdescription;
    return data;
  }
}
