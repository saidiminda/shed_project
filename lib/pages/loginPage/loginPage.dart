// ignore_for_file: use_build_context_synchronously, deprecated_member_use
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hotel_booking/classes/language_constants.dart';
import 'package:hotel_booking/constants.dart';
import 'package:hotel_booking/main.dart';
import 'package:hotel_booking/routes/app_routes.dart';
import 'package:hotel_booking/theme/background.dart';
import 'package:http/http.dart' as http;
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../classes/language.dart';
// import 'package:provider/provider.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  var connectivityResult = (Connectivity().checkConnectivity());
  final _formKey = GlobalKey<FormState>();
  late SharedPreferences localStorage;
  late SharedPreferences logindata;
  late bool newuser;

  @override
  void initState() {
    super.initState();
    check_if_already_login();
  }

  // ignore: non_constant_identifier_names
  void check_if_already_login() async {
    logindata = await SharedPreferences.getInstance();
    newuser = (logindata.getBool('login') ?? true);
    print(newuser);
    if (newuser == false) {
      Navigator.pushNamed(context, AppRoutes.dashboard);
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  late String email, password;
  bool isLoading = false;
  bool _passwordVisible = true;
  final String _emailPattern =
      r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?";

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  late ScaffoldMessengerState scaffoldMessenger;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    scaffoldMessenger = ScaffoldMessenger.of(context);
    return Scaffold(
        key: _scaffoldKey,
        body: SingleChildScrollView(
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Stack(
              children: <Widget>[
                Background(
                  size: size,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Center(
                          child: Container(
                        height: 200,
                        width: 200,
                        child: Column(
                          children: const [
                            Text(
                              'EMASUITE',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 24),
                            ),
                            Text(
                              'enterprise management \nand automation',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 12),
                            ),
                           
                            // Image.asset(
                            //   "assets/images/logo.png",
                            //   height: 200,
                            //   width: 200,
                            //   alignment: Alignment.center,
                            // ),
                          ],
                        ),
                      )),
                      Text(
                        translation(context).login,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.roboto(
                          textStyle: const TextStyle(
                            color: Colors.black,
                            letterSpacing: 1,
                            fontSize: 23,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            translation(context).homePage,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.roboto(
                              textStyle: const TextStyle(
                                color: Colors.black,
                                letterSpacing: 1,
                                fontSize: 17,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Form(
                        key: _formKey,
                        child: Container(
                          margin: const EdgeInsets.symmetric( 
                              vertical: 10, horizontal: 45),
                          child: Column(
                            children: <Widget>[
                              TextFormField(
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                                controller: _emailController,
                                decoration: InputDecoration(
                                  enabledBorder: const UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white)),
                                  hintText: translation(context).enter_email,
                                  labelText: translation(context).enter_email,
                                  hintStyle: const TextStyle(
                                      color: Colors.white70, fontSize: 15),
                                ),
                                validator: MultiValidator([
                                  RequiredValidator(errorText: "* Required"),
                                  EmailValidator(
                                      errorText: "Enter valid email id"),
                                ]),
                                onChanged: (val) {
                                  setState(() {
                                    if (RegExp(_emailPattern).hasMatch(val)) {
                                      email = val;
                                    }
                                  });
                                },
                                onSaved: (val) {
                                  email = val!;
                                },
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              TextFormField(
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                                controller: _passwordController,
                                obscureText: _passwordVisible,
                                decoration: InputDecoration(
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      _passwordVisible
                                          ? Icons.visibility_off
                                          : Icons.visibility,
                                      color: Colors.black,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _passwordVisible = !_passwordVisible;
                                      });
                                    },
                                  ),
                                  enabledBorder: const UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white)),
                                  hintText: translation(context).enter_password,
                                  labelText:
                                      translation(context).enter_password,
                                  hintStyle: const TextStyle(
                                      color: Colors.white70, fontSize: 15),
                                ),
                                onSaved: (val) {
                                  email = val!;
                                },
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              Stack(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      // savePref();
                                      if (isLoading) {
                                        return;
                                      }
                                      if (_emailController.text.isEmpty ||
                                          _passwordController.text.isEmpty) {
                                        scaffoldMessenger.showSnackBar(
                                            const SnackBar(
                                                content: Text(
                                                    "Please Fill all fileds")));
                                        return;
                                      }
                                      login(_emailController.text,
                                          _passwordController.text);
                                      setState(() {
                                        isLoading = true;
                                      });
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      width: double.infinity,
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10, horizontal: 0),
                                      height: 50,
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Colors.white),
                                        borderRadius: BorderRadius.circular(50),
                                      ),
                                      child: Text(
                                        translation(context).login,
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.roboto(
                                            textStyle: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 16,
                                                letterSpacing: 1)),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    right: 30,
                                    bottom: 0,
                                    top: 0,
                                    child: (isLoading)
                                        ? const Center(
                                            child: SizedBox(
                                                height: 26,
                                                width: 26,
                                                child:
                                                    CircularProgressIndicator(
                                                  backgroundColor: Colors.white,
                                                )))
                                        : Container(),
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              DropdownButton<Language>(
                                hint: Text(translation(context).changeLanguage),
                                underline: const SizedBox(),
                                icon: const Icon(
                                  Icons.language,
                                  color: Color.fromARGB(255, 8, 8, 8),
                                ),
                                onChanged: (Language? language) async {
                                  if (language != null) {
                                    Locale _locale =
                                        await setLocale(language.languageCode);
                                    MyApp.setLocale(context, _locale);
                                  }
                                },
                                items: Language.languageList()
                                    .map<DropdownMenuItem<Language>>(
                                      (e) => DropdownMenuItem<Language>(
                                        value: e,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: <Widget>[Text(e.name)],
                                        ),
                                      ),
                                    )
                                    .toList(),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Text(
                                    translation(context).accountno,
                                    style: GoogleFonts.dosis(),
                                  ),
                                  const SizedBox(width: 10),
                                  InkWell(
                                    child: Text(
                                      translation(context).register_here,
                                      style: GoogleFonts.dosis(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    onTap: () => Navigator.pushNamed(
                                        context, AppRoutes.register),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  login(email, password) async {
    var getId;
    Map data = {'email': email, 'password': password};

    final response = await http.post(Uri.parse('$domainUrl/pms_login'),
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

      // ignore: unrelated_type_equality_checks
        if (!resposne['error']) {
          logindata.setBool('login', false);
          logindata.setString('username', email);
          logindata.setString('userData', jsonEncode(resposne['user']));
          print(resposne['user']);

          Navigator.pushNamed(context, AppRoutes.dashboard);
        }
     else {
        scaffoldMessenger.showSnackBar(
            SnackBar(content: const Text("No internet  connection ")));
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
