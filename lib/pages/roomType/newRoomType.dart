import 'package:flutter/material.dart';
import 'package:hotel_booking/classes/language_constants.dart';
import 'package:hotel_booking/utils/app_export.dart';
// ignore: unused_import
import 'package:hotel_booking/widgets/app_bar/appbar_image.dart';
import 'package:hotel_booking/widgets/app_bar/appbar_subtitle.dart';
import 'package:hotel_booking/widgets/app_bar/custom_app_bar.dart';
import 'package:hotel_booking/widgets/custom_outlined_button.dart';
import 'package:hotel_booking/widgets/custom_text_form_field.dart';

import 'package:outline_gradient_button/outline_gradient_button.dart';

// ignore: must_be_immutable
class RoomTypeScreen extends StatelessWidget {
  RoomTypeScreen({Key? key}) : super(key: key);

  TextEditingController nameController = TextEditingController();

  TextEditingController checkOutdateController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final bool _show = false;
// the  given area below
  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme:const IconThemeData(color: Color.fromARGB(255, 8, 8, 8)),
        title: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Center(
            child: AppbarSubtitle(
              // Client List
              text: translation(context).booking_list,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
          child: Form(
              key: _formKey,
              child: Container(
                  width: double.maxFinite,
                  padding: getPadding(left: 20, top: 5, right: 20, bottom: 5),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: getPadding(top: 1),
                        ),
                        Padding(
                            padding: getPadding(left: 8, top: 10, right: 6),
                            child: CustomTextFormField(
                              labelText: "Name",
                              controller: nameController,
                              hintText: "Name *",
                              hintStyle: theme.textTheme.bodyLarge!,
                            )),
                        CustomOutlinedButton(
                            decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.circular(
                                    getHorizontalSize(5.00)),
                                color:const Color.fromARGB(255, 218, 60, 12)),
                            width: getHorizontalSize(165),
                            // translation(context).save
                            text: 'Save',
                            margin: getMargin(
                                left: 50, top: 38, right: 50, bottom: 66),
                            onTap: () {
                              // onTapSave(context);
                            }),
                      ])))),
    ));
  }

  onTapPlusone(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.addRooms);
  }
}
