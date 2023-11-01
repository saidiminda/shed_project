import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/formatters/currency_input_formatter.dart';
import 'package:flutter_multi_formatter/formatters/money_input_enums.dart';
import 'package:hotel_booking/classes/language_constants.dart';
import 'package:hotel_booking/utils/app_export.dart';
import 'package:hotel_booking/widgets/app_bar/appbar_subtitle.dart';
import 'package:hotel_booking/widgets/custom_outlined_button.dart';
import 'package:hotel_booking/widgets/custom_text_form_field.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

// ignore_for_file: must_be_immutable
class AddPropertyRoomScreen extends StatelessWidget {
  AddPropertyRoomScreen({Key? key}) : super(key: key);

  final List<String> type = [
    'Child Room',
    'Older Room',
    'Full A/C Room',
  ];

  TextEditingController checkOutdateController = TextEditingController();

  TextEditingController selectTypeRoomController = TextEditingController();

  TextEditingController roomNameController = TextEditingController();

  TextEditingController checkoutTimeController = TextEditingController();

  TextEditingController priceController = TextEditingController();

  TextEditingController totalController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String? selectedValue;

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
              // translation(context).booking_list
              text: translation(context).add_room_property,
            ),
          )),
      body: SingleChildScrollView(
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
                              labelText: translation(context).name1,
                              controller: checkOutdateController,
                              hintText: translation(context).name1,
                              hintStyle: theme.textTheme.bodyLarge!,
                              validator: (addProperty) {
                                if (addProperty == null ||
                                    addProperty.isEmpty) {
                                  return "Please enter a Name";
                                }
                                return null;
                              })),

                      // Room Type
                      SizedBox(
                          child: Padding(
                              padding: getPadding(left: 8, top: 10, right: 6),
                              child: DropdownButtonFormField2<String>(
                                  isExpanded: true,
                                  decoration: InputDecoration(
                                    labelText: translation(context).type,
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
                                    translation(context).type,
                                    style: const TextStyle(fontSize: 12),
                                  ),
                                  items: type
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
                                      return translation(context).type;
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
                                    searchController: selectTypeRoomController,
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
                                        controller: selectTypeRoomController,
                                        decoration: InputDecoration(
                                          isDense: true,
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                            horizontal: 10,
                                            vertical: 8,
                                          ),
                                          hintText: translation(context).type,
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
                                      selectTypeRoomController.clear();
                                    }
                                  }))),

                      Padding(
                          padding: getPadding(left: 8, top: 10, right: 6),
                          child: CustomTextFormField(
                              // translation(context).room_name
                              labelText: translation(context).price_night,
                              controller: priceController,
                              hintText: translation(context).price_night,
                              hintStyle: theme.textTheme.bodyLarge!,
                              textInputType:
                                  const TextInputType.numberWithOptions(
                                decimal: true,
                                // signed: true,
                              ),
                              inputFormatters: [
                                CurrencyInputFormatter(
                                  thousandSeparator: ThousandSeparator.Comma,
                                  mantissaLength: 2,
                                  trailingSymbol: "\Tshs",
                                )
                              ],
                              validator: (addProperty) {
                                if (addProperty == null ||
                                    addProperty.isEmpty) {
                                  return "Please enter a Price Per Night";
                                }
                                return null;
                              })),
                      Padding(
                        padding: getPadding(left: 8, top: 10, right: 6),
                        child: CustomTextFormField(
                            // translation(context).checkout_time
                            controller: checkoutTimeController,
                            labelText: translation(context).toilet_service,
                            hintText: translation(context).toilet_service,
                            hintStyle: theme.textTheme.bodyLarge!,
                            textInputAction: TextInputAction.next,
                            validator: (addProperty) {
                              if (addProperty == null || addProperty.isEmpty) {
                                return "Please enter a Toilet Service";
                              }
                              return null;
                            }),
                      ),

                      // Price

                      CustomOutlinedButton(
                          decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(
                                  getHorizontalSize(5.00)),
                              color: const Color.fromARGB(255, 233, 146, 6)),
                          text: translation(context).save,
                          margin: getMargin(
                              left: 46, top: 30, right: 46, bottom: 5),
                          onTap: () {
                            if (_formKey.currentState!.validate()) {
                              onTapSave(context);
                            }
                          },
                          alignment: Alignment.center)
                    ]))),
      ),
    ));
  }

  onTapSave(BuildContext context) {
    // Navigator.pushNamed(context, AppRoutes.bookListScreen);
  }
}
