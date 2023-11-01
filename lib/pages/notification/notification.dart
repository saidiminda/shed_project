import 'package:flutter/material.dart';
import 'package:hotel_booking/classes/language_constants.dart';
import 'package:hotel_booking/utils/app_export.dart';
import 'package:hotel_booking/widgets/app_bar/appbar_subtitle.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

// ignore_for_file: must_be_immutable
class NotificationScreen extends StatelessWidget {
  NotificationScreen({Key? key}) : super(key: key);

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final List<Widget> _views = [
    SizedBox(
      width: 400,
      height: 400,
      child: Card(
        borderOnForeground: true,
        child: Column(children: [
          Container(
            margin: const EdgeInsets.only(top: 2),
            height: 100,
            padding: const EdgeInsets.only(
              left: 2,
              right: 2,
              bottom: 20,
            ),
            child: Container(
              height: 400,
              width: 400,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 248, 173, 150),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(80.0),
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
              child: Padding(
                padding: getPadding(top: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'The Best',
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    Text(
                      'Your Life Start Here',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ]),
      ),
    ),
    Card(
      borderOnForeground: true,
      child: Column(children: [
        Container(
          margin: const EdgeInsets.only(top: 2),
          height: 100,
          padding: const EdgeInsets.only(
            left: 2,
            right: 2,
            bottom: 20,
          ),
          child: Container(
            height: 400,
            width: 400,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 248, 173, 150),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(80.0),
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
            child: Padding(
              padding: getPadding(top: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'The Best',
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  Text(
                    'Your Life Start Here',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
        ),
      ]),
    ),
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
                bottomLeft: Radius.circular(80.0),
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
                Padding(
                  padding: getPadding(top: 5),
                  child: Row(
                    children: [
                      Text("RefNo:  ",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: CustomTextStyles.titleMediumOnPrimary),
                      Expanded(
                        child: Text("AZM4b4eb20d17db4223a7e8f975a3afcaf1",
                            maxLines: 1,
                            softWrap: false,
                            overflow: TextOverflow.ellipsis,
                            style: CustomTextStyles.titleMediumOnPrimary),
                      )
                    ],
                  ),
                ),
                Divider(
                    color: theme.colorScheme.onPrimary.withOpacity(1),
                    indent: getHorizontalSize(13),
                    endIndent: getHorizontalSize(12)),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                        padding: getPadding(left: 13, right: 39),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(children: [
                              Padding(
                                  padding: getPadding(bottom: 1),
                                  child: Text("Amount",
                                      style: CustomTextStyles
                                          .titleMediumOnPrimary)),
                              Text("40,000.00",
                                  style: CustomTextStyles.titleMediumOnPrimary),
                            ]),
                            Column(children: [
                              Padding(
                                  padding: getPadding(bottom: 1),
                                  child: Text("Role",
                                      style: CustomTextStyles
                                          .titleMediumOnPrimary)),
                              Text("PMS",
                                  style: CustomTextStyles.titleMediumOnPrimary),
                            ]),
                          ],
                        ))),
                Divider(
                    color: theme.colorScheme.onPrimary.withOpacity(1),
                    indent: getHorizontalSize(13),
                    endIndent: getHorizontalSize(12)),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                        padding: getPadding(left: 13, right: 39),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(children: [
                              Padding(
                                  padding: getPadding(bottom: 1),
                                  child: Text("Date",
                                      style: CustomTextStyles
                                          .titleMediumOnPrimary)),
                              Text("07/09/2023",
                                  style: CustomTextStyles.titleMediumOnPrimary),
                            ]),
                            Column(children: [
                              Padding(
                                  padding: getPadding(bottom: 1),
                                  child: Text("Status",
                                      style: CustomTextStyles
                                          .titleMediumOnPrimary)),
                              Text("Success",
                                  style: CustomTextStyles.titleMediumOnPrimary),
                            ]),
                          ],
                        ))),
              ],
            ),
          ),
        ),
      ]),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            iconTheme: const IconThemeData(color: Color.fromARGB(255, 8, 8, 8)),
            title: Center(
              child: AppbarSubtitle(
                // translation(context).add_room
                text: 'Notifications',
              ),
            ),
            bottom: TabBar(
                labelColor: Colors.deepOrange,
                unselectedLabelColor: Colors.black,
                indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                ),
                splashBorderRadius: BorderRadius.circular(40),
                tabs: const [
                  Tab(
                    text: "What's New",
                  ),
                  Tab(
                    text: " Activity",
                  ),
                  Tab(
                    text: "Subscription",
                  )
                ]),
          ),
          body: TabBarView(
            physics: const BouncingScrollPhysics(),
            children: _views,
          ),
        ));
  }

  onTapSave(BuildContext context) {
    // Navigator.pushNamed(context, AppRoutes.bookListScreen);
  }
}
