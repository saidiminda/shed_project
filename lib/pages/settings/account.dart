import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:hotel_booking/utils/app_export.dart';
import 'package:hotel_booking/widgets/app_bar/appbar_subtitle.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fancy_containers/fancy_containers.dart';

// ignore_for_file: must_be_immutable
class AccountsScreen extends StatefulWidget {
  const AccountsScreen({Key? key}) : super(key: key);

  @override
  State<AccountsScreen> createState() => _AccountsScreenState();
}

class _AccountsScreenState extends State<AccountsScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
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
    mediaQueryData = MediaQuery.of(context);
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          iconTheme: const IconThemeData(color: Color.fromARGB(255, 8, 8, 8)),
          title: Center(
            child: AppbarSubtitle(
              // translation(context).add_room
              text: 'Accounts',
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Center(
                  child: CircleAvatar(
                      backgroundColor: const Color.fromARGB(255, 240, 191, 118),
                      child: IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.person_2),
                        color: const Color.fromARGB(255, 223, 220, 220),
                      ),
                    ),
                ),
              
                // Center(
                //   child: FancyContainer(
                //     onTap: () {
                //       print("Hello World");
                //     },
                //     color1: Colors.lightGreenAccent,
                //     color2: Colors.lightBlue,
                //     title:'Personal Details',
                //     textColor: Colors.white,
                //     subtitle: name.toString(),
                //     subtitleColor: Colors.white,
                //   ),
                // ),
                Card(
                  borderOnForeground: true,
                  child: Column(children: [
                    Container(
                      margin: const EdgeInsets.only(top: 2),
                      height: 150,
                      padding: const EdgeInsets.only(
                        left: 2,
                        right: 2,
                        bottom: 5,
                      ),
                      child: Container(
                        height: 400,
                        width: 400,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 248, 173, 150),
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(85.0),
                          ),
                          boxShadow: [
                            BoxShadow(
                                color: const Color.fromARGB(255, 248, 173, 150)
                                    .withOpacity(0.3),
                                offset: const Offset(-10.0, 0.0),
                                blurRadius: 20.0,
                                spreadRadius: 4.0),
                          ],
                        ),
                        padding: const EdgeInsets.only(
                          left: 32,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                             Text("Personal Details",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: CustomTextStyles
                                          .titleMediumOnPrimary),
                               Divider(
                                color:
                                    theme.colorScheme.onPrimary.withOpacity(1),
                                indent: getHorizontalSize(13),
                                endIndent: getHorizontalSize(12)),

                            Padding(
                              padding: getPadding(top: 5),
                              child: Row(
                                children: [
                                  Text("Full Name:",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: CustomTextStyles
                                          .titleMediumOnPrimary),
                                  Expanded(
                                    child: Text(name.toString(),
                                        maxLines: 1,
                                        softWrap: false,
                                        overflow: TextOverflow.ellipsis,
                                        style: CustomTextStyles
                                            .titleMediumOnPrimary),
                                  )
                                ],
                              ),
                            ),
                            Divider(
                                color:
                                    theme.colorScheme.onPrimary.withOpacity(1),
                                indent: getHorizontalSize(13),
                                endIndent: getHorizontalSize(12)),
                            Align(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                    padding: getPadding(left: 13, right: 39),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(children: [
                                          Padding(
                                              padding: getPadding(bottom: 1),
                                              child: Text("Phone:",
                                                  style: CustomTextStyles
                                                      .titleMediumOnPrimary)),
                                          Text(phone.toString(),
                                              style: CustomTextStyles
                                                  .titleMediumOnPrimary),
                                        ]),
                                        Column(children: [
                                          Padding(
                                              padding: getPadding(bottom: 1),
                                              child: Text("Email Adress:",
                                                  style: CustomTextStyles
                                                      .titleMediumOnPrimary)),
                                          Text(phone.toString(),
                                              style: CustomTextStyles
                                                  .titleMediumOnPrimary),
                                        ]),
                                      ],
                                    ))),
                            Divider(
                                color:
                                    theme.colorScheme.onPrimary.withOpacity(1),
                                indent: getHorizontalSize(13),
                                endIndent: getHorizontalSize(12)),
                            Align(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                    padding: getPadding(left: 13, right: 39),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(children: [
                                          Padding(
                                              padding: getPadding(bottom: 1),
                                              child: Text("Physical Adress:",
                                                  style: CustomTextStyles
                                                      .titleMediumOnPrimary)),
                                          Text("Tanga - Korongwe",
                                              style: CustomTextStyles
                                                  .titleMediumOnPrimary),
                                        ]),
                                        Column(children: [
                                          Padding(
                                              padding: getPadding(bottom: 1),
                                              child: Text("Package:",
                                                  style: CustomTextStyles
                                                      .titleMediumOnPrimary)),
                                          Text("Weekly",
                                              style: CustomTextStyles
                                                  .titleMediumOnPrimary),
                                        ]),
                                      ],
                                    ))),
                          ],
                        ),
                      ),
                    ),
                  ]),
                ),

                Text(
                  username.toString(),
                ),
                Text(
                  name.toString(),
                ),
                Text(
                  phone.toString(),
                ),
                TextButton(
                    onPressed: () {}, child: const Text('LogOut/Sign Out'))
              ],
            ),
          ),
        ));
  }

  onTapSave(BuildContext context) {
    // Navigator.pushNamed(context, AppRoutes.bookListScreen);
  }
}
