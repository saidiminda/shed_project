// ignore_for_file: unused_import

import 'package:hotel_booking/database/database_manager.dart';
import 'package:sqflite/sqflite.dart';

class User {
  int? id;
  String? name;
  String? phone;
  String? address;
  String? email;
  String? role;
  String? country;
  String? picture;
  int? owner;

  User({
    this.address,
    this.email,
    this.id,
    this.name,
    this.phone,
    this.role,
    this.country,
    this.picture,
    this.owner
  });

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      name: map['name'],
      address: map['address'],
      email: map['email'],
      phone: map['phone'],
      role: map['role'],
      country: map['country'],
      picture: map['picture'],
    );
  }
}
