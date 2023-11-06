import 'package:hotel_booking/database/database_manager.dart';
import 'package:sqflite/sqflite.dart';

class ClientclientModel {
  int? id;
  String? clientName;
  String? clientPhone;
  String? clientAdress;
  String? clientNationality;
  String? clientPlaceOfBirth;
  String? clientoccupation;
  String? clientEmail;
  String? clientdob;
  String? clienttribe;
  String? clientidentity_no;
  String? clientidentity_type;

  ClientclientModel(
      {this.id,
      this.clientName,
      this.clientPhone,
      this.clientAdress,
      this.clientNationality,
      this.clientPlaceOfBirth,
      this.clientoccupation,
      this.clientEmail,
      this.clientdob,
      this.clienttribe,
      this.clientidentity_no,
      this.clientidentity_type});

  ClientclientModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    clientName = json['name'];
    clientAdress = json['address'];
    clientPhone = json['phone'];
    clientEmail = json['email'];
    clientNationality = json['nationality'];
    clientPlaceOfBirth = json['place_of_birth'];
    clientoccupation = json['occupation'];

    clientdob = json['dob'];
    clienttribe = json['tribe'];
    clientidentity_type = json['identity_type'];
    clientidentity_no = json['identity_no'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = clientName;
    data['phone'] = clientPhone;
    data['address'] = clientAdress;
    data['nationality'] = clientNationality;
    data['place_of_birth'] = clientPlaceOfBirth;
    data['occupation'] = clientoccupation;
    data['email'] = clientEmail;
    data['dob'] = clientdob;
    data['notes'] = clienttribe;
    data['identity_no'] = clientidentity_no;
    data['identity_type'] = clientidentity_type;
    return data;
  }
    saveToLocalDatabase(ClientclientModel client) async {
    Database db = await DatabaseManager.instance.database;
    await db.insert("clients", {
      "id": client.id,
      "name": client.clientName,
      "phone": client.clientPhone,
      "email": client.clientEmail,
      "address": client.clientAdress,
      "nationality": client.clientNationality,
      "place_of_birth": client.clientPlaceOfBirth,
      "dob": client.clientdob,
      "identity_no": client.clientidentity_no,
      "identity_type": client.clientidentity_type,
      "occupation": client.clientoccupation,
      "tribe": client.clienttribe,
    });
  }
}
