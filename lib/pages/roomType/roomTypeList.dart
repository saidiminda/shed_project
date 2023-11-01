import 'package:flutter/material.dart';
import 'package:hotel_booking/classes/language_constants.dart';
import 'package:hotel_booking/constants.dart';
import 'package:hotel_booking/models/roomHotel/roomHotelModel.dart';
import 'package:hotel_booking/service/delete&update/delete&update.dart';
import 'package:hotel_booking/service/delete&update/update.dart';
import 'package:hotel_booking/utils/app_export.dart';
// ignore: unused_import
import 'package:hotel_booking/classes/language_constants.dart';
import 'package:hotel_booking/widgets/app_bar/appbar_image.dart';
import 'package:hotel_booking/widgets/app_bar/appbar_subtitle.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:outline_gradient_button/outline_gradient_button.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class RoomListScreen extends StatefulWidget {
  const RoomListScreen({Key? key}) : super(key: key);

  @override
  State<RoomListScreen> createState() => _RoomListScreenState();
}

class _RoomListScreenState extends State<RoomListScreen> {
  Delete delete = Delete();
  Update update = Update();
  TextEditingController roomNameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController toiletController = TextEditingController();
  TextEditingController selectTypeRoomController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  TextEditingController checkOutdateController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late SharedPreferences logindata;
  final bool _show = false;

