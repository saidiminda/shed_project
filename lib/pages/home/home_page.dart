import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:hotel_booking/classes/language_constants.dart';
import 'package:hotel_booking/utils/app_export.dart';
import 'package:hotel_booking/widgets/booking.dart';
import 'package:hotel_booking/widgets/client.dart';
import 'package:hotel_booking/widgets/propertyManage.dart';
import 'package:hotel_booking/pages/search_page/search_page.dart';
import 'package:hotel_booking/widgets/app_bar/appbar_subtitle_1.dart';
import 'package:hotel_booking/widgets/app_bar/appbar_title.dart';
import 'package:hotel_booking/widgets/custom_icon_button.dart';
import 'package:hotel_booking/widgets/switchAccount.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/user/user.dart';

// ignore_for_file: must_be_immutable
class HomePage extends StatefulWidget {
  final User? user;
  final int? index;
  final String? role;
  HomePage({this.user, this.index = 0, this.role});

  final bool _isShow = true;
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isShow = true;
  bool _isExpanded = true;
  late SharedPreferences logindata;
  String? username, phone, name, nameHotel;
  @override
  void initState() {
    super.initState();
    initial();
  }

// the ar
  void initial() async {
    logindata = await SharedPreferences.getInstance();
    setState(() {
      var userdata = jsonDecode(logindata.getString('userData') ?? "");
      username = userdata["email"] ?? "";
      phone = userdata["phone"] ?? "";
      name = userdata["name"] ?? "";
    });
  }

  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh() async {
    // monitor network fetch
    await Future.delayed(const Duration(milliseconds: 1000));
    _refreshController.refreshCompleted();
  }

  void _onChange() async {
    setState(() {
      isShow = !isShow;
    });
  }

  void _onLoading() async {
    // monitor network fetch
    await Future.delayed(const Duration(milliseconds: 1000));

    _refreshController.loadComplete();
  }

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    return SafeArea(
        child: Scaffold(
            drawer: Drawer(
              backgroundColor: Colors.white,
              width: MediaQuery.of(context).size.width * .6,
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xffC2892D),
                      elevation: 0,
                    ),
                    onPressed: _onChange,
                    child: UserAccountsDrawerHeader(
                      decoration: const BoxDecoration(color: Color(0xffC2892D)),
                      accountName: Text(
                        phone.toString(),
                        // phone number
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      accountEmail: Row(
                        children: [
                          Text(
                            username.toString(),
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Spacer(),
                          const Icon(Icons.arrow_drop_down_circle)
                        ],
                      ),
                      currentAccountPicture: Container(
                          padding: const EdgeInsets.all(10.0),
                          // ignore: prefer_const_constructors
                          child: CircleAvatar(
                              backgroundColor:
                                  const Color.fromARGB(255, 250, 250, 249),
                              child: Text(
                                // the name
                                name.toString(),
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xffC2892D)),
                              ))),
                    ),
                  ),

