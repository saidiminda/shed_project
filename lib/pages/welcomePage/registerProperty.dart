import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:hotel_booking/classes/language_constants.dart';
import 'package:hotel_booking/models/storage_item.dart';
import 'package:hotel_booking/service/registerProperty/registerPropertyService.dart';
import 'package:hotel_booking/service/storage_service.dart';
import 'package:hotel_booking/utils/app_export.dart';
import 'package:hotel_booking/widgets/app_bar/appbar_subtitle.dart';
import 'package:hotel_booking/widgets/custom_outlined_button.dart';
import 'package:hotel_booking/widgets/custom_text_form_field.dart';
// the drop down menu in the following table
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore_for_file: must_be_immutable
class RegisterProperty extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  RegisterProperty({Key? key}) : super(key: key);

  @override
  State<RegisterProperty> createState() => _RegisterPropertyState();
}

class _RegisterPropertyState extends State<RegisterProperty> {
  String? username, phone,name;
  @override
  void initState() {
    super.initState();
    initial();
  }

  void initial() async {
    logindata = await SharedPreferences.getInstance();
    setState(() {
      var userdata = jsonDecode(logindata.getString('hotelData') ?? "");
      username = userdata["email"] ?? "";
      phone = userdata["phone"] ?? "";
      name=userdata["name"]?? "";
    });
  }

  RegiserPropertyService register = RegiserPropertyService();

  late SharedPreferences logindata;

  TextEditingController propertyNameController = TextEditingController();

  TextEditingController selectTypePropertyController = TextEditingController();

  TextEditingController propertyAdressController = TextEditingController();

  TextEditingController propertyGoogleController = TextEditingController();

  TextEditingController propertyPhone1Controller = TextEditingController();

  TextEditingController propertyPhone2Controller = TextEditingController();

  TextEditingController propertyEmailController = TextEditingController();

  TextEditingController propertyOfficalController = TextEditingController();

  TextEditingController propertyDescriptionController = TextEditingController();

  TextEditingController propertyOfferController = TextEditingController();

  TextEditingController searchController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Future<void> _createAccount(BuildContext context) async {
    logindata = await SharedPreferences.getInstance();
    var userdata = jsonDecode(logindata.getString('userId') ?? "");
    int userId = int.parse(userdata["id"].toString());
    // ignore: unused_local_variable
    Map<String, dynamic> newccount = {
      "id": userId,
      "name": propertyNameController.text,
      "type": selectTypePropertyController.text,
      "address": propertyAdressController.text,
      "google_location": propertyGoogleController.text,
      "phone1": propertyPhone1Controller.text,
      "phone2": propertyPhone2Controller.text,
      "email": propertyEmailController.text,
      "website_link": propertyOfficalController.text,
      "notes": propertyDescriptionController.text,
      "offers": propertyOfferController.text,
    };
    final otpResult = await register.registerProperty(newccount);
    otpResult.when(
      (loginResponse) => {
        print(
            " ========================> loginResponse: ${loginResponse.id} <===================="),
        print(userId),
        onTapGetStart(context),

        StorageService().writeSecureData(
            StorageItem('userId', loginResponse.id!.toString())),
        // _loading = false,
      },
      (exception) => {
        print(
            " ========================> loginResponse--exception: $exception <===================="),
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Hitilafu! $exception"),
        ))
      },
    );
  }

