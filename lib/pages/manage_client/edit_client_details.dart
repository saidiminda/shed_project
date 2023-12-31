import 'dart:convert';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/formatters/phone_input_formatter.dart';
import 'package:hotel_booking/classes/language_constants.dart';
import 'package:hotel_booking/service/manage_client/manageClientController.dart';
import 'package:hotel_booking/utils/app_export.dart';
import 'package:hotel_booking/widgets/app_bar/appbar_subtitle.dart';
import 'package:hotel_booking/widgets/custom_outlined_button.dart';
import 'package:hotel_booking/widgets/custom_text_form_field.dart';
import 'dart:async';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore_for_file: must_be_immutable
class EditClientScreen extends StatefulWidget {
  const EditClientScreen({Key? key}) : super(key: key);

  @override
  State<EditClientScreen> createState() => _EditClientScreenState();
}

class _EditClientScreenState extends State<EditClientScreen> {
  DateTime selectedDate = DateTime.now();
  PhoneCountryData? _initialCountryData;
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  late SharedPreferences logindata;
  late String username;
  @override
  void initState() {
    super.initState();
    initial();
  }

  void initial() async {
    logindata = await SharedPreferences.getInstance();
    setState(() {
      var userdata = jsonDecode(logindata.getString('userData') ?? "");
      int username = int.parse(userdata['id'].toString());
    });
  }

  final List<String> idtype = [
    'National Id',
    'Driver Lessen ',
    'Vote Id',
  ];
  String? selectedValue;

  RegiserClientService registerClient = RegiserClientService();

  TextEditingController nameController = TextEditingController();

  TextEditingController phoneController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController addressController = TextEditingController();

  TextEditingController identitynumberController = TextEditingController();

  TextEditingController placeofbirthController = TextEditingController();

  TextEditingController occupationvalueController = TextEditingController();

  TextEditingController idTypevalueController = TextEditingController();

  TextEditingController dateOfBirthController = TextEditingController();

  TextEditingController tribevalueoneController = TextEditingController();

