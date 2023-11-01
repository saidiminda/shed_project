import 'package:flutter/material.dart';
import 'package:hotel_booking/classes/language_constants.dart';
import 'package:hotel_booking/constants.dart';
import 'package:hotel_booking/models/manageClient/clientModel.dart';
import 'package:hotel_booking/service/manage_client/manageClientController.dart';
import 'package:hotel_booking/utils/app_export.dart';
import 'package:hotel_booking/pages/manage_client/search_client.dart';
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
    try{
    String url = "$domainUrl/get_hotel_client/${userId}/index";
    final response = await http.get(Uri.parse(url), headers: headers);

    if (response.statusCode == 200) {
      final List result = json.decode(response.body)['client'];
      return result.map((e) => ClientclientModel.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load data');
    }
    }  catch(e){ 
       print (e); 
       throw e;}
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
                    const Padding(
                      padding: EdgeInsets.all(15),
                      child: Text(
                        "Recent Clients",
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.green),
                      ),
                    ),
                    SingleChildScrollView(
                child:
                    Center(
                      child: FutureBuilder<List<ClientclientModel>>(
                        future: fetchAlbum(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return ListView.builder(
                              shrinkWrap: true,
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context, index) {
                                return Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
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
                                                  padding: getPadding(top: 10),
                                                ),
                                                Container(
                                                    margin:
                                                        getMargin(bottom: 1),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
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
                                                        getHorizontalSize(12)),
                                                Padding(
                                                  padding: getPadding(top: 10),
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
                                                                  padding:
                                                                      getPadding(
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
                                                                          .titleMediumOnPrimary))
                                                            ]))),
                                                Padding(
                                                    padding:
                                                        getPadding(top: 16),
                                                    child: Divider(
                                                        color: theme.colorScheme
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
                                                                  padding:
                                                                      getPadding(
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
                                                                          .titleMediumOnPrimary))
                                                            ])))
                                              ])),
                                    ]);
                              },
                            );
                          } else if (snapshot.hasError) {
                            return Text('${snapshot.error}');
                          }
                          return const CircularProgressIndicator();
                        },
                      ),
                    ),),
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
