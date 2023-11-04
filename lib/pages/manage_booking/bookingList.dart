import 'package:flutter/material.dart';
import 'package:hotel_booking/classes/language_constants.dart';
import 'package:hotel_booking/models/manageBooking/manageBookingModel.dart';
import 'package:hotel_booking/pages/manage_booking/searchBooking.dart';
import 'package:hotel_booking/utils/app_export.dart';
// ignore: unused_import
import 'dart:convert';
import 'package:hotel_booking/constants.dart';
import 'package:hotel_booking/widgets/app_bar/appbar_image.dart';
import 'package:hotel_booking/widgets/app_bar/appbar_subtitle.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class BookingListScreen extends StatefulWidget {
  const BookingListScreen({Key? key}) : super(key: key);

  @override
  State<BookingListScreen> createState() => _BookingListScreenState();
}

class _BookingListScreenState extends State<BookingListScreen> {
  late SharedPreferences logindata;
  String? username, phone, name, nameHotel, status;
  @override
  void initState() {
    super.initState();
    initial();
  }

//
  void initial() async {
    logindata = await SharedPreferences.getInstance();
    setState(() {
      var userdata = jsonDecode(logindata.getString('bookingData') ?? "");
      username = userdata["reference_no"] ?? "";
      phone = userdata["phone"] ?? "";
      name = userdata["name"] ?? "";
      status = userdata["status"] ?? "";
    });
  }

  Future<List<BookingModel>> fetchBooking() async {
    logindata = await SharedPreferences.getInstance();
    var userdata = jsonDecode(logindata.getString('userData') ?? "");
    int userId = int.parse(userdata["id"].toString());
    String url = "$domainUrl/booking/${userId}/index";
    final response = await http.get(Uri.parse(url), headers: headers);

    if (response.statusCode == 200) {
      final List result = json.decode(response.body)['invoice'];
      return result.map((e) => BookingModel.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load booking data ..');
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
              iconTheme:
                  const IconThemeData(color: Color.fromARGB(255, 8, 8, 8)),
              title: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Center(
                  child: AppbarSubtitle(
                    // Client List
                    text: translation(context).booking_list,
                  ),
                ),
              ),
              actions: [
                TextButton.icon(
                    style: ButtonStyle(),
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
            body: Container(
                width: double.maxFinite,
                padding: getPadding(left: 20, top: 5, right: 20, bottom: 5),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: getPadding(top: 1),
                      ),
                      SearchBooking(),
                        Padding(
                     padding: getPadding(left: 17,  right: 17, bottom: 5),
                      child: Container(
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                        gradient: const LinearGradient(colors: [
                          Colors.orangeAccent,
                             Colors.white,
                          Colors.orangeAccent,
                       
                        ])
                        ),
                       
                        child: Row(
                           mainAxisAlignment : MainAxisAlignment.spaceBetween,
                          children: const [
                            Text(
                              "Number of Booking",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                            Text(
                              "000",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                    ),
                      Center(
                          child: FutureBuilder<List<BookingModel>>(
                              future: fetchBooking(),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: snapshot.data!.length,
                                      itemBuilder: (context, index) {
                                        return Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: getPadding(top: 5),
                                              ),
                                              Container(
                                                  margin: getMargin(
                                                      left: 13,
                                                      top: 2,
                                                      right: 13),
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
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Padding(
                                                          padding: getPadding(
                                                              top: 5),
                                                        ),
                                                        Container(
                                                            margin: getMargin(
                                                                bottom: 1),
                                                            child: Row(
                                                              children: [
                                                                // reference_no
                                                                Text("RefNo:  ",
                                                                    maxLines: 1,
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                    style: CustomTextStyles
                                                                        .headlineSmallBold),
                                                                Text(
                                                                    "99848848488484",
                                                                    maxLines: 1,
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                    style: CustomTextStyles
                                                                        .headlineSmallBold)
                                                              ],
                                                            )),
                                                        Divider(
                                                            color: theme
                                                                .colorScheme
                                                                .onPrimary
                                                                .withOpacity(1),
                                                            indent:
                                                                getHorizontalSize(
                                                                    13),
                                                            endIndent:
                                                                getHorizontalSize(
                                                                    12)),
                                                        Padding(
                                                          padding: getPadding(
                                                              top: 5),
                                                        ),
                                                        Align(
                                                            alignment: Alignment
                                                                .centerLeft,
                                                            child: Padding(
                                                                padding:
                                                                    getPadding(
                                                                        left:
                                                                            13,
                                                                        right:
                                                                            39),
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    Column(
                                                                        children: [
                                                                          Padding(
                                                                              padding: getPadding(bottom: 1),
                                                                              child: Text("Client:", style: CustomTextStyles.titleMediumOnPrimary)),
                                                                          Text(
                                                                              snapshot.data![index].user_nameAgent.toString(),
                                                                              style: CustomTextStyles.titleMediumOnPrimary),
                                                                        ]),
                                                                    Column(
                                                                        children: [
                                                                          Padding(
                                                                              padding: getPadding(bottom: 1),
                                                                              child: Text("Amount:", style: CustomTextStyles.titleMediumOnPrimary)),
                                                                          Text(
                                                                              "20,000/=",
                                                                              style: CustomTextStyles.titleMediumOnPrimary),
                                                                        ]),
                                                                  ],
                                                                ))),
                                                        Padding(
                                                            padding: getPadding(
                                                                top: 5),
                                                            child: Divider(
                                                                color: theme
                                                                    .colorScheme
                                                                    .onPrimary
                                                                    .withOpacity(
                                                                        1),
                                                                indent:
                                                                    getHorizontalSize(
                                                                        13),
                                                                endIndent:
                                                                    getHorizontalSize(
                                                                        12))),
                                                        Align(
                                                            alignment: Alignment
                                                                .centerLeft,
                                                            child: Padding(
                                                                padding:
                                                                    getPadding(
                                                                        left:
                                                                            13,
                                                                        right:
                                                                            39),
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    Column(
                                                                        children: [
                                                                          Padding(
                                                                              padding: getPadding(bottom: 1),
                                                                              child: Text("Property:", style: CustomTextStyles.titleMediumOnPrimary)),
                                                                          Text(
                                                                              "Bed Room",
                                                                              style: CustomTextStyles.titleMediumOnPrimary),
                                                                        ]),
                                                                    Column(
                                                                        children: [
                                                                          Padding(
                                                                              padding: getPadding(bottom: 1),
                                                                              child: Text("Staus:", style: CustomTextStyles.titleMediumOnPrimary)),
                                                                          Text(
                                                                              "Available",
                                                                              style: CustomTextStyles.titleMediumOnPrimary),
                                                                        ]),
                                                                  ],
                                                                ))),
                                                      ])),
                                            ]);
                                      });
                                } else if (snapshot.hasError) {
                                  return Text('${snapshot.error}');
                                }
                                return const CircularProgressIndicator();
                              })),
                    ]))));
  }

  onTapPlusone(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.addBooking);
  }
}
