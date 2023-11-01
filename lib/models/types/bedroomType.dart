class BedRoom {
  int? id;
  String? bedRoomName;

  BedRoom({this.id, this.bedRoomName});

  BedRoom.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    bedRoomName = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = bedRoomName;
    return data;
  }
}