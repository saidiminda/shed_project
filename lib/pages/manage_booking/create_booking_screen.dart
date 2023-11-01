import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hotel_booking/classes/language_constants.dart';
import 'package:hotel_booking/service/manage_booking/manageBookingController.dart';
import 'package:hotel_booking/utils/app_export.dart';
import 'package:hotel_booking/widgets/app_bar/appbar_subtitle.dart';
import 'package:hotel_booking/widgets/custom_outlined_button.dart';
import 'package:hotel_booking/widgets/custom_text_form_field.dart';
import 'package:outline_gradient_button/outline_gradient_button.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../widgets/app_bar/appbar_iconbutton_2.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
// kusave api
// https://app.ema.co.tz/api/booking/save
// ignore_for_file: must_be_immutable
class CreateBookingScreen extends StatelessWidget {
  CreateBookingScreen({Key? key}) : super(key: key);

  final List<String> saleType = [
    'On Cash',
    'Mobile',
    'Bank',
  ];
  String? selectedValue;
// the give area of the following are
  TextEditingController checkOutdateController = TextEditingController();

  TextEditingController checkIndateController = TextEditingController();

  TextEditingController clientnameController = TextEditingController();

  TextEditingController propertyController = TextEditingController();

  TextEditingController agentController = TextEditingController();

  TextEditingController saleTypeController = TextEditingController();

  TextEditingController currencyTypeController = TextEditingController();

  TextEditingController exchangeRateController = TextEditingController();

  TextEditingController branchController = TextEditingController();