  Future<List<RegisterroomsModel>> fetchAlbum() async {
    logindata = await SharedPreferences.getInstance();
    // print(logindata.getString('hotelData'));
    var userdata = jsonDecode(logindata.getString('userData') ?? "");
    int userId = int.parse(userdata["id"].toString());
    print("user id $userId");
    String url = "$domainUrl/hotel_rooms/$userId/index";
    final response = await http.get(Uri.parse(url), headers: headers);
    final result = json.decode(response.body);
    try {
      if (response.statusCode == 200 && result['success']) {
        print(result);
        return result.map((e) => RegisterroomsModel.fromJson(e)).toList();
      } else {
        print(json.decode(response.body));
        return [];
      }
    } catch (e) {
      print(e);
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Color.fromARGB(255, 8, 8, 8)),
        title: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Center(
            child: AppbarSubtitle(
              // Client List
              text: translation(context).booking_list,
            ),
          ),
        ),
        actions: [
          TextButton.icon(
              style: const ButtonStyle(),
              onPressed: () {
                onTapPlusone(context);
              },
              icon: const Icon(
                Icons.add,
                color: Color.fromARGB(255, 8, 8, 8),
              ),
              label: const Text(''))
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
            child: Column(
          children: [
            FutureBuilder<List<RegisterroomsModel>>(
                future: fetchAlbum(),
                builder: (context, snapshot) {
                  // if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return Form(
                              key: _formKey,
                              child: Container(
                                  width: double.maxFinite,
                                  padding: getPadding(
                                      left: 20, top: 5, right: 20, bottom: 5),
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: getPadding(top: 1),
                                        ),
                                        Container(
                                            margin: getMargin(
                                                left: 13, top: 2, right: 13),
                                            padding: getPadding(
                                                left: 14,
                                                top: 2,
                                                right: 14,
                                                bottom: 17),
                                            decoration: AppDecoration
                                                .gradientCyanToTealA
                                                .copyWith(
                                                    borderRadius:
                                                        BorderRadiusStyle
                                                            .roundedBorder12),
                                            child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        getPadding(top: 10),
                                                  ),
                                                  Container(
                                                      margin:
                                                          getMargin(bottom: 1),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Align(
                                                              alignment: Alignment
                                                                  .centerLeft,
                                                              child: Padding(
                                                                  padding:
                                                                      getPadding(
                                                                          left:
                                                                              13,
                                                                          right:
                                                                              9),
                                                                  child: Row(
                                                                      children: [
                                                                        Padding(
                                                                            padding:
                                                                                getPadding(bottom: 1),
                                                                            child: Text("# :", style: CustomTextStyles.titleMediumOnPrimary)),
                                                                        Text(
                                                                            " 14",
                                                                            style:
                                                                                CustomTextStyles.titleMediumOnPrimary),
                                                                      ]))),
                                                        ],
                                                      )),
                                                  Divider(
                                                      color: theme
                                                          .colorScheme.onPrimary
                                                          .withOpacity(1),
                                                      indent:
                                                          getHorizontalSize(13),
                                                      endIndent:
                                                          getHorizontalSize(
                                                              12)),
                                                  Padding(
                                                    padding:
                                                        getPadding(top: 10),
                                                  ),
                                                  Align(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Padding(
                                                          padding: getPadding(
                                                              left: 13,
                                                              right: 39),
                                                          child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                Padding(
                                                                    padding: getPadding(
                                                                        bottom:
                                                                            1),
                                                                    child: Text(
                                                                        "Name",
                                                                        style: CustomTextStyles
                                                                            .titleMediumOnPrimary)),
                                                                Text(
                                                                    // 'Room 14',
                                                                    snapshot
                                                                        .data![
                                                                            index]
                                                                        .roomsName
                                                                        .toString(),
                                                                    style: CustomTextStyles
                                                                        .titleMediumOnPrimary),
                                                              ]))),
                                                  Padding(
                                                      padding:
                                                          getPadding(top: 16),
                                                      child: Divider(
                                                          color: theme
                                                              .colorScheme
                                                              .onPrimary
                                                              .withOpacity(1),
                                                          indent:
                                                              getHorizontalSize(
                                                                  13),
                                                          endIndent:
                                                              getHorizontalSize(
                                                                  12))),
                                                  Align(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Padding(
                                                          padding: getPadding(
                                                              left: 13,
                                                              right: 39),
                                                          child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                Padding(
                                                                    padding: getPadding(
                                                                        bottom:
                                                                            1),
                                                                    child: Text(
                                                                        "Action",
                                                                        style: CustomTextStyles
                                                                            .titleMediumOnPrimary)),
                                                                Row(
                                                                  children: [
                                                                    GestureDetector(
                                                                      child: Text(
                                                                          "Edit",
                                                                          maxLines:
                                                                              2,
                                                                          style:
                                                                              CustomTextStyles.titleMediumOnPrimary),
                                                                      onTap:
                                                                          () =>
                                                                              {
                                                                        Alert(
                                                                            context:
                                                                                context,
                                                                            title:
                                                                                "Edit Details",
                                                                            content:
                                                                                Column(
                                                                              children: <Widget>[
                                                                                TextField(
                                                                                  controller: roomNameController,
                                                                                  decoration: const InputDecoration(
                                                                                    icon: Icon(Icons.account_circle),
                                                                                    labelText: 'Room name',
                                                                                  ),
                                                                                ),
                                                                                TextField(
                                                                                  controller: priceController,
                                                                                  obscureText: true,
                                                                                  decoration: const InputDecoration(
                                                                                    icon: Icon(Icons.lock),
                                                                                    labelText: 'Price',
                                                                                  ),
                                                                                ),
                                                                                TextField(
                                                                                  controller: toiletController,
                                                                                  obscureText: true,
                                                                                  decoration: const InputDecoration(
                                                                                    icon: Icon(Icons.lock),
                                                                                    labelText: 'Price',
                                                                                  ),
                                                                                ),
                                                                                TextField(
                                                                                  controller: selectTypeRoomController,
                                                                                  obscureText: true,
                                                                                  decoration: const InputDecoration(
                                                                                    icon: Icon(Icons.lock),
                                                                                    labelText: 'Room type',
                                                                                  ),
                                                                                ),
                                                                                TextField(
                                                                                  controller: descriptionController,
                                                                                  obscureText: true,
                                                                                  decoration: const InputDecoration(
                                                                                    icon: Icon(Icons.lock),
                                                                                    labelText: 'Description',
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                            buttons: [
                                                                              DialogButton(
                                                                                onPressed: () => {
                                                                                  // update.updateAlbum(roomNameController.text, priceController.text, toiletController.text, selectTypeRoomController.text, descriptionController.text),
                                                                                  Navigator.pop(context),
                                                                                },
                                                                                child: const Text(
                                                                                  "UPDATE",
                                                                                  style: TextStyle(color: Colors.white, fontSize: 20),
                                                                                ),
                                                                              )
                                                                            ]).show(),
                                                                      },
                                                                    ),
                                                                    const SizedBox(
                                                                      width: 20,
                                                                    ),
                                                                    GestureDetector(
                                                                      child: Text(
                                                                          "Delete",
                                                                          maxLines:
                                                                              2,
                                                                          style:
                                                                              CustomTextStyles.titleMediumOnPrimary),
                                                                      onTap:
                                                                          () =>
                                                                              {
                                                                        Alert(
                                                                          context:
                                                                              context,
                                                                          type:
                                                                              AlertType.warning,
                                                                          title:
                                                                              "Do yo want to delete",
                                                                          desc:
                                                                              "Press the button to continue",
                                                                          buttons: [
                                                                            DialogButton(
                                                                              onPressed: () => {
                                                                                // delete.deleteAlbum(snapshot.data![index].hotel_id.toString()),

                                                                                // implementation of delete
                                                                                Navigator.pop(context),
                                                                              },
                                                                              color: const Color.fromRGBO(0, 179, 134, 1.0),
                                                                              child: const Text(
                                                                                "DELETE",
                                                                                style: TextStyle(color: Colors.white, fontSize: 18),
                                                                              ),
                                                                            ),
                                                                            DialogButton(
                                                                              onPressed: () => {
                                                                                // implementation
                                                                                Navigator.pop(context)
                                                                              },
                                                                              gradient: const LinearGradient(colors: [
                                                                                Color.fromRGBO(116, 116, 191, 1.0),
                                                                                Color.fromRGBO(52, 138, 199, 1.0),
                                                                              ]),
                                                                              child: const Text(
                                                                                "CANCEL",
                                                                                style: TextStyle(color: Colors.white, fontSize: 18),
                                                                              ),
                                                                            )
                                                                          ],
                                                                        ).show(),
                                                                      },
                                                                    ),
                                                                  ],
                                                                ),
                                                              ])))
                                                ])),
                                      ])));
                        });
                  } else if (snapshot.hasError) {
                    return Text('${snapshot.error}');
                  }
                  // }
                  return const CircularProgressIndicator();
                }),
          ],
        )),
      ),
    ));
  }

  onTapPlusone(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.addRooms);
  }

  // Alert with multiple and custom buttons
  // _onAlertButtonsPressed(context) {
  //   Alert(
  //     context: context,
  //     type: AlertType.warning,
  //     title: "Do yo want to delete",
  //     desc: "Press the button to continue",
  //     buttons: [
  //       DialogButton(
  //         onPressed: () => {
  //           // delete.deleteAlbum(hotel_id.toString()),

  //           // implementation of delete
  //           Navigator.pop(context),
  //         },
  //         color: const Color.fromRGBO(0, 179, 134, 1.0),
  //         child: const Text(
  //           "DELETE",
  //           style: TextStyle(color: Colors.white, fontSize: 18),
  //         ),
  //       ),
  //       DialogButton(
  //         onPressed: () => {
  //           // implementation
  //           Navigator.pop(context)
  //         },
  //         gradient: const LinearGradient(colors: [
  //           Color.fromRGBO(116, 116, 191, 1.0),
  //           Color.fromRGBO(52, 138, 199, 1.0),
  //         ]),
  //         child: const Text(
  //           "EDIT",
  //           style: TextStyle(color: Colors.white, fontSize: 18),
  //         ),
  //       )
  //     ],
  //   ).show();
  // }
//
  // _onAlertWithCustomContentPressed(context) {
  //   Alert(
  //       context: context,
  //       title: "LOGIN",
  //       content: Column(
  //         children: const <Widget>[
  //           TextField(
  //             decoration: InputDecoration(
  //               icon: Icon(Icons.account_circle),
  //               labelText: 'Username',
  //             ),
  //           ),
  //           TextField(
  //             obscureText: true,
  //             decoration: InputDecoration(
  //               icon: Icon(Icons.lock),
  //               labelText: 'Password',
  //             ),
  //           ),
  //         ],
  //       ),
  //       buttons: [
  //         DialogButton(
  //           onPressed: () => Navigator.pop(context),
  //           child: const Text(
  //             "LOGIN",
  //             style: TextStyle(color: Colors.white, fontSize: 20),
  //           ),
  //         )
  //       ]).show();
  // }
}
