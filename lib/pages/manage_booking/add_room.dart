import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/formatters/currency_input_formatter.dart';
import 'package:flutter_multi_formatter/formatters/money_input_enums.dart';
import 'package:hotel_booking/classes/language_constants.dart';
import 'package:hotel_booking/service/manage_rooms/roomServ.dart';
import 'package:hotel_booking/utils/app_export.dart';
import 'package:hotel_booking/widgets/app_bar/appbar_subtitle.dart';
import 'package:hotel_booking/widgets/custom_outlined_button.dart';
import 'package:hotel_booking/widgets/custom_text_form_field.dart';
import 'package:outline_gradient_button/outline_gradient_button.dart';
// the area of the angle above
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../service/manage_rooms/roomServices.dart';

// ignore_for_file: must_be_immutable
class AddBookingScreen extends StatefulWidget {
  const AddBookingScreen({Key? key}) : super(key: key);

  @override
  State<AddBookingScreen> createState() => _AddBookingScreenState();
}

class _AddBookingScreenState extends State<AddBookingScreen> {
  TextEditingController checkOutdateController = TextEditingController();

  RegiserPropertyService addRoom = RegiserPropertyService();

  TextEditingController selectTypeRoomController = TextEditingController();

  TextEditingController roomNameController = TextEditingController();

  TextEditingController servicesController = TextEditingController();
  TextEditingController checkoutTimeController = TextEditingController();

  TextEditingController priceController = TextEditingController();

  TextEditingController toiletController = TextEditingController();

  TextEditingController descriptionController = TextEditingController();
  TextEditingController totalController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final List<String> roomtype = [
    'Item1',
    'Item2',
    'Item3',
    'Item4',
    'Item5',
    'Item6',
    'Item7',
    'Item8',
  ];

  String? selectedValue;

  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  late SharedPreferences logindata;
  void _onRefresh() async {
    // monitor network fetch
    await Future.delayed(const Duration(milliseconds: 1000));
    _refreshController.refreshCompleted();
  }
  

  void _onLoading() async {
    // monitor network fetch
    await Future.delayed(const Duration(milliseconds: 1000));

    _refreshController.loadComplete();
  }