  RegiserBookingService registerBooking = RegiserBookingService();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
 late SharedPreferences logindata;
  final List<String> clientName = [
    'Item1',
    'Item2',
    'Item3',
    'Item4',
    'Item5',
    'Item6',
    'Item7',
    'Item8',
  ];
 Future<void> _createBooking(BuildContext context) async {
    // ignore: unused_local_variable
    logindata = await SharedPreferences.getInstance();
    var userdata = jsonDecode(logindata.getString('userData') ?? "");
    int userId = int.parse(userdata["id"].toString());
    Map<String, dynamic> newccount = {
      "id": userId,
      "hotel_id":userId,
      "user_agent": checkOutdateController.text,
      "start_date": checkIndateController.text,
      // "email": clientnameController.text,
      // "address": propertyController.text,
      // "identity_no": agentController.text,
      "sales_type": saleTypeController.text,
      // "occupation": currencyTypeController.text,
      "bank_id": branchController.text,
      "exchange_rate":exchangeRateController.text
    };
    final otpResult = await registerBooking.registerBooking(newccount);
    otpResult.when(
      (registerClientResponse) => {
        // ignore: avoid_print
        print(
            " =========> createBookingResponse: ${registerClientResponse.id} <==========="),
      },
      (exception) => {
        // ignore: avoid_print
        print(
            "===========> createBookingResponse--exception: $exception <=============="),
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Error! $exception"),
        ))
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme:const IconThemeData(
        color: Color.fromARGB(255, 8, 8, 8)
        ),
        title: Center(
          child: AppbarSubtitle(
            text: 'Create  Booking',
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
            key: _formKey,
            child: Container(
                width: double.maxFinite,
                padding: getPadding(left: 26, right: 26),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    // mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                          padding: getPadding(left: 8, top: 10, right: 6),
                          child: CustomTextFormField(
                              labelText: "Check In Date",
                              controller: checkIndateController,
                              hintText: "Check In Date *",
                              hintStyle: theme.textTheme.bodyLarge!,
                              onTap: () async {
                                FocusScope.of(context)
                                    .requestFocus(FocusNode());
                                DateTime date = DateTime(1900);
                                date = (await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(DateTime.now().year - 5),
                                  lastDate: DateTime(DateTime.now().year + 5),
                                ))!;

                                checkIndateController.text =
                                    date.toIso8601String();
                              },
                              validator: (booking) {
                                if (booking == null || booking.isEmpty) {
                                  return "Please enter a Check In Date";
                                }
                                return null;
                              })),

                      Padding(
                          padding: getPadding(left: 8, top: 10, right: 6),
                          child: CustomTextFormField(
                              labelText: translation(context).checkout,
                              controller: checkOutdateController,
                              hintText: translation(context).checkout,
                              hintStyle: theme.textTheme.bodyLarge!,
                              onTap: () async {
                                FocusScope.of(context)
                                    .requestFocus(FocusNode());
                                DateTime date = DateTime(1900);
                                date = (await showDatePicker(
                                  initialDatePickerMode: DatePickerMode.day,
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(DateTime.now().year - 5),
                                  lastDate: DateTime(DateTime.now().year + 5),
                                ))!;

                                checkOutdateController.text =
                                    date.toIso8601String();
                              },
                              validator: (booking) {
                                if (booking == null || booking.isEmpty) {
                                  return "Please enter a Check Out Date";
                                }
                              })),

                      // client name
                      Padding(
                          padding: getPadding(left: 8, top: 10, right: 6),
                          child: CustomTextFormField(
                              autofocus: false,
                              labelText: "Client Name",
                              controller: clientnameController,
                              hintText: "Client Name *",
                              hintStyle: theme.textTheme.bodyLarge!,
                              validator: (booking) {
                                if (booking == null || booking.isEmpty) {
                                  return "Please enter a Client Name";
                                }
                              })),

                      // propertyController
                      Padding(
                          padding: getPadding(left: 8, top: 10, right: 6),
                          child: CustomTextFormField(
                              labelText: "Property",
                              controller: propertyController,
                              hintText: "Select Property *",
                              hintStyle: theme.textTheme.bodyLarge!,
                              validator: (booking) {
                                if (booking == null || booking.isEmpty) {
                                  return "Please enter a  Property";
                                }
                                return null;
                              })),

                      Padding(
                        padding: getPadding(left: 8, top: 10, right: 6),
                        child: CustomTextFormField(
                            controller: branchController,
                            labelText: 'Branch',
                            hintText: "Select Branch",
                            hintStyle: theme.textTheme.bodyLarge!,
                            textInputAction: TextInputAction.next,
                            validator: (booking) {
                              if (booking == null || booking.isEmpty) {
                                return "Please enter a Branch";
                              }
                              return null;
                            }),
                      ),
                      // select agent

                      Padding(
                        padding: getPadding(left: 8, top: 10, right: 6),
                        child: CustomTextFormField(
                            controller: agentController,
                            labelText: 'Agent',
                            hintText: "Select Agent*",
                            hintStyle: theme.textTheme.bodyLarge!,
                            textInputAction: TextInputAction.next,
                            validator: (booking) {
                              if (booking == null || booking.isEmpty) {
                                return "Please enter a Agent";
                              }
                              return null;
                            }),
                      ),

                      //  sale type
                      SizedBox(
                          child: Padding(
                              padding: getPadding(left: 8, top: 10, right: 6),
                              child: DropdownButtonFormField2<String>(
                                  isExpanded: true,
                                  decoration: InputDecoration(
                                    labelText:
                                        translation(context).identity_type,
                                    hintStyle: theme.textTheme.bodyLarge!,
                                    contentPadding: getPadding(
                                      all: 18,
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(
                                          getHorizontalSize(10.00)),
                                      borderSide: BorderSide(
                                        color: appTheme.tealA700,
                                        width: 0.5,
                                      ),
                                    ),
                                  ),
                                  hint: Text(
                                    translation(context).identity_type,
                                    style:const TextStyle(fontSize: 12),
                                  ),
                                  items: saleType
                                      .map((item) => DropdownMenuItem<String>(
                                            value: item,
                                            child: Text(
                                              item,
                                              style: const TextStyle(
                                                fontSize: 12,
                                              ),
                                            ),
                                          ))
                                      .toList(),
                                  validator: (value) {
                                    if (value == null) {
                                      return translation(context).identity_type;
                                    }
                                    return null;
                                  },
                                  onChanged: (value) {
                                    //Do something when selected item is changed.

                                    selectedValue = value;
                                  },
                                  onSaved: (value) {
                                    selectedValue = value.toString();
                                  },
                                  dropdownStyleData: const DropdownStyleData(
                                    maxHeight: 200,
                                  ),
                                  iconStyleData: const IconStyleData(
                                    icon: Icon(
                                      Icons.arrow_drop_down,
                                    ),
                                    iconSize: 24,
                                  ),
                                  dropdownSearchData: DropdownSearchData(
                                    searchController: saleTypeController,
                                    searchInnerWidgetHeight: 50,
                                    searchInnerWidget: Container(
                                      height: 50,
                                      padding: const EdgeInsets.only(
                                        top: 8,
                                        bottom: 4,
                                        right: 8,
                                        left: 8,
                                      ),
                                      child: TextFormField(
                                        expands: true,
                                        maxLines: null,
                                        controller: saleTypeController,
                                        decoration: InputDecoration(
                                          isDense: true,
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                            horizontal: 10,
                                            vertical: 8,
                                          ),
                                          hintText: 'Select Sale Type*',
                                          hintStyle:
                                              const TextStyle(fontSize: 12),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                        ),
                                      ),
                                    ),
                                    searchMatchFn: (item, searchValue) {
                                      return item.value
                                          .toString()
                                          .contains(searchValue);
                                    },
                                  ),
                                  //This to clear the search value when you close the menu
                                  onMenuStateChange: (isOpen) {
                                    if (!isOpen) {
                                      saleTypeController.clear();
                                    }
                                  }))),

                    
                      Padding(
                        padding: getPadding(left: 8, top: 10, right: 6),
                        child: CustomTextFormField(
                            controller: currencyTypeController,
                            labelText: 'Currency ',
                            hintText: "Select Currency*",
                            hintStyle: theme.textTheme.bodyLarge!,
                            textInputAction: TextInputAction.next,
                            validator: (booking) {
                              if (booking == null || booking.isEmpty) {
                                return "Please enter a Currency";
                              }
                            }),
                      ),

                      // exchange rate

                      Padding(
                        padding: getPadding(left: 8, top: 10, right: 6),
                        child: CustomTextFormField(
                            controller: exchangeRateController,
                            labelText: 'Exchange Rate ',
                            hintText: "Exchange Rate *",
                            hintStyle: theme.textTheme.bodyLarge!,
                            textInputAction: TextInputAction.done,
                            validator: (booking) {
                              if (booking == null || booking.isEmpty) {
                                return "Please enter a Exchange Rate";
                              }
                              return null;
                            }),
                      ),

                      CustomOutlinedButton(
                        decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            borderRadius:
                                BorderRadius.circular(getHorizontalSize(5.00)),
                            color: const Color(0xffC2892D)),
                        text: "Continue",
                        margin:
                            getMargin(left: 46, top: 30, right: 46, bottom: 5),
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                             _createBooking(context);
                            onTapSave(context);
                          }
                        },
                      )

                    ]
                    )
                    )),
      ),
    ));
  }
// the save button of the given area of the following area of the given area 
// the given area of the following area of the angle above in the following area 
// the create the following area in a given area of the angle in the angle
// the give area is
  onTapSave(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.addRooms);
  }
}
