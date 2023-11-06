import 'package:flutter/material.dart';
import 'package:hotel_booking/classes/language_constants.dart';
import 'package:hotel_booking/constants.dart';
import 'package:hotel_booking/models/manageClient/clientModel.dart';
import 'package:hotel_booking/pages/manage_client/edit_client_details.dart';
import 'package:hotel_booking/service/manage_client/manageClientController.dart';
import 'package:hotel_booking/utils/app_export.dart';
import 'package:hotel_booking/pages/manage_client/search_client.dart';
import 'package:hotel_booking/widgets/custom_text_form_field.dart';
// ignore: unused_import
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:hotel_booking/widgets/app_bar/appbar_image.dart';
import 'package:hotel_booking/widgets/app_bar/appbar_subtitle.dart';
import 'package:hotel_booking/widgets/app_bar/custom_app_bar.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:outline_gradient_button/outline_gradient_button.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:bottom_sheet/bottom_sheet.dart';

class ClientListScreen extends StatefulWidget {
  const ClientListScreen({Key? key}) : super(key: key);

  @override
  State<ClientListScreen> createState() => _ClientListScreenState();
}

class _ClientListScreenState extends State<ClientListScreen> {
// the  given area below
  late SharedPreferences logindata;
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  RegiserClientService view = RegiserClientService();
  late Future<void> loadAllBanksFuture;
  String? username, phone;
  void _onRefresh() async {
    // monitor network fetch
    
    await Future.delayed(const Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    // monitor network fetch
    
    await Future.delayed(Duration(milliseconds: 1000));

    _refreshController.loadComplete();
  }

  Future<List<ClientclientModel>> fetchAlbum() async {
    logindata = await SharedPreferences.getInstance();
    var userdata = jsonDecode(logindata.getString('userData') ?? "");
    int userId = int.parse(userdata["id"].toString());
    try {
      String url = "$domainUrl/get_hotel_client/${userId}/index";
      final response = await http.get(Uri.parse(url), headers: headers);

      if (response.statusCode == 200) {
        final List result = json.decode(response.body)['client'];
        return result.map((e) => ClientclientModel.fromJson(e)).toList();
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print(e);
      throw e;
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
        iconTheme: IconThemeData(color: Color.fromARGB(255, 8, 8, 8)),
        title: Center(
          child: AppbarSubtitle(
            // Client List
            text: translation(context).client_list,
          ),
        ),
        actions: [
          TextButton.icon(
              onPressed: () {
                onTapPlusone(context);
              },
              icon: const Icon(
                Icons.add,
                color: Color.fromARGB(255, 8, 8, 8),
              ),
              label: Text(''))
        ],
      ),
      body: SmartRefresher(
        enablePullDown: true,
        enablePullUp: false,
        controller: _refreshController,
        onRefresh: _onRefresh,
        onLoading: _onLoading,
        header: const WaterDropHeader(
          idleIcon: Icon(Icons.autorenew, size: 25, color: Colors.white),
          waterDropColor: Color.fromARGB(255, 235, 182, 113),
        ),
        child: SingleChildScrollView(
          child: Container(
              width: double.maxFinite,
              padding: getPadding(left: 20, top: 5, right: 20, bottom: 5),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SearchClient(),
                    Padding(
                      padding: getPadding(left: 17, right: 17, bottom: 5),
                      child: Container(
                        height: 40,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            gradient: const LinearGradient(colors: [
                              Colors.orangeAccent,
                              Colors.white,
                              Colors.orangeAccent,
                            ])),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text(
                              "Number of Clients",
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
                    SingleChildScrollView(
                      child: Center(
                        child: FutureBuilder<List<ClientclientModel>>(
                          initialData: [],
                          future: fetchAlbum(),
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
                                          padding: getPadding(top: 10),
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
                                                        children: [
                                                          const CircleAvatar(
                                                            foregroundColor:
                                                                Colors.black,
                                                            minRadius: 10,
                                                            child: Icon(Icons
                                                                .person_2_rounded),
                                                          ),
                                                          const SizedBox(
                                                            width: 20,
                                                          ),
                                                          Text(
                                                              snapshot
                                                                  .data![index]
                                                                  .clientName
                                                                  .toString(),
                                                              maxLines: 1,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              style: CustomTextStyles
                                                                  .headlineSmallBold),
                                                          const SizedBox(
                                                            width: 100,
                                                          ),
                                                          Text(
                                                              snapshot
                                                                  .data![index]
                                                                  .clientidentity_type
                                                                  .toString(),
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
                                                                        snapshot
                                                                            .data![
                                                                                index]
                                                                            .clientName
                                                                            .toString(),
                                                                        style: CustomTextStyles
                                                                            .titleMediumOnPrimary)),
                                                                Text(
                                                                    snapshot
                                                                        .data![
                                                                            index]
                                                                        .clientidentity_no
                                                                        .toString(),
                                                                    style: CustomTextStyles
                                                                        .titleMediumOnPrimary),
                                                                Padding(
                                                                    padding: getPadding(
                                                                        bottom:
                                                                            1),
                                                                    child: Text(
                                                                        snapshot
                                                                            .data![
                                                                                index]
                                                                            .clientPhone
                                                                            .toString(),
                                                                        style: CustomTextStyles
                                                                            .titleMediumOnPrimary))
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
                                                              right: 3),
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
                                                                        snapshot
                                                                            .data![
                                                                                index]
                                                                            .clientoccupation
                                                                            .toString(),
                                                                        // clientoccupation
                                                                        style: CustomTextStyles
                                                                            .titleMediumOnPrimary)),
                                                                Text(
                                                                    snapshot
                                                                        .data![
                                                                            index]
                                                                        .clientAdress
                                                                        .toString(),
                                                                    // clientAdress
                                                                    maxLines: 2,
                                                                    style: CustomTextStyles
                                                                        .titleMediumOnPrimary),
                                                                Padding(
                                                                  padding:
                                                                      getPadding(
                                                                          bottom:
                                                                              1),
                                                                  child: Text(
                                                                      snapshot
                                                                          .data![
                                                                              index]
                                                                          .clientPhone
                                                                          .toString(),
                                                                      style: CustomTextStyles
                                                                          .titleMediumOnPrimary),
                                                                ),
                                                                CircleAvatar(
                                                                  foregroundColor:
                                                                      const Color
                                                                              .fromARGB(
                                                                          255,
                                                                          113,
                                                                          238,
                                                                          74),
                                                                  backgroundColor:
                                                                      Color.fromARGB(
                                                                          0,
                                                                          0,
                                                                          0,
                                                                          0),
                                                                  minRadius: 10,
                                                                  child:
                                                                      GestureDetector(
                                                                    child: Icon(
                                                                        Icons
                                                                            .edit),
                                                                    onTap: () {
                                                                      showStickyFlexibleBottomSheet(
                                                                  
                                                                        minHeight:
                                                                            0,
                                                                        initHeight:
                                                                            0.5,
                                                                        maxHeight:
                                                                            1,
                                                                        headerHeight:
                                                                            60,
                                                                        context:
                                                                            context,
                                                                        bottomSheetColor:
                                                                            Colors.white,
                                                                        headerBuilder: (BuildContext
                                                                                context,
                                                                            double
                                                                                offset) {
                                                                          return Container(child:     Padding(
                                                                            padding:
                                                                                const EdgeInsets.all(5.0),
                                                                            child:
                                                                                Column(
                                                                                  mainAxisAlignment: MainAxisAlignment.center, 
                                                                                children: [
                                                                              Row(
                                                                                children: [
                                                                                  IconButton(
                                                                                      onPressed: () {
                                                                                        Navigator.pop(context);
                                                                                      },
                                                                                      icon: const Icon(Icons.arrow_back_outlined)),
                                                                                  const SizedBox(width: 50),
                                                                                  Text(
                                                                                    'Edit Client Details',
                                                                                    style: const TextStyle(color: Colors.orangeAccent),
                                                                                  ),
                                                                                  SizedBox(width: 80),
                                                                                  IconButton(
                                                                                    onPressed: () {
                                                                                      Navigator.pop(context);
                                                                                    },
                                                                                    icon: const Icon(Icons.close_rounded),
                                                                                    color: Colors.red,
                                                                                  )
                                                                                ],
                                                                              ),
                                                                            ]),
                                                                          ),
                                                                                decoration:
                                                                            BoxDecoration(
                                                                          borderRadius:
                                                                              BorderRadius.only(
                                                                            topLeft:
                                                                                Radius.circular(30.0),
                                                                            topRight:
                                                                                Radius.circular(30.0),
                                                                          ),
                                                                        ),
                                                                          );
                                                                      
                                                                        },
                                                                        bodyBuilder: (BuildContext
                                                                                context,
                                                                            double
                                                                                offset) {
                                                                          return SliverChildListDelegate(
                                                                            <Widget>[
                                                                              EditClientScreen(),
                                                                            ],
                                                                          );
                                                                        },
                                                                        anchors: [
                                                                          0,
                                                                          0.5,
                                                                          1
                                                                        ],
                                                                      );
                                                                    },
                                                                  ),
                                                                ),
                                                              ])))
                                                ])),
                                      ]);
                                },
                              );
                            } else if (snapshot.hasError) {
                              return Container(
                                  padding: getPadding(
                                      left: 20, top: 150, right: 20, bottom: 5),
                                  child: Center(
                                      child: Column(
                                    children: [
                                      Icon(
                                        Icons.emoji_emotions,
                                        size: 200,
                                        color:
                                            Color.fromARGB(255, 241, 229, 178),
                                      ),
                                      Text('No Client Registered'),
                                    ],
                                  )));
                              ;
                            }
                            return const CircularProgressIndicator();
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              )),
        ),
      ),
    ));
  }

  /// to push the named route for the addClientScreen.
  onTapPlusone(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.addClient);
  }
}
