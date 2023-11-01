import 'dart:convert';

import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:hotel_booking/models/user.dart';
import 'package:hotel_booking/pages/settings/edit_profile_page.dart';
import 'package:hotel_booking/utils/user_preferences.dart';
import 'package:hotel_booking/widgets/new_widget/appbar_widget.dart';
import 'package:hotel_booking/widgets/new_widget/button_widget.dart';
import 'package:hotel_booking/widgets/new_widget/numbers_widget.dart';
import 'package:hotel_booking/widgets/new_widget/profile_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
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
  @override
  Widget build(BuildContext context) {
    const user = UserPreferences.myUser;

    return  Scaffold(
          appBar: buildAppBar(context),
          body: ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              ProfileWidget(
                imagePath: user.imagePath,
                onClicked: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const EditProfilePage()),
                  );
                },
              ),
              const SizedBox(height: 5),
              buildName(user),
              const SizedBox(height: 24),
              Center(child: buildUpgradeButton()),
              const SizedBox(height: 24),
              // NumbersWidget(),
              // const SizedBox(height: 48),
              // buildAbout(user),
            ],
          ),
        );
   
  }

  Widget buildName(User user) => Column(
        children: [
          Text(
            name.toString(),
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          const SizedBox(height: 4),
          Text(
            username.toString(),
            style: const TextStyle(color: Colors.grey),
          ),    const Text(
              'Contact',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text(
              phone.toString(),
              style: const TextStyle(fontSize: 1, height: 1.4),
            ),
        ],
      );

  Widget buildUpgradeButton() => ButtonWidget(
        text: 'LogOut/Sign Out',
        onClicked: () {
          
        },
      );

  Widget buildAbout(User user) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 48),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Contact',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text(
              phone.toString(),
              style: const TextStyle(fontSize: 16, height: 1.4),
            ),
          ],
        ),
      );
}
