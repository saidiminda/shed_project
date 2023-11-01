import 'package:flutter/material.dart';
import 'package:hotel_booking/classes/language_constants.dart';
import 'package:hotel_booking/pages/manage_property/search_Property.dart';
import 'package:hotel_booking/utils/app_export.dart';
import 'package:hotel_booking/pages/manage_client/search_client.dart';
// ignore: unused_import
import 'package:hotel_booking/widgets/app_bar/appbar_image.dart';
import 'package:hotel_booking/widgets/app_bar/appbar_subtitle.dart';
import 'package:hotel_booking/widgets/app_bar/custom_app_bar.dart';

import 'package:outline_gradient_button/outline_gradient_button.dart';

class ViewPropertyListScreen extends StatelessWidget {
  const ViewPropertyListScreen({Key? key}) : super(key: key);
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
                padding: const EdgeInsets.all(5.0),
                child: Center(
                  child: AppbarSubtitle(
                    // translation(context).booking_list
                    // Client List
                    text: 'Property List',
                  ),
                ),
                // Spacer(),
              ),
              actions: [
                TextButton.icon(
                    style: ButtonStyle(),
                    onPressed: () {
                      onTapPlusone(context);
                    },
                    icon: Icon(
                      Icons.add,
                      color: Color.fromARGB(255, 8, 8, 8),
                    ),
                    label: Text(''))
              ],
            ),
            body: Container(
                // width: double.maxFinite,
                padding: getPadding(left: 20, top: 5, right: 20, bottom: 5),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: getPadding(top: 1),
                      ),
                      SearchProperty(),
                      Padding(
                        padding: getPadding(top: 5),
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
                                  padding: getPadding(top: 5),
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
                                            Column(children: [
                                              Padding(
                                                  padding:
                                                      getPadding(bottom: 1),
                                                  child: Text("RefNo:",
                                                      style: CustomTextStyles
                                                          .titleMediumOnPrimary)),
                                              Text("099999",
                                                  style: CustomTextStyles
                                                      .titleMediumOnPrimary),
                                            ]),
                                            Column(children: [
                                              Padding(
                                                  padding:
                                                      getPadding(bottom: 1),
                                                  child: Text("Property Name:",
                                                      style: CustomTextStyles
                                                          .titleMediumOnPrimary)),
                                              Text("Gest",
                                                  style: CustomTextStyles
                                                      .titleMediumOnPrimary),
                                            ]),
                                          ],
                                        ))),
                                Divider(
                                    color: theme.colorScheme.onPrimary
                                        .withOpacity(1),
                                    indent: getHorizontalSize(13),
                                    endIndent: getHorizontalSize(12)),
                                Padding(
                                  padding: getPadding(top: 5),
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
                                            Column(children: [
                                              Padding(
                                                  padding:
                                                      getPadding(bottom: 1),
                                                  child: Text("Property Type:",
                                                      style: CustomTextStyles
                                                          .titleMediumOnPrimary)),
                                              Text("Mteja Mteja",
                                                  style: CustomTextStyles
                                                      .titleMediumOnPrimary),
                                            ]),
                                            Column(children: [
                                              Padding(
                                                  padding:
                                                      getPadding(bottom: 1),
                                                  child: Text(
                                                      "Property Adress:",
                                                      style: CustomTextStyles
                                                          .titleMediumOnPrimary)),
                                              Text("Makulu",
                                                  style: CustomTextStyles
                                                      .titleMediumOnPrimary),
                                            ]),
                                          ],
                                        ))),
                                Padding(
                                    padding: getPadding(top: 5),
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
                                            Column(children: [
                                              Padding(
                                                  padding:
                                                      getPadding(bottom: 1),
                                                  child: Text(
                                                      "Property PhoneNo:",
                                                      style: CustomTextStyles
                                                          .titleMediumOnPrimary)),
                                              Text("07XXXXX0",
                                                  style: CustomTextStyles
                                                      .titleMediumOnPrimary),
                                            ]),
                                            Column(children: [
                                              Padding(
                                                  padding:
                                                      getPadding(bottom: 1),
                                                  child: Text("Action:",
                                                      style: CustomTextStyles
                                                          .titleMediumOnPrimary)),
                                              Text("Edit",
                                                  style: CustomTextStyles
                                                      .titleMediumOnPrimary),
                                            ]),
                                          ],
                                        ))),
                              ])),
                    ]))));
  }

  /// Navigates to the addClientScreen when the action is triggered.
  ///
  /// The [BuildContext] parameter is used to build the navigation stack.
  /// When the action is triggered, this function uses the [Navigator] widget
  /// to push the named route for the addClientScreen.
  onTapPlusone(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.viewProperty);
  }
}
