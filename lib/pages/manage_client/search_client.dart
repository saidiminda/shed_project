import 'package:flutter/material.dart';
import 'package:hotel_booking/classes/language_constants.dart';
import 'package:hotel_booking/utils/app_export.dart';
import 'package:hotel_booking/widgets/custom_search_view.dart';
import 'package:outline_gradient_button/outline_gradient_button.dart';

// ignore_for_file: must_be_immutable
class SearchClient extends StatelessWidget {
  SearchClient({Key? key}) : super(key: key);

  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.maxFinite,
        child: Container(
            padding: getPadding(left: 17, top: 10, right: 17, bottom: 10),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.start, children: [
              OutlineGradientButton(
                padding: EdgeInsets.only(
                    left: getHorizontalSize(1),
                    top: getVerticalSize(1),
                    right: getHorizontalSize(1),
                    bottom: getVerticalSize(1)),
                strokeWidth: getHorizontalSize(1),
                gradient: LinearGradient(
                    begin: Alignment(0.5, 0),
                    end: Alignment(0.5, 1),
                    colors: [
                      appTheme.deepOrange700,
                      theme.colorScheme.primary
                    ]),
                corners: const Corners(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                    bottomLeft: Radius.circular(12),
                    bottomRight: Radius.circular(12)),
                // ignore: sort_child_properties_last
                child: CustomSearchView(
                    controller: searchController,
                    hintText: translation(context).search_list,
                    hintStyle: CustomTextStyles.bodyLargeBluegray700,
                    suffix: Container(
                        margin:
                            getMargin(left: 30, top: 18, right: 13, bottom: 18),
                        child: CustomImageView(
                          imagePath: ImageConstant.imgSearch24x24,
                          height: getSize(24),
                          width: getSize(24),
                        )),
                    suffixConstraints:
                        BoxConstraints(maxHeight: getVerticalSize(60)),
                    contentPadding: getPadding(left: 30, top: 18, bottom: 18)),
                onTap: onTapSearch(context),
              ),
            ])));
  }

  onTapSearch(BuildContext context) {
    Container(
        margin: getMargin(left: 13, top: 15, right: 13),
        padding: getPadding(left: 14, top: 17, right: 14, bottom: 17),
        decoration: AppDecoration.gradientCyanToTealA
            .copyWith(borderRadius: BorderRadiusStyle.roundedBorder12),
        child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                  padding: getPadding(left: 13, top: 4),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                            width: getHorizontalSize(170),
                            margin: getMargin(bottom: 1),
                            child: Text("Dar Es Salaam\nSinza",
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: CustomTextStyles.headlineSmallBold)),
                        CustomImageView(
                            svgPath: ImageConstant.imgClouddrizzle,
                            height: getSize(24),
                            width: getSize(24),
                            margin: getMargin(left: 37, top: 36, bottom: 1)),
                        Container(
                            height: getSize(30),
                            width: getSize(30),
                            margin: getMargin(left: 7, top: 32),
                            child: Stack(
                                alignment: Alignment.bottomLeft,
                                children: [
                                  Align(
                                      alignment: Alignment.topCenter,
                                      child: Text("27°C",
                                          style: CustomTextStyles
                                              .titleSmallBluegray600)),
                                  Align(
                                      alignment: Alignment.bottomLeft,
                                      child: Text("Rain",
                                          style: theme.textTheme.bodySmall))
                                ])),
                        CustomImageView(
                            svgPath: ImageConstant.imgMorevertical,
                            height: getSize(24),
                            width: getSize(24),
                            margin: getMargin(left: 21, bottom: 38),
                            onTap: () {
                              onTapImgMorevertical(context);
                            })
                      ])),
              Padding(
                  padding: getPadding(top: 16),
                  child: Divider(
                      color: theme.colorScheme.onPrimary.withOpacity(1),
                      indent: getHorizontalSize(13),
                      endIndent: getHorizontalSize(12))),
              Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                      padding: getPadding(left: 13, right: 39),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                                padding: getPadding(bottom: 1),
                                child: Text("Sinza",
                                    style:
                                        CustomTextStyles.titleMediumOnPrimary)),
                            Text("1st Aug",
                                style: CustomTextStyles.titleMediumOnPrimary),
                            Padding(
                                padding: getPadding(bottom: 1),
                                child: Text("05",
                                    style:
                                        CustomTextStyles.titleMediumOnPrimary)),
                            Padding(
                                padding: getPadding(bottom: 1),
                                child: Text("03",
                                    style:
                                        CustomTextStyles.titleMediumOnPrimary))
                          ])))
            ]));
  }

//
  onTapImgMorevertical(BuildContext context) {
    // Navigator.pushNamed(context, AppRoutes.hoverOneScreen);
  }
}