  TextEditingController nationality = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Future<void> _createClient(BuildContext context) async {
    // ignore: unused_local_variable
    logindata = await SharedPreferences.getInstance();
    var userdata = jsonDecode(logindata.getString('userData') ?? "");
    int userId = int.parse(userdata["id"].toString());
    Map<String, dynamic> newccount = {
      "id": userId,
      "name": nameController.text,
      "phone": phoneController.text,
      "email": emailController.text,
      "address": addressController.text,
      "identity_no": identitynumberController.text,
      "place_of_birth": placeofbirthController.text,
      "occupation": occupationvalueController.text,
      "identity_type": idTypevalueController.text,
      "dob": dateOfBirthController.text,
      "tribe": tribevalueoneController.text,
      "nationality": nationality.text,
    };
    final otpResult = await registerClient.registerClient(newccount);
    otpResult.when(
      (registerClientResponse) => {
        // ignore: avoid_print
        print(
            "=========> registerClientResponse: ${registerClientResponse.id} <=========="),
      },
      (exception) => {
        // ignore: avoid_print
        print(
            " ========================> registerClientResponse--exception: $exception <===================="),
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Error! $exception"),
        ))
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return  SizedBox(
        child: Column(
        children: [
          Padding(
              padding: getPadding(left: 8, top: 2, right: 6),
              child: CustomTextFormField(
                labelText: translation(context).name,
                controller: nameController,
                hintText: translation(context).name,
                hintStyle: theme.textTheme.bodyLarge!,
             
              )),
          Padding(
              padding: getPadding(left: 8, top: 10, right: 6),
              child: CustomTextFormField(
                  labelText: translation(context).phone,
                  controller: phoneController,
                  hintText: translation(context).phone,
                  hintStyle: theme.textTheme.bodyLarge!,
                  textInputType: TextInputType.number,
                  inputFormatters: [
                    PhoneInputFormatter(
                      allowEndlessPhone: false,
                      defaultCountryCode: _initialCountryData?.countryCode,
                    )
                  ],
               )),
          Padding(
              padding: getPadding(left: 8, top: 10, right: 6),
              child: CustomTextFormField(
                  labelText: translation(context).email,
                  controller: emailController,
                  hintText: translation(context).email,
                  hintStyle: theme.textTheme.bodyLarge!,
                  textInputType: TextInputType.emailAddress,
                 )),
          Padding(
              padding: getPadding(left: 8, top: 10, right: 6),
              child: CustomTextFormField(
                  labelText: translation(context).address,
                  controller: addressController,
                  hintText: translation(context).address,
                  hintStyle: theme.textTheme.bodyLarge!,
                 )),
          Padding(
              padding: getPadding(
                left: 8,
                top: 10,
                right: 6,
              ),
              child: CustomTextFormField(
                  controller: nationality,
                  labelText: translation(context).nationality,
                  hintText: translation(context).nationality,
                  hintStyle: theme.textTheme.bodyLarge!,
                )),
          SizedBox(
              child: Padding(
                  padding: getPadding(left: 8, top: 10, right: 6),
                  child: DropdownButtonFormField2<String>(
                      isExpanded: true,
                      decoration: InputDecoration(
                        labelText: translation(context).identity_type,
                        hintStyle: theme.textTheme.bodyLarge!,
                        contentPadding: getPadding(
                          all: 18,
                        ),
                        border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(getHorizontalSize(10.00)),
                          borderSide: BorderSide(
                            color: appTheme.tealA700,
                            width: 0.5,
                          ),
                        ),
                      ),
                      hint: Text(
                        translation(context).identity_type,
                        style: const TextStyle(fontSize: 12),
                      ),
                      items: idtype
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
                        searchController: idTypevalueController,
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
                            controller: idTypevalueController,
                            decoration: InputDecoration(
                              isDense: true,
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 8,
                              ),
                              hintText: translation(context).identity_type,
                              hintStyle: const TextStyle(fontSize: 12),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                        ),
                        searchMatchFn: (item, searchValue) {
                          return item.value.toString().contains(searchValue);
                        },
                      ),
                     
                      onMenuStateChange: (isOpen) {
                        if (!isOpen) {
                          idTypevalueController.clear();
                        }
                      }))),
          Padding(
              padding: getPadding(left: 8, top: 10, right: 6),
              child: CustomTextFormField(
                  labelText: translation(context).identity_number,
                  controller: identitynumberController,
                  hintText: translation(context).identity_number,
                  hintStyle: theme.textTheme.bodyLarge!,
                  textInputType: TextInputType.number,
                 )),
          Padding(
              padding: getPadding(
                left: 8,
                top: 10,
                right: 6,
              ),
              child: CustomTextFormField(
                  controller: placeofbirthController,
                  labelText: translation(context).place_birth,
                  hintText: translation(context).place_birth,
                  hintStyle: theme.textTheme.bodyLarge!,
                )),
          Padding(
              padding: getPadding(left: 8, top: 10, right: 6),
              child: CustomTextFormField(
                  controller: occupationvalueController,
                  labelText: translation(context).occupation,
                  hintText: translation(context).occupation,
                  hintStyle: theme.textTheme.bodyLarge!,
                 )),
          Padding(
              padding: getPadding(left: 8, top: 10, right: 6),
              child: CustomTextFormField(
                  readOnly: true,
                  labelText: translation(context).date_of_birth,
                  controller: dateOfBirthController,
                  hintText: translation(context).date_of_birth,
                  hintStyle: theme.textTheme.bodyLarge!,
                  onTap: () async {
                    FocusScope.of(context).requestFocus(FocusNode());
                    DateTime date = DateTime(1900);
                    date = (await showDatePicker(
                      initialDatePickerMode: DatePickerMode.day,
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(DateTime.now().year - 5),
                      lastDate: DateTime(DateTime.now().year + 5),
                    ))!;

                    dateOfBirthController.text = date.toIso8601String();
                  },
                )),
          Padding(
              padding: getPadding(left: 8, top: 10, right: 6),
              child: CustomTextFormField(
                  controller: tribevalueoneController,
                  labelText: translation(context).tribe,
                  hintText: translation(context).tribe,
                  hintStyle: theme.textTheme.bodyLarge!,
                  textInputAction: TextInputAction.done,)),

          CustomOutlinedButton(
              decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(getHorizontalSize(5.00)),
                  color: const Color(0xffC2892D)),
              width: getHorizontalSize(185),
              // translation(context).save
              text: 'Update',
              margin: getMargin(left: 40, top: 38, bottom: 50, right: 40),
              onTap: () {
                  _createClient(context);
                 
                  Navigator.pop(context);
                // if (_formKey.currentState!.validate()) {
                
                // }
              })
        ]),
   
    );
  }
}
