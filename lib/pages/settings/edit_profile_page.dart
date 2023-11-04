import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hotel_booking/models/user.dart';
import 'package:hotel_booking/widgets/new_widget/appbar_widget.dart';
import 'package:hotel_booking/widgets/new_widget/button_widget.dart';
import 'package:hotel_booking/widgets/new_widget/profile_widget.dart';
import 'package:hotel_booking/widgets/new_widget/textfield_widget.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
      late SharedPreferences logindata;
  String? username, name, phone;
  @override
  void initState() {
    super.initState();
    initial();
  }

  void initial() async {
    logindata = await SharedPreferences.getInstance();
    setState(() {
      var userdata = jsonDecode(logindata.getString('userData') ?? "");
      name = userdata["name"] ?? "";
      phone = userdata["phone"] ?? "";
      username = userdata["email"] ?? "";
    });
  }
  // User user = UserPreferences.myUser;

  @override
  Widget build(BuildContext context) => Builder(
    builder: (context) => Scaffold(
      appBar: buildAppBar(context),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        physics: const BouncingScrollPhysics(),
        children: [
          ProfileWidget(
            imagePath:"",
            isEdit: true,
            onClicked: () async {},
          ),
          const SizedBox(height: 24),
          TextFieldWidget(
            label: 'Full Name',
            text: name.toString(),
            onChanged: (name) {},
          ),
          const SizedBox(height: 24),
          TextFieldWidget(
            label: 'Email',
            text: username.toString(),
            onChanged: (email) {},
          ),
          const SizedBox(height: 24),
          TextFieldWidget(
            label: 'Contact',
            text: phone.toString(),
            maxLines: 1,
            onChanged: (contact) {},
          ),
             const SizedBox(height: 14),
          buildUpgradeButton(context),
        ],
      ),
    ),
  );
   Widget  buildUpgradeButton(BuildContext context) => ButtonWidget(
        text: 'Update Profile',
        onClicked: () {
          // Navigator.of(context).push(
          //           MaterialPageRoute(builder: (context) => AccountsScreen()),
          //         ); 
        },
      );
}
