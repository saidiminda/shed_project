import 'dart:convert';
import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hotel_booking/classes/language_constants.dart';
import 'package:hotel_booking/constants.dart';
import 'package:hotel_booking/models/user_type.dart';
import 'package:hotel_booking/service/auth_service/auth_service.dart';
import 'package:hotel_booking/service/helper_services.dart';
import 'package:hotel_booking/service/roomTypes/typesServices.dart';
import 'package:hotel_booking/widgets/app_bar/appbar_subtitle.dart';
import 'package:hotel_booking/widgets/app_bar/text_field_shimmer.dart';
import 'package:hotel_booking/widgets/dropdown_widget.dart';
import 'package:hotel_booking/widgets/header_widget.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import '../../models/user.dart';
import '../../routes/app_routes.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:readmore/readmore.dart';

// ignore: use_key_in_widget_constructors
class ChangePassword extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ChangePasswordState();
  }
}

class _ChangePasswordState extends State<ChangePassword> {
  HouseTypeController houseController = HouseTypeController();
  List<dynamic> houseList = [];
  List<String> houseNameList = [];
  int? userId;
  String? houseCurrentSelected;
  TextEditingController fullname = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController comfPassword = TextEditingController();
  TextEditingController reference_no = TextEditingController();
  TextEditingController register_as = TextEditingController();
  late ScaffoldMessengerState scaffoldMessenger;
  late Future<void> loadAllHouseFuture;
  int? registerAs;
  List<UserType> userTypes = [];
  String userType = "Loading...";
  String? password1;
  String? passwordError, phoneError, userTypeError;
  bool isLoading = false,
      hasAgreed = false,
      isVerifying = false,
      obscureText = true;

  Future<void> _loadAllhouse() async {
    final businessResult = await houseController.getAllHouses();
    businessResult.when(
      (house) => {
        houseList.addAll(house),
        for (var houses in house) {houseNameList.add(houses.houseName!)},
        print(
            " ========================> +++++++++++ $houseNameList <===================="),
      },
      (exception) => {
        print(
            " ========================> bank--exception: $exception <===================="),
      },
    );
  }

  @override
  void initState() {
    super.initState();
    getUserTypes();
    loadAllHouseFuture = _loadAllhouse();
  }

  getUserTypes() async {
    final _userTypes = await helper.getUserTypes();

    if (mounted) {
      setState(() {
        userTypes = _userTypes;
        userType = "Register as";
      });
    }
  }

  final passwordValidator = MultiValidator([
    RequiredValidator(errorText: 'password is required'),
    MinLengthValidator(6, errorText: 'password must be at least 6 digits'),
    PatternValidator(r'(?=.*?[#?!@$%^&*-])',
        errorText: 'passwords must have at least one special character')
  ]);
  final _formKey = GlobalKey<FormState>();
  PhoneCountryData? _initialCountryData;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return  Container(
          // margin: EdgeInsets.all(8),
          alignment: Alignment.center,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 30),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const TextField(
                          decoration: InputDecoration(
                              suffixIcon: Icon(
                                Icons.check,
                                color: Colors.grey,
                              ),
                              label: Text(
                                'Old Password',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xffB81736),
                                ),
                              )),
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                         
                            label: Text(
                              translation(context).enter_password,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xffB81736),
                              ),
                            ),
                            errorText: passwordError,
                            suffix: InkWell(
                              child: Icon(
                                obscureText
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                              ),
                              onTap: () {
                                setState(() {
                                  if (obscureText) {
                                    obscureText = false;
                                  } else {
                                    obscureText = true;
                                  }
                                });
                              },
                            ),
                          ),
                          validator: passwordValidator,
                          obscureText: obscureText,
                          onChanged: (String value) {
                            setState(() {
                              if (value != comfPassword.text) {
                                passwordError =
                                    translation(context).passwordmatch;
                              } else {
                                passwordError = null;
                              }
                            });
                          },
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            // suffixIcon: Icon(
                            //   Icons.visibility_off,
                            //   color: Colors.grey,
                            // ),
                            label: Text(
                              translation(context).confimpassword,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xffB81736),
                              ),
                            ),
                            errorText: passwordError,
                            suffix: InkWell(
                              child: Icon(
                                obscureText
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                              ),
                              onTap: () {
                                setState(() {
                                  if (obscureText) {
                                    obscureText = false;
                                  } else {
                                    obscureText = true;
                                  }
                                });
                              },
                            ),
                          ),
                          obscureText: obscureText,
                          validator: passwordValidator,
                          onChanged: (String value) {
                            setState(() {
                              if (value != password.text) {
                                passwordError =
                                    translation(context).passwordmatch;
                              } else {
                                passwordError = null;
                              }
                            });
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          height: 40,
                          width: 200,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            gradient: const LinearGradient(colors: [
                              Color(0xffB81736),
                              Color(0xff281537),
                            ]),
                          ),
                          child: const Center(
                            child: Text(
                              'Reset Password',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ]),
                ),
              ),
            ],
          ),
    
    );
  }

// create user
  createUser(fullname, address, email, phone, registerAs, password,
      referenceNo) async {
    Map data = {
      "name": fullname,
      "address": address,
      "email": email,
      "phone": phone,
      "register_as": registerAs,
      "password": password,
      "reference_no": referenceNo,
    };

    final response = await http.post(Uri.parse('$domainUrl/pms/register'),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/x-www-form-urlencoded"
        },
        body: data,
        encoding: Encoding.getByName("utf-8"));
    setState(() {
      isLoading = false;
    });
    if (response.statusCode == 200) {
      Map<String, dynamic> resposne = jsonDecode(response.body);
      if (!resposne['error']) {
        // ignore: use_build_context_synchronously
        Navigator.pushNamed(context, AppRoutes.welcomePage);
        print('imeenda');
      } else {
        print(" ${resposne['message']}");
      }
      scaffoldMessenger
          .showSnackBar(SnackBar(content: Text("${resposne['message']}")));
    } else {
      scaffoldMessenger
          .showSnackBar(const SnackBar(content: Text("Please try again!")));
    }
  }
}
