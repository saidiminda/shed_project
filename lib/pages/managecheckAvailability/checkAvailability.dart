import 'package:flutter/material.dart';
import 'package:hotel_booking/classes/language_constants.dart';
import 'package:hotel_booking/utils/app_export.dart';
// ignore: unused_import
import 'package:hotel_booking/widgets/app_bar/appbar_image.dart';
import 'package:hotel_booking/widgets/app_bar/appbar_subtitle.dart';
import 'package:hotel_booking/widgets/app_bar/custom_app_bar.dart';

import 'package:outline_gradient_button/outline_gradient_button.dart';

class CheckAvailabilityScreen extends StatelessWidget {
  const CheckAvailabilityScreen({Key? key}) : super(key: key);
// the  given area below
  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.transparent,
              iconTheme: IconThemeData(color: Color.fromARGB(255, 8, 8, 8)),
              title: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Center(
                  child: AppbarSubtitle(
                    // Client List
                    //  translation(context).client_list
                    text: 'Check Availability',
                  ),
                ),
              ),
              actions: [
                TextButton.icon(
                    onPressed: () {
                      onTapPlusone(context);
                    },
                    icon: Icon(
                      Icons.book_online,
                      color: Color.fromARGB(255, 8, 8, 8),
                    ),
                    label: Text('Book'))
              ],
            ),
            body: Container(
                width: double.maxFinite,
                padding: getPadding(left: 20, top: 5, right: 20, bottom: 5),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: getPadding(top: 10),
                      ),
                      Container(
                          margin: getMargin(left: 13, top: 2, right: 13),
                          padding: getPadding(
                              left: 14, top: 2, right: 14, bottom: 17),
                          decoration: AppDecoration.gradientCyanToTealA
                              .copyWith(
                                  borderRadius:
                                      BorderRadiusStyle.roundedBorder12),
                          child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: getPadding(top: 10),
                                ),
                                Container(
                                    margin: getMargin(bottom: 1),
                                    child: Row(
                                      children: [
                                        Text("2  Rooms,",
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: CustomTextStyles
                                                .headlineSmallBold),
                                        Text("Found",
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: CustomTextStyles
                                                .headlineSmallBold)
                                      ],
                                    )),
                                Divider(
                                    color: theme.colorScheme.onPrimary
                                        .withOpacity(1),
                                    indent: getHorizontalSize(13),
                                    endIndent: getHorizontalSize(12)),
                                Padding(
                                  padding: getPadding(top: 10),
                                ),
                                Align(
                                    alignment: Alignment.centerLeft,
                                    child: Padding(
                                        padding:
                                            getPadding(left: 13, right: 39),
                                        child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Padding(
                                                  padding:
                                                      getPadding(bottom: 1),
                                                  child: Text("Tanzanian",
                                                      style: CustomTextStyles
                                                          .titleMediumOnPrimary)),
                                              Text("National Id",
                                                  style: CustomTextStyles
                                                      .titleMediumOnPrimary),
                                              Padding(
                                                  padding:
                                                      getPadding(bottom: 1),
                                                  child: Text("04434466566",
                                                      style: CustomTextStyles
                                                          .titleMediumOnPrimary))
                                            ]))),
                                Padding(
                                    padding: getPadding(top: 16),
                                    child: Divider(
                                        color: theme.colorScheme.onPrimary
                                            .withOpacity(1),
                                        indent: getHorizontalSize(13),
                                        endIndent: getHorizontalSize(12))),
                                Align(
                                    alignment: Alignment.centerLeft,
                                    child: Padding(
                                        padding:
                                            getPadding(left: 13, right: 39),
                                        child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Padding(
                                                  padding:
                                                      getPadding(bottom: 1),
                                                  child: Text("Bukoba",
                                                      style: CustomTextStyles
                                                          .titleMediumOnPrimary)),
                                              Text("P.Box, 10 ",
                                                  maxLines: 2,
                                                  style: CustomTextStyles
                                                      .titleMediumOnPrimary),
                                              // Padding(
                                              //     padding:
                                              //         getPadding(bottom: 1),
                                              //     child: Text("05",
                                              //         style: CustomTextStyles
                                              //             .titleMediumOnPrimary)),
                                              Padding(
                                                  padding:
                                                      getPadding(bottom: 1),
                                                  child: Text("+255 654327335",
                                                      style: CustomTextStyles
                                                          .titleMediumOnPrimary))
                                            ])))
                              ])),
                    ]))));
  }

  onTapPlusone(BuildContext context) {
    // Navigator.pushNamed(context, AppRoutes.addClient);
  }
}