//   @override
//   void dispose() {
//     // Dispose of the controllers when the widget is disposed
//     propertyNameController.dispose();
//     selectTypePropertyController.dispose();
//     propertyAdressController.dispose();
//     propertyGoogleController.dispose();
//     propertyPhone1Controller.dispose();
//     propertyPhone2Controller.dispose();
//     propertyEmailController.dispose();
//     propertyOfficalController.dispose();
//     propertyDescriptionController.dispose();
//     propertyOfferController.dispose();
//     searchController.dispose();
// super.dispose();
//   }

  final List<String> clientName = [
    'National Id',
    'Driver Lessen ',
    'Vote Id',
  ];

  String? selectedValue;

  @override
  // void dispose() {
  //   searchController.dispose();
  // }

  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

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

  PhoneCountryData? _initialCountryData;

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
              text: translation(context).create_property,
            ),
          )),
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
                              //translation(context).checkout
                              labelText: translation(context).property_name,
                              controller: propertyNameController,
                              hintText: translation(context).property_name,
                              hintStyle: theme.textTheme.bodyLarge!,
                              validator: (propertyName) {
                                if (propertyName == null ||
                                    propertyName.isEmpty) {
                                  return translation(context).please_enter +
                                      translation(context).property_name;
                                }
                                return null;
                              },
                            )),

                        // Room Type
                        Padding(
                            padding: getPadding(left: 8, top: 10, right: 6),
                            child: CustomTextFormField(
                              // translation(context).room_type
                              labelText: translation(context).property_type,
                              controller: selectTypePropertyController,
                              hintText: translation(context).property_type,
                              hintStyle: theme.textTheme.bodyLarge!,
                              validator: (propertyType) {
                                if (propertyType == null ||
                                    propertyType.isEmpty) {
                                  return translation(context).please_enter +
                                      translation(context).property_type;
                                }
                                return null;
                              },
                            )),
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
                                      style: TextStyle(fontSize: 12),
                                    ),
                                    items: clientName
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
                                        return translation(context)
                                                .please_enter +
                                            translation(context).identity_type;
                                      }
                                      return null;
                                    },
                                    onChanged: (value) {
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
                                      searchController: searchController,
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
                                          controller: searchController,
                                          decoration: InputDecoration(
                                            isDense: true,
                                            contentPadding:
                                                const EdgeInsets.symmetric(
                                              horizontal: 10,
                                              vertical: 8,
                                            ),
                                            hintText: 'Search Id type',
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
                                    onMenuStateChange: (isOpen) {
                                      if (!isOpen) {
                                        searchController.clear();
                                      }
                                    }))),
                        Padding(
                            padding: getPadding(left: 8, top: 10, right: 6),
                            child: CustomTextFormField(
                              textInputType: TextInputType.streetAddress,
                              labelText: translation(context).property_address,
                              controller: propertyAdressController,
                              hintText: translation(context).property_address,
                              hintStyle: theme.textTheme.bodyLarge!,
                              validator: (propertyAddress) {
                                if (propertyAddress == null ||
                                    propertyAddress.isEmpty) {
                                  return translation(context).please_enter +
                                      translation(context).property_address;
                                }
                                return null;
                              },
                            )
                            ),

                        Padding(
                          padding: getPadding(left: 8, top: 10, right: 6),
                          child: CustomTextFormField(
                            // translation(context).checkout_time
                            controller: propertyGoogleController,
                            labelText: translation(context).property_google,
                            hintText: translation(context).property_google,
                            hintStyle: theme.textTheme.bodyLarge!,
                            textInputAction: TextInputAction.next,
                            validator: (propertyGoogle) {
                              if (propertyGoogle == null ||
                                  propertyGoogle.isEmpty) {
                                return translation(context).please_enter +
                                    translation(context).property_google;
                              }
                              return null;
                            },
                          ),
                        ),

                        Padding(
                          padding: getPadding(left: 8, top: 10, right: 6),
                          child: CustomTextFormField(
                            textInputType: TextInputType.number,
                            hintText: translation(context).property_phone1,
                            controller: propertyPhone1Controller,
                            labelText: translation(context).property_phone1,
                            hintStyle: theme.textTheme.bodyLarge!,
                            inputFormatters: [
                              PhoneInputFormatter(
                                allowEndlessPhone: false,
                                defaultCountryCode:
                                    _initialCountryData?.countryCode,
                              )
                            ],
                            validator: (propertyPhone1) {
                              if (propertyPhone1 == null ||
                                  propertyPhone1.isEmpty) {
                                return translation(context).please_enter +
                                    translation(context).property_phone1;
                              }
                              return null;
                            },
                          ),
                        ),

                        Padding(
                          padding: getPadding(left: 8, top: 10, right: 6),
                          child: CustomTextFormField(
                            textInputType: TextInputType.number,
                            controller: propertyPhone2Controller,
                            labelText: translation(context).property_phone2,
                            hintText: translation(context).property_phone2,
                            hintStyle: theme.textTheme.bodyLarge!,
                            textInputAction: TextInputAction.next,
                            inputFormatters: [
                              PhoneInputFormatter(
                                allowEndlessPhone: false,
                                defaultCountryCode:
                                    _initialCountryData?.countryCode,
                              )
                            ],
                            validator: (propertyPhone2) {
                              if (propertyPhone2 == null ||
                                  propertyPhone2.isEmpty) {
                                return translation(context).please_enter +
                                    translation(context).property_phone2;
                              }
                              return null;
                            },
                          ),
                        ),

                        Padding(
                          padding: getPadding(left: 8, top: 10, right: 6),
                          child: CustomTextFormField(
                            textInputType: TextInputType.emailAddress,
                            controller: propertyEmailController,
                            labelText: translation(context).property_email,
                            hintText: translation(context).property_email,
                            hintStyle: theme.textTheme.bodyLarge!,
                            textInputAction: TextInputAction.next,
                            validator: (propertyEmail) {
                              if (propertyEmail == null ||
                                  propertyEmail.isEmpty) {
                                return translation(context).please_enter +
                                    translation(context).property_email;
                              }
                              return null;
                            },
                          ),
                        ),

                        Padding(
                          padding: getPadding(left: 8, top: 10, right: 6),
                          child: CustomTextFormField(
                            controller: propertyOfficalController,
                            labelText:
                                translation(context).property_official_web,
                            hintText:
                                translation(context).property_official_web,
                            hintStyle: theme.textTheme.bodyLarge!,
                            textInputAction: TextInputAction.next,
                            validator: (propertyOfficial) {
                              if (propertyOfficial == null ||
                                  propertyOfficial.isEmpty) {
                                return translation(context).please_enter +
                                    translation(context).property_official_web;
                              }
                              return null;
                            },
                          ),
                        ),

                        Padding(
                          padding: getPadding(left: 8, top: 10, right: 6),
                          child: CustomTextFormField(
                            textInputType: TextInputType.text,
                            controller: propertyDescriptionController,
                            labelText:
                                translation(context).property_description,
                            hintText: translation(context).property_description,
                            hintStyle: theme.textTheme.bodyLarge!,
                            textInputAction: TextInputAction.next,
                            validator: (property) {
                              if (property == null || property.isEmpty) {
                                return translation(context).please_enter +
                                    translation(context).property_description;
                              }
                              return null;
                            },
                          ),
                        ),

                        Padding(
                          padding: getPadding(left: 8, top: 10, right: 6),
                          child: CustomTextFormField(
                            controller: propertyOfferController,
                            labelText:
                                translation(context).property_offer_service,
                            hintText:
                                translation(context).property_offer_service,
                            hintStyle: theme.textTheme.bodyLarge!,
                            textInputAction: TextInputAction.next,
                            validator: (property) {
                              if (property == null || property.isEmpty) {
                                return translation(context).please_enter +
                                    translation(context).property_offer_service;
                              }
                              return null;
                            },
                          ),
                        ),
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
                                _createAccount(context);
                                onTapGetStart(context);
                              }
                            },
                            alignment: Alignment.center)
                      ]
                      )
                      )
                      ),
        ),
      ),
    )
    );
  }

  onTapSave(BuildContext context) {
    // Navigator.pushNamed(context, AppRoutes.bookListScreen);
  }
}

onTapGetStart(BuildContext context) {
  Navigator.pushNamed(context, AppRoutes.dashboard);
}