  Future<void> _createRoom(BuildContext context) async {
    // ignore: unused_local_variable
     var userdata = jsonDecode(logindata.getString('userData') ?? "");
   int userId = int.parse(userdata['id'].toString());
    Map<String, dynamic> newccount = {
      "hotel_id": 2,
      "name": roomNameController.text,
      "service": servicesController.text,
      "price": priceController.text,
      "toilet": toiletController.text,
      "room_type": selectTypeRoomController.text,
      "description": descriptionController.text,
    };
    final otpResult = await clientServices.createClient(newccount, clientData: {});
    // final otpResult = await clientServices.createClient(newccount, clientData: {});
    otpResult.when(
      (registerResponse) => {
        // ignore: avoid_print
        print(
            " ========================> registerClientResponse: ${registerResponse.hotel_id} <===================="),
      },
      (exception) => {
        // ignore: avoid_print
        print(
            " ========================> registerClientResponse--exception: $exception <===================="),
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Hitilafu! $exception"),
        )),
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
        iconTheme: const IconThemeData(color: Color.fromARGB(255, 8, 8, 8)),
        title: Center(
          child: AppbarSubtitle(
            text: translation(context).add_room,
          ),
        ),
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
            child: Form(
                key: _formKey,
                child: Container(
                    width: double.maxFinite,
                    padding: getPadding(left: 26, right: 26),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                              padding: getPadding(left: 8, top: 10, right: 6),
                              child: CustomTextFormField(
                                  labelText: translation(context).room_name,
                                  controller: roomNameController,
                                  hintText: translation(context).room_name,
                                  hintStyle: theme.textTheme.bodyLarge!,
                                  validator: (booking) {
                                    if (booking == null || booking.isEmpty) {
                                      return translation(context).please_enter +
                                          translation(context).room_name;
                                    }
                                    return null;
                                  })),
                          Padding(
                              padding: getPadding(left: 8, top: 10, right: 6),
                              child: CustomTextFormField(
                                  // translation(context).room_name
                                  labelText: 'Services',
                                  controller: roomNameController,
                                  hintText: 'Services',
                                  hintStyle: theme.textTheme.bodyLarge!,
                                  validator: (booking) {
                                    if (booking == null || booking.isEmpty) {
                                      return translation(context).please_enter +
                                          'Services';
                                    }
                                    return null;
                                  })),

                          // SizedBox(
                          //     child: Padding(
                          //         padding:
                          //             getPadding(left: 8, top: 10, right: 6),
                          //         child: DropdownButtonFormField2<String>(
                          //             isExpanded: true,
                          //             decoration: InputDecoration(
                          //               labelText:
                          //                   translation(context).room_type,
                          //               hintStyle: theme.textTheme.bodyLarge!,
                          //               contentPadding: getPadding(
                          //                 all: 18,
                          //               ),
                          //               border: OutlineInputBorder(
                          //                 borderRadius: BorderRadius.circular(
                          //                     getHorizontalSize(10.00)),
                          //                 borderSide: BorderSide(
                          //                   color: appTheme.tealA700,
                          //                   width: 0.5,
                          //                 ),
                          //               ),
                          //             ),
                          //             hint: Text(
                          //               translation(context).room_type,
                          //               style: const TextStyle(fontSize: 12),
                          //             ),
                          //             // the area of the following area of the table
                          //             items: roomtype
                          //                 .map((item) =>
                          //                     DropdownMenuItem<String>(
                          //                       value: item,
                          //                       child: Text(
                          //                         item,
                          //                         style: const TextStyle(
                          //                           fontSize: 12,
                          //                         ),
                          //                       ),
                          //                     ))
                          //                 .toList(),
                          //             validator: (value) {
                          //               if (value == null) {
                          //                 return translation(context).room_type;
                          //               }
                          //               return null;
                          //             },
                          //             onChanged: (value) {
                          //               //Do something when selected item is changed.

                          //               selectedValue = value;
                          //             },
                          //             onSaved: (value) {
                          //               selectedValue = value.toString();
                          //             },
                          //             dropdownStyleData:
                          //                 const DropdownStyleData(
                          //               maxHeight: 200,
                          //             ),
                          //             iconStyleData: const IconStyleData(
                          //               icon: Icon(
                          //                 Icons.arrow_drop_down,
                          //               ),
                          //               iconSize: 24,
                          //             ),
                          //             dropdownSearchData: DropdownSearchData(
                          //               searchController:
                          //                   selectTypeRoomController,
                          //               searchInnerWidgetHeight: 50,
                          //               searchInnerWidget: Container(
                          //                 height: 50,
                          //                 padding: const EdgeInsets.only(
                          //                   top: 8,
                          //                   bottom: 4,
                          //                   right: 8,
                          //                   left: 8,
                          //                 ),
                          //                 // the following area of the area of the angle
                          //                 child: TextFormField(
                          //                   expands: true,
                          //                   maxLines: null,
                          //                   controller:
                          //                       selectTypeRoomController,
                          //                   decoration: InputDecoration(
                          //                     isDense: true,
                          //                     contentPadding:
                          //                         const EdgeInsets.symmetric(
                          //                       horizontal: 10,
                          //                       vertical: 8,
                          //                     ),
                          //                     hintText: translation(context)
                          //                         .room_type,
                          //                     hintStyle:
                          //                         const TextStyle(fontSize: 12),
                          //                     border: OutlineInputBorder(
                          //                       borderRadius:
                          //                           BorderRadius.circular(8),
                          //                     ),
                          //                   ),
                          //                 ),
                          //               ),
                          //               searchMatchFn: (item, searchValue) {
                          //                 return item.value
                          //                     .toString()
                          //                     .contains(searchValue);
                          //               },
                          //             ),
                          //             //This to clear the search value when you close the menu
                          //             onMenuStateChange: (isOpen) {
                          //               if (!isOpen) {
                          //                 selectTypeRoomController.clear();
                          //               }
                          //             }
                          //             )
                          //             )
                          //             ),
                           Padding(
                              padding: getPadding(left: 8, top: 10, right: 6),
                              child: CustomTextFormField(
                                  labelText: 'Type of Room',
                                  controller: selectTypeRoomController,
                                  hintText: 'Type Of Room',
                                  hintStyle: theme.textTheme.bodyLarge!,
                                  validator: (booking) {
                                    if (booking == null || booking.isEmpty) {
                                      return translation(context).please_enter +
                                          'Room Type ';
                                    }
                                    return null;
                                  })),
                          Padding(
                              padding: getPadding(left: 8, top: 10, right: 6),
                              child: CustomTextFormField(
                                  labelText: 'Toilet',
                                  controller: toiletController,
                                  hintText: 'toilet',
                                  hintStyle: theme.textTheme.bodyLarge!,
                                  validator: (booking) {
                                    if (booking == null || booking.isEmpty) {
                                      return translation(context).please_enter +
                                          translation(context).room_name;
                                    }
                                    return null;
                                  })),
//
                          Padding(
                              padding: getPadding(left: 8, top: 10, right: 6),
                              child: CustomTextFormField(
                                  labelText: 'description',
                                  controller: descriptionController,
                                  hintText: translation(context).room_name,
                                  hintStyle: theme.textTheme.bodyLarge!,
                                  validator: (booking) {
                                    if (booking == null || booking.isEmpty) {
                                      return translation(context).please_enter +
                                          translation(context).room_name;
                                    }
                                    return null;
                                  })),

                          //

                          // Padding(
                          //   padding: getPadding(left: 8, top: 10, right: 6),
                          //   child: CustomTextFormField(
                          //       controller: checkoutTimeController,
                          //       labelText: translation(context).checkout_time,
                          //       hintText: translation(context).checkout_time,
                          //       hintStyle: theme.textTheme.bodyLarge!,
                          //       textInputAction: TextInputAction.next,
                          //       onTap: () async {
                          //         FocusScope.of(context)
                          //             .requestFocus(FocusNode());
                          //         var time = await showTimePicker(
                          //           context: context,
                          //           initialTime: TimeOfDay.now(),
                          //         );
                          //         // ignore: use_build_context_synchronously
                          //         checkoutTimeController.text =
                          //             // ignore: use_build_context_synchronously
                          //             time!.format(context);
                          //       },
                          //       validator: (booking) {
                          //         if (booking == null || booking.isEmpty) {
                          //           return translation(context).please_enter +
                          //               translation(context).checkout_time;
                          //         }
                          //         return null;
                          //       }),
                          // ),

                          // Price

                          Padding(
                            padding: getPadding(left: 8, top: 10, right: 6),
                            child: CustomTextFormField(
                                controller: priceController,
                                labelText: translation(context).price,
                                hintText: translation(context).price,
                                hintStyle: theme.textTheme.bodyLarge!,
                                textInputAction: TextInputAction.next,
                                textInputType:
                                    const TextInputType.numberWithOptions(
                                  decimal: true,
                                ),
                                // inputFormatters: [
                                //   CurrencyInputFormatter(
                                //     thousandSeparator: ThousandSeparator.Comma,
                                //     mantissaLength: 2,
                                //     trailingSymbol: "\Tsh",
                                //   )
                                // ],
                                validator: (booking) {
                                  // the given area of the table
                                  if (booking == null || booking.isEmpty) {
                                    return translation(context).please_enter +
                                        translation(context).price;
                                  }
                                  return null;
                                }),
                          ),

                          // Padding(
                          //   padding: getPadding(left: 8, top: 10, right: 6),
                          //   child: CustomTextFormField(
                          //     readOnly: true,
                          //     controller: totalController,
                          //     labelText: translation(context).total,
                          //     hintStyle: theme.textTheme.bodyLarge!,
                          //     textInputType: const TextInputType.numberWithOptions(
                          //       decimal: true,
                          //       // signed: true,
                          //     ),
                          //     inputFormatters: [
                          //       CurrencyInputFormatter(
                          //         thousandSeparator: ThousandSeparator.Comma,
                          //         mantissaLength: 2,
                          //         trailingSymbol: "\Tsh",
                          //       )
                          //     ],
                          //   ),
                          // ),

                          CustomOutlinedButton(
                              decoration: BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.circular(
                                      getHorizontalSize(5.00)),
                                  color: const Color(0xffC2892D)),
                              text: translation(context).save,
                              margin: getMargin(
                                  left: 46, top: 30, right: 46, bottom: 5),
                              onTap: () {
                                if (_formKey.currentState!.validate()) {
                                  _createRoom(context);

                                  // Navigator.pop(context);
                                }
                              },
                              alignment: Alignment.center)
                        ]))),
          )),
    ));
  }

  onTapSave(BuildContext context) {
    // Navigator.pushNamed(context, AppRoutes.bookListScreen);
  }
}
