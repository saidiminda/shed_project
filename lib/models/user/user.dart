// ignore_for_file: unused_import

import 'package:sqflite/sqflite.dart';

class User {
  int? id;
  String? name;
  String? reference_no;
  String? phone;
  String? address;
  String? email;
  String? role;
  String? imagePath;

  User({
    this.address,
    this.email,
    this.id,
    this.name,
    this.phone,
    this.role,
    this.reference_no,
    this.imagePath,
  });

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      name: map['name'],
      address: map['address'],
      email: map['email'],
      phone: map['phone'],
      role: map['role'],
      reference_no: map['reference_no'],
      imagePath:map[''],
    );
  }
}