                  // ignore: dead_code
                  isShow
                      ? Column(
                          children: [
                            ListTile(
                              leading: const Icon(
                                Icons.add,
                              ),
                              // translation(context).home
                              title: const Text('Add Account'),
                              onTap: () {
                                Navigator.pushNamed(
                                    context, AppRoutes.registerPage);
                              },
                            ),
                            ListTile(
                              leading: const Icon(
                                Icons.home,
                              ),
                              title: Text(translation(context).home),
                              onTap: () {
                                Navigator.pushNamed(
                                    context, AppRoutes.dashboard);
                              },
                            ),
                            ListTile(
                              leading: const Icon(
                                Icons.check,
                              ),
                              title:
                                  Text(translation(context).checkAvailability1),
                              onTap: () {
                                Navigator.pushNamed(
                                    context, AppRoutes.checkAvailability);
                              },
                            ),
                            ListTile(
                              leading: const Icon(
                                Icons.train,
                              ),
                              title: Text(translation(context).booking),
                              onTap: () {
                                Navigator.pushNamed(
                                    context, AppRoutes.bookingList);
                              },
                            ),
                            ListTile(
                              leading: const Icon(
                                Icons.houseboat_outlined,
                              ),
                              title: Text(translation(context).property_list),
                              onTap: () {
                                Navigator.pushNamed(
                                    context, AppRoutes.propertyList);
                              },
                            ),
                            ListTile(
                              leading: const Icon(
                                Icons.house,
                              ),
                              title: Text(translation(context).room),
                              onTap: () {
                                Navigator.pushNamed(
                                    context, AppRoutes.roomList);
                              },
                            ),
                            ListTile(
                              leading: const Icon(
                                Icons.settings,
                              ),
                              title: Text(translation(context).settings),
                              onTap: () {
                                Navigator.pushNamed(
                                    context, AppRoutes.settings);
                              },
                            ),
                            // ListTile(
                            //   leading: const Icon(
                            //     Icons.update,
                            //   ),
                            //   title: const Text('Update'),
                            //   onTap: () {
                            //     Navigator.pushNamed(context, AppRoutes.update);
                            //   },
                            // ),
                            // end of delete
                          ],
                        )
                      : Column(children: [
                          ListTile(
                            leading: const Icon(
                              Icons.add,
                            ),
                            // translation(context).home
                            title: const Text("Add Account"),
                            onTap: () {
                              Navigator.pushNamed(
                                  context, AppRoutes.registerPage);
                            },
                          ),
                          SwitchAccount(),
                        ])
                ],
              ),
            ),
            backgroundColor: appTheme.gray50,
            resizeToAvoidBottomInset: false,
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(40.0),
              child: AppBar(
                  automaticallyImplyLeading: true,
                  backgroundColor: Colors.transparent,
                  iconTheme:
                      const IconThemeData(color: Color.fromARGB(255, 8, 8, 8)),
                  elevation: 0,
                  actions: [
                    Badge(
                      alignment: AlignmentDirectional.topStart,
                      isLabelVisible: false,
                      label: const Text('3'),
                      child: IconButton(
                          onPressed: () {
                            onTapNotification(context);
                          },
                          icon: const Icon(
                            Icons.notifications,
                            color: Color.fromARGB(255, 8, 8, 8),
                          )),
                    ),
                    GestureDetector(
                      child: Padding(
                          padding: getPadding(left: 10, top: 5, right: 21),
                          child: CircleAvatar(
                            backgroundImage: AssetImage(
                                ImageConstant.imgPexelsdaliladalprat1930634),
                          )),
                      onTap: () {
                        // onTapProfile(context);
                        onTapAccount(context);
                      },
                    ),
                  ]),
            ),
            body: SmartRefresher(
              enablePullDown: true,
              enablePullUp: true,
              controller: _refreshController,
              onRefresh: _onRefresh,
              onLoading: _onLoading,
              header: const WaterDropHeader(
                idleIcon: Icon(Icons.autorenew, size: 15, color: Colors.white),
                waterDropColor: Color.fromARGB(255, 235, 182, 113),
              ),
              child: SizedBox(
                  width: mediaQueryData.size.width,
                  child: SingleChildScrollView(
                      // padding: getPadding(top: 02),
                      child: Padding(
                          padding: getPadding(left: 28, bottom: 5),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: getPadding(
                                    left: 28,
                                    top: 1,
                                  ),
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        AppbarTitle(
                                          text: "Hi ! HYATT Hotel",
                                        ),
                                        AppbarSubtitle1(
                                          margin: getMargin(
                                            left: 3,
                                          ),
                                          text: translation(context).homePage,
                                          // translation(context).homePage
                                        ),
                                      ]),
                                ),
                                SearchPage(),
                                // search
                                Padding(
                                    padding: getPadding(left: 2, top: 0),
                                    child: Text(translation(context).what_new,
                                        style: CustomTextStyles
                                            .headlineSmallPrimary)),
                                Align(
                                    alignment: Alignment.centerRight,
                                    child: SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        padding: getPadding(left: 2),
                                        child: IntrinsicWidth(
                                            child: Container(
                                                decoration:
                                                    AppDecoration.fillOnPrimary,
                                                child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Container(
                                                          decoration: AppDecoration
                                                              .gradientCyanAToTealA
                                                              .copyWith(
                                                                  borderRadius:
                                                                      BorderRadiusStyle
                                                                          .roundedBorder16),
                                                          child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Padding(
                                                                    padding: getPadding(
                                                                        left:
                                                                            20,
                                                                        top: 19,
                                                                        bottom:
                                                                            19),
                                                                    child: Column(
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment
                                                                                .start,
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.start,
                                                                        children: [
                                                                          SizedBox(
                                                                              width: getHorizontalSize(155),
                                                                              child: Text(translation(context).offer1, maxLines: 3, overflow: TextOverflow.ellipsis, style: CustomTextStyles.titleSmallPrimary)),
                                                                          Padding(
                                                                              padding: getPadding(top: 14),
                                                                              child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                                                                Text(translation(context).off, style: CustomTextStyles.headlineSmallPrimary),
                                                                                CustomIconButton(height: getVerticalSize(30), width: getHorizontalSize(190), child: Text(translation(context).welcome, style: CustomTextStyles.headlineSmallPrimary))
                                                                              ]))
                                                                        ])),
                                                              ])),
                                                      // space between
                                                      Container(
                                                        width:
                                                            getHorizontalSize(
                                                                5),
                                                      ),
                                                      Container(
                                                          decoration: BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          getHorizontalSize(
                                                                              16)),
                                                              gradient: LinearGradient(
                                                                  begin:
                                                                      const Alignment(
                                                                          0.26,
                                                                          0),
                                                                  end: const Alignment(0.56, 1.25),
                                                                  colors: [
                                                                    appTheme
                                                                        .deepOrange200,
                                                                    appTheme
                                                                        .purple200,
                                                                    appTheme
                                                                        .deepPurpleA100
                                                                  ])),
                                                          child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Padding(
                                                                    padding: getPadding(
                                                                        left:
                                                                            20,
                                                                        top: 19,
                                                                        bottom:
                                                                            19),
                                                                    child: Column(
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment
                                                                                .start,
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.start,
                                                                        children: [
                                                                          SizedBox(
                                                                              width: getHorizontalSize(155),
                                                                              child: Text(translation(context).offer2, maxLines: 3, overflow: TextOverflow.ellipsis, style: CustomTextStyles.titleSmallPrimary)),
                                                                          Padding(
                                                                              padding: getPadding(top: 14),
                                                                              child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                                                                Text(translation(context).off, style: CustomTextStyles.headlineSmallPrimary),
                                                                                CustomIconButton(height: getVerticalSize(30), width: getHorizontalSize(190), child: Text(translation(context).welcome, style: CustomTextStyles.headlineSmallPrimary))
                                                                              ]))
                                                                        ])),
                                                              ])),
                                                    ]))))),

