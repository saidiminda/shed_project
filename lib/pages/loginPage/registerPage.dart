import 'dart:convert';
import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hotel_booking/classes/language_constants.dart';
import 'package:hotel_booking/constants.dart';
import 'package:hotel_booking/models/user_type.dart';
import 'package:hotel_booking/service/helper_services.dart';
import 'package:hotel_booking/service/roomTypes/typesServices.dart';
import 'package:hotel_booking/widgets/app_bar/appbar_subtitle.dart';
import 'package:hotel_booking/widgets/app_bar/text_field_shimmer.dart';
import 'package:hotel_booking/widgets/dropdown_widget.dart';
import 'package:hotel_booking/widgets/header_widget.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import '../../routes/app_routes.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:readmore/readmore.dart';

// ignore: use_key_in_widget_constructors
class RegistrationScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _RegistrationScreenState();
  }
}

class _RegistrationScreenState extends State<RegistrationScreen> {
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
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Container(
              // margin: EdgeInsets.all(8),
              alignment: Alignment.center,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 150, child: HeaderWidget(150)),
                  Center(
                    child: Text(
                      'Sign up',
                      style: GoogleFonts.abhayaLibre(
                        fontSize: 40,
                        color: const Color(0xffC2892D),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: size.width * .45,
                        child: TextFormField(
                          controller: fullname,
                          decoration: InputDecoration(
                              hintText: translation(context).fullname,
                              labelText: translation(context).fullname),
                          keyboardType: TextInputType.text,
                          onChanged: (String value) {
                            setState(() {});
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return translation(context).please_enter +
                                  translation(context).fullname;
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(
                        width: size.width * .45,
                        child: TextFormField(
                          controller: address,
                          decoration: InputDecoration(
                            hintText: translation(context).address1,
                          ),
                          keyboardType: TextInputType.streetAddress,
                          onChanged: (String value) {
                            setState(() {});
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return translation(context).please_enter +
                                  translation(context).address1;
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: size.width * .45,
                        child: TextFormField(
                          controller: reference_no,
                          decoration: InputDecoration(
                              hintText: translation(context).referenceNo,
                              labelText: translation(context).referenceNo),
                          keyboardType: TextInputType.phone,
                          onChanged: (String value) {
                            setState(() {});
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return translation(context).please_enter +
                                  translation(context).referenceNo;
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(
                        width: size.width * .45,
                        child: TextFormField(
                          controller: phone,
                          decoration: InputDecoration(
                            hintText: translation(context).phoneNo,
                            labelText: translation(context).phoneNo,
                          ),
                          keyboardType: TextInputType.phone,
                          onChanged: (String value) {
                            setState(() {
                              if (value.length != 13) {
                                phoneError = "invalid phone number length";
                              } else {
                                phoneError = null;
                              }
                            });
                          },
                          inputFormatters: [
                            PhoneInputFormatter(
                              allowEndlessPhone: false,
                              shouldCorrectNumber: true,
                              defaultCountryCode:
                                  _initialCountryData?.countryCode,
                            )
                          ],
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return translation(context).phoneNo;
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: size.width * .45,
                          child: TextFormField(
                            controller: email,
                            decoration: InputDecoration(
                                hintText: translation(context).email,
                                labelText: translation(context).email),
                            validator: MultiValidator([
                              RequiredValidator(errorText: "* Required"),
                              EmailValidator(errorText: "Enter valid email id"),
                            ]),
                            keyboardType: TextInputType.emailAddress,
                            //  PatternValidator
                          ),
                        ),
                        SizedBox(
                          width: size.width * .45,
                          child: TextFormField(
                            controller: register_as,
                            decoration: InputDecoration(
                                hintText: translation(context).registerAs,
                                labelText: translation(context).registerAs),
                            keyboardType: TextInputType.text,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return translation(context).registerAs;
                              }
                              return null;
                            },
                          ),
                        ),
                      ]),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: size.width * .45,
                        child: TextFormField(
                          controller: password,
                          decoration: InputDecoration(
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
                              hintText: translation(context).enter_password,
                              labelText: translation(context).enter_password),
                          validator: passwordValidator,
                          obscureText: obscureText,
                          onChanged: (String value) {
                            setState(() {
                              if (value != comfPassword.text) {
                                passwordError =  translation(context).passwordmatch;
                              } else {
                                passwordError = null;
                              }
                            });
                          },
                        ),
                      ),
                      SizedBox(
                        width: size.width * .45,
                        child: TextFormField(
                          controller: comfPassword,
                          decoration: InputDecoration(
                            hintText: translation(context).confimpassword,
                            labelText: translation(context).confimpassword,
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
                                passwordError = translation(context).passwordmatch;
                              } else {
                                passwordError = null;
                              }
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      Checkbox(
                        value: hasAgreed,
                        onChanged: (bool? value) {
                          setState(() {
                            hasAgreed = value!;
                          });
                        },
                      ),
                      Text(translation(context).agreeTerms,
                        style: GoogleFonts.dosis(),
                      )
                    ],
                  ),
                  // SizedBox(height: 10),
                  // SizedBox(
                  //   width: size.width * .45,
                  //   child: Column(
                  //     crossAxisAlignment: CrossAxisAlignment.start,
                  //     children: [
                  //       _buildDropDown(),
                  //       userTypeError == null
                  //           ? Container()
                  //           : Text(
                  //               userTypeError!,
                  //               style:
                  //                   TextStyle(color: const Color(0xffC2892D)),
                  //             ),
                  //     ],
                  //   ),
                  // ),
                  SizedBox(height: 10),
                  Wrap(
                    children: [
                      Text(translation(context).confimpolicy,
                        style: GoogleFonts.dosis(),
                      ),
                      InkWell(
                        child: Text(translation(context).privacy,
                          style: GoogleFonts.dosis(
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                            color: const Color(0xffC2892D),
                          ),
                        ),
                        onTap: () {
                          _terms_conditions(context);
                        },
                      )
                    ],
                  ),
                  SizedBox(height: 10),
                  Align(
                    alignment: Alignment.center,
                    child: isLoading
                        ? SizedBox(
                            height: 30,
                            width: 30,
                            child: CircularProgressIndicator(),
                          )
                        : ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              fixedSize: Size(150, 30),
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text(translation(context).register_here,
                                // signup1
                                style: GoogleFonts.dosis(),
                              ),
                            ),
                            onPressed: isVerifying || !hasAgreed
                                ? null
                                : () {
                                    if (_formKey.currentState!.validate()) {
                                      createUser(
                                          fullname.text,
                                          address.text,
                                          email.text,
                                          phone.text,
                                          register_as.text,
                                          password.text,
                                          reference_no.text);
                                    }
                                    @override
                                    void initState() {
                                      fullname.text = '';
                                      address.text = '';
                                      email.text = '';
                                      phone.text = '';
                                      register_as.text = '';
                                      password.text = '';
                                      reference_no.text = '';
                                    }

                                    ;
                                  },
                          ),
                  ),
                  SizedBox(height: 10),
                  Center(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // accountno
                        Text(translation(context).accountno,
                          style: GoogleFonts.dosis(),
                        ),
                        SizedBox(width: 10),
                        InkWell(
                          child: Text(translation(context).login,
                            style: GoogleFonts.dosis(
                              color: const Color(0xffC2892D),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          onTap: () =>
                              Navigator.pushNamed(context, AppRoutes.login),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  // the follo 
  Container _buildDropDown() {
    return Container(
      width: double.infinity,
      height: 40,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: userTypeError == null
                ? CupertinoColors.black.withOpacity(.3)
                : const Color(0xffC2892D),
          ),
        ),
      ),
      child: DropdownButtonHideUnderline(
        child: ButtonTheme(
          alignedDropdown: true,
          child: DropdownButton<UserType>(
            iconEnabledColor: Color(0xff3c9efc),
            isExpanded: false,
            hint: Text(
              userType,
              style: TextStyle(
                color: const Color(0xffC2892D),
                fontSize: 15,
              ),
            ),
            icon: Icon(Icons.arrow_drop_down, color: const Color(0xffC2892D)),
            iconSize: 23,
            style: TextStyle(color: Colors.black, fontSize: 15),
            onChanged: (type) {
              setState(() {
                userType = type!.slug!;
                registerAs = type.id;
                userTypeError = null;
              });
            },
            items: userTypes.map((UserType type) {
              return DropdownMenuItem<UserType>(
                value: type,
                child: Text(type.slug!),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }

  verifyEmail() async {
    setState(() {
      isVerifying = true;
    });
    // final results = await auth.verifyEmail(email: email.text);
    setState(() {});
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

  void _terms_conditions(context) {
    showModalBottomSheet(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(20)
              )
              ),
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Scaffold(
                appBar: AppBar(
                  elevation: 0,
                  backgroundColor: Colors.transparent,
                  iconTheme:
                      const IconThemeData(color: Color.fromARGB(255, 8, 8, 8)),
                  title: Center(
                    // translation(context).create_property
                    child: AppbarSubtitle(
                      text: 'Terms & Conditions',
                    ),
                  ),
                  actions: [
                    TextButton(
                        onPressed: () {
                           Navigator.pop(context);
                        },
                        child: const Icon(
                          Icons.close,
                        ))
                  ],
                ),
                body: SingleChildScrollView(
                  child: Column(mainAxisSize: MainAxisSize.min, children: const [
                    Padding(
                      key: Key('showMore'),
                      padding: EdgeInsets.all(16.0),
                      child: ReadMoreText(
                        """ By clicking “Get Started”, or by submitting your information on any  EMA electronic platform 
                        (portal, website, survey etc.), you agree to the terms and conditions of this Agreement and 
                        the  EMA Privacy Policy (“collectively referred to as “Terms”). Please note that this Agreement is 
                        subject to change without prior notice (unless prior notice is required by law). 
                        By completing this online questionnaire, you agree to be legally bound by these terms, 
                        which shall take effect immediately on your first use of this website. If you do not agree to be 
                        legally bound by all the terms, please do not access and/or use the website and/or complete the 
                        questionnaire.  EMA may change the terms at any time by posting changes online. Please review the 
                        terms regularly to ensure you are aware of any changes made by us.
                    You agree that  EMA may collect, process use and store [insert name of contracting entity’s] 
                    personal information (including special personal information) for purposes of:
                    (i) providing the services,
                    (ii) maintaining its internal administrative or client relationship management systems, 
                    including the use of third party IT outsourced providers,
                    (iii) quality and risk management reviews and legal reporting obligations,
                    (iv) providing information about its range of services,
                    (v) carrying out and managing its business operations,
                    (vi) providing professional advice, and
                    (vii) any legitimate business purposes or other activities conducted by  EMA from time to time.  
                    You undertake to keep the personal information up to date by keeping  EMA informed of any changes 
                    that need to be made to the personal information.
                    You warrant that the consent of any other data subject to whose personal information shall be
                     disclosed to  EMA by you in terms of this agreement has been obtained or that you are otherwise 
                     justified in law to disclose such information to  EMA . You further warrant and undertake to immediately 
                     inform  EMA :
                    (i) of any changes to the personal information provided by you in order to keep the data accurate,
                    (ii) should any data subject withdraw any consent previously given and/or
                    (iii) should  EMA for any other reason no longer be entitled to lawfully process the data subject’s 
                    personal information. You agree to hold  EMA and/or any and all of its directors, officers or any other
                     officials thereof respectively, harmless and indemnified against any and all loss, damage, costs 
                     (including legal costs on an attorney and client basis), charges, penalties, fines, interest, 
                     expenses which may be incurred or sustained by  EMA and/or any one or more of the aforesaid persons 
                     as a result of you breaching the aforementioned warranties or failing to comply with any of your 
                     obligations in terms of POPI or any other applicable data protection law or regulation.
                    You understand and agree that the personal information may in appropriate circumstances reside and be 
                    processed outside South Africa and you agree that a  EMA firm or entity acting on its behalf shall be 
                    entitled to transfer and process personal information across country borders to such locations outside 
                    South Africa and for the purposes set out above.
                    You agree that  EMA shall be entitled to retain the personal information for a minimum period of 5 years, 
                    after which, subject to what is set out below, the personal information shall be destroyed in accordance 
                    with the provisions of POPI, or any other applicable data protection law or regulation. You agree that  EMA shall however be entitled to extend the period for which personal information is retained:(i) If this is required or authorised by law,(ii)  EMA reasonably requires the information for a longer period for lawful purposes related to its activities or functions,(iii) this is required by any contract between the parties, or(iv) for statistical or research purposes (subject to appropriate safeguards).
                     EMA is not liable for any damages (including direct, indirect, consequential, incidental, and exemplary) in the event that this site is unavailable to users (by virtue of interruption, suspension, or termination) for any reason, including due to computer or communications link downtime attributable to malfunction, upgrades or preventative or remedial maintenance activities.
                     EMA will not be liable to users in respect of any loss or damage (including consequential loss or inconsequential loss) which may be suffered or incurred, or which may arise directly or indirectly because of services supplied by  EMA .
                    These terms and conditions are subject to warranties and liabilities that cannot by law be disclaimed and 
                     EMA ’s liability for any breach of a condition in relation to supply by it of services to users is 
                     limited to, at  EMA ’s option, supply of the services again, or the payment of the cost of supplying the 
                     services again.  EMA will not be liable for any loss caused by the failure to complete the questionnaire.
                    These terms and conditions are subject to change at the sole discretion of  EMA .
                    Users warrant that all information provided by them on the questionnaire is accurate and does not breach 
                    any law or the rights of any person.
                    You may not sell or modify the material or reproduce, display, distribute, or otherwise use the material 
                    available on this website in any way for any public or commercial purpose. You may not copy or adapt the 
                    code or software that  EMA creates to generate its pages.
                    You may not ‘frame’ or ‘mirror’ any materials or third-party content contained on or accessible from the 
                     EMA site on any other server or internet-based device without the express written authorization of  EMA .
                     EMA will not be liable for any damages (including direct, indirect, consequential, incidental, and 
                     exemplary), if there is any deficiency or inaccuracy in the site attributable to a lack of maintenance of 
                     the site or in relation to the accuracy, sufficiency or otherwise of your application.
                    All users warrant that they have not relied on any representation made by  EMA which has not 
                    been expressly stated in these terms and conditions or the engagement letter for the provision of 
                    specified services by  EMA . On lodging material, users indemnify  EMA and its officers, employees and 
                    agents against any claim, demand, injury, direct or indirect damage, loss or cost, liability, right of 
                    action or claim for compensation in contract, under statute or in tort (including negligence) made against
                     or suffered by any of those indemnified arising, in whole or in part, as a result of your application, 
                     or any activity that is expressed in these terms and conditions to be the responsibility of the user, 
                     or breach of these terms and conditions.
                     EMA does not monitor your data or transmissions, yet it does actively monitor accounts for system 
                     utilisation. Upon any breach of this agreement, or inappropriate use of  EMA services as determined by  
                     EMA in its sole discretion,  EMA reserves the right to terminate your registration.  EMA ’s preferred 
                     course of action is to advise you of your inappropriate use or breach of this agreement and recommend any 
                     necessary corrective action.
                    To enter the Prize Draw, respondents need to complete the full survey.
                    The prize draw (the “Apple iPad”) is open to anyone within the manufacturing and distribution industries. 
                    Employees or their family members may not enter the Prize Draw.
                     EMA accepts no responsibility for entries that are lost, delayed, misdirected or incomplete or cannot be 
                     delivered or entered for any technical or other reason.
                    One winner will be chosen from a random draw of entries received in accordance with these 
                    Terms and Conditions. The draw will be performed by a random computer process.
                   """,
                        trimLines: 20,
                        preDataText: "TERMS & CONDITIONS",
                        preDataTextStyle:
                            TextStyle(fontWeight: FontWeight.w500),
                        style: TextStyle(color: Colors.black),
                        colorClickableText: Colors.pink,
                        trimMode: TrimMode.Line,
                        trimCollapsedText: '...Show more',
                        trimExpandedText: ' show less',
                      ),
                    ),
                  ]),
                )),
          );
        });
  }
}
