
class RegisterPropertyModel {
  int? id;
  String? propertyName;
  String? propertyType;
  String? propertyAdress;
  String? propertyGoogle;
  String? propertyPhone1;
  String? propertyPhone2;
  String? propertyEmail;
  String? propertyOffical;
  String? propertyDescription;
  String? propertyOffer;

  RegisterPropertyModel(
      {this.id,
      this.propertyName,
      this.propertyType,
      this.propertyAdress,
      this.propertyGoogle,
      this.propertyPhone1,
      this.propertyPhone2,
      this.propertyEmail,
      this.propertyOffical,
      this.propertyDescription,
      this.propertyOffer,
      });
      
  RegisterPropertyModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    propertyName = json['name'];
    propertyType = json['type'];
    propertyAdress = json['address'];
    propertyGoogle = json['google_location'];
    propertyPhone1 = json['phone1'];
    propertyPhone2 = json['phone2'];
    propertyEmail = json['email'];
    propertyOffical = json['website_link'];
    propertyDescription= json['notes'];
    propertyOffer= json['offers'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = propertyName;
    data['type'] = propertyType;
    data['address'] = propertyAdress;
    data['google_location'] = propertyGoogle;
    data['phone1'] = propertyPhone1;
    data['phone2'] = propertyPhone2;
    data['email'] = propertyEmail;
    data['website_link'] = propertyOffical;
    data['notes'] = propertyDescription;
    data['offers'] = propertyOffer;
    return data;
  }
}