// manage ment
                                Padding(
                                    padding: getPadding(left: 2, top: 5),
                                    // management
                                    child: Text(translation(context).management,
                                        style: CustomTextStyles
                                            .headlineSmallPrimary)),
                                SizedBox(
                                    height: getVerticalSize(182),
                                    child: ListView.separated(
                                        padding: getPadding(top: 11, right: 4),
                                        scrollDirection: Axis.horizontal,
                                        separatorBuilder: (context, index) {
                                          return SizedBox(
                                              width: getHorizontalSize(10));
                                        },
                                        itemCount: 1,
                                        itemBuilder: (context, index) {
                                          return Row(
                                            children: [
                                              // CheckavailabiliItemWidget(
                                              //     onTapCheckavailabili: () {
                                              //   onTapCheckavailabili(context);
                                              // }),
                                              SizedBox(
                                                  width: getHorizontalSize(10)),
                                              // client
                                              ClientWidget(
                                                onTapAddClient: () {
                                                  onTapAddClient(context);
                                                },
                                              ),
                                              SizedBox(
                                                  width: getHorizontalSize(10)),
                                              BookingWidget(
                                                onTapBooking: () {
                                                  onTapAddBooking(context);
                                                },
                                              ),

                                              SizedBox(
                                                  width: getHorizontalSize(10)),
                                              RoomWidget(
                                                onTapProperty: () {
                                                  onTapAddProperty(context);
                                                },
                                              ),
                                            ],
                                          );
                                        })),

                                Padding(
                                    padding: getPadding(left: 2, top: 5),
                                    // Room Available
                                    child: Text(
                                        translation(context).room_available,
                                        style: CustomTextStyles
                                            .headlineSmallPrimary)),
                                Container(
                                    margin:
                                        getMargin(left: 2, top: 11, right: 30),
                                    padding: getPadding(
                                        left: 27,
                                        top: 15,
                                        right: 27,
                                        bottom: 15),
                                    decoration: AppDecoration.outlineBlack900
                                        .copyWith(
                                            borderRadius: BorderRadiusStyle
                                                .roundedBorder12),
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Expanded(
                                              child: Padding(
                                                  padding: getPadding(top: 1),
                                                  child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        Padding(
                                                          padding: getPadding(
                                                              top: 11),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Text(
                                                                  translation(
                                                                          context)
                                                                      .room,
                                                                  style: CustomTextStyles
                                                                      .bodyLargeBluegray700),
                                                              Text("4",
                                                                  style: CustomTextStyles
                                                                      .bodyLargeBluegray700),
                                                            ],
                                                          ),
                                                        ),
                                                        const Divider(
                                                          color: Colors.grey,
                                                        ),
                                                        Padding(
                                                          padding: getPadding(
                                                              top: 11),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Text(
                                                                  translation(
                                                                          context)
                                                                      .client,
                                                                  style: CustomTextStyles
                                                                      .bodyLargeBluegray700),
                                                              Text("300",
                                                                  style: CustomTextStyles
                                                                      .bodyLargeBluegray700),
                                                            ],
                                                          ),
                                                        )
                                                      ]))),
                                        ])),
                                Container(
                                    margin:
                                        getMargin(left: 2, top: 11, right: 30),
                                    padding: getPadding(
                                        left: 27,
                                        top: 15,
                                        right: 27,
                                        bottom: 15),
                                    decoration: AppDecoration.outlineBlack900
                                        .copyWith(
                                            borderRadius: BorderRadiusStyle
                                                .roundedBorder12),
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Padding(
                                              padding:
                                                  getPadding(top: 4, bottom: 2),
                                              child: Text("Dp.",
                                                  style: CustomTextStyles
                                                      .bodyLargeCyan300)),
                                          Padding(
                                              padding: getPadding(
                                                  left: 12, top: 4, bottom: 3),
                                              child: Text("01/08/2023",
                                                  style: CustomTextStyles
                                                      .bodyLargeBluegray700)),
                                          Padding(
                                              padding: getPadding(left: 13),
                                              child: SizedBox(
                                                  height: getVerticalSize(30),
                                                  child: VerticalDivider(
                                                      width:
                                                          getHorizontalSize(1),
                                                      thickness:
                                                          getVerticalSize(1),
                                                      endIndent:
                                                          getHorizontalSize(
                                                              3)))),
                                          Padding(
                                              padding: getPadding(
                                                  left: 12, top: 4, bottom: 3),
                                              child: Text("Ar.",
                                                  style: CustomTextStyles
                                                      .bodyLargeCyan300)),
                                          Padding(
                                              padding: getPadding(
                                                  left: 20,
                                                  top: 4,
                                                  right: 1,
                                                  bottom: 3),
                                              child: Text("31/08/2023",
                                                  style: CustomTextStyles
                                                      .bodyLargeBluegray700))
                                        ])),
                                Padding(
                                    padding: getPadding(
                                        left: 2,
                                        bottom: 50,
                                        top: 22,
                                        right: 30),
                                    child: Row(children: [
                                      Container(
                                          width: getHorizontalSize(165),
                                          padding: getPadding(
                                              left: 27,
                                              top: 12,
                                              right: 27,
                                              bottom: 12),
                                          decoration: AppDecoration
                                              .outlineBlack900
                                              .copyWith(
                                                  borderRadius:
                                                      BorderRadiusStyle
                                                          .roundedBorder12),
                                          child: Row(children: [
                                            Padding(
                                                padding: getPadding(
                                                    top: 1, bottom: 1),
                                                child: Text("Adult",
                                                    style: CustomTextStyles
                                                        .bodyLargeCyan300)),
                                            Padding(
                                                padding: getPadding(
                                                    left: 28, top: 1),
                                                child: Text("02",
                                                    style: CustomTextStyles
                                                        .bodyLargeBluegray700))
                                          ])),
                                      Container(
                                          width: getHorizontalSize(165),
                                          margin: getMargin(left: 24),
                                          padding: getPadding(
                                              left: 27,
                                              top: 12,
                                              right: 27,
                                              bottom: 12),
                                          decoration: AppDecoration
                                              .outlineBlack900
                                              .copyWith(
                                                  borderRadius:
                                                      BorderRadiusStyle
                                                          .roundedBorder12),
                                          child: Row(children: [
                                            Padding(
                                                padding: getPadding(top: 3),
                                                child: Text("Baby",
                                                    style: CustomTextStyles
                                                        .bodyLargeCyan300)),
                                            Padding(
                                                padding: getPadding(
                                                    left: 28, top: 2),
                                                child: Text("01",
                                                    style: CustomTextStyles
                                                        .bodyLargeBluegray700))
                                          ])),
                                    ])),
                              ])))),
            )));
  }

// check Availability
  onTapCheckavailabili(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.roomList);
  }

// client List
  onTapAddClient(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.clientList);
  }

// Add booking
  onTapAddBooking(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.bookingList);
  }

  // Navigator.pushNamed(context, AppRoutes.propertyList
// add Property
  onTapAddProperty(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.propertyList);
  }

  onTapNotification(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.notification);
  }

  onTapAccount(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.account);
  }

  // profile
  onTapProfile(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.profile);
  }
}
