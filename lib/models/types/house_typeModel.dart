class House {
  int? id;
  String? houseName;

  House({this.id, this.houseName});

  House.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    houseName = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = houseName;
    return data;
  }
}