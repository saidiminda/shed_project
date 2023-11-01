// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_settings_ui/flutter_settings_ui.dart';
import 'package:hotel_booking/classes/language.dart';
import 'package:hotel_booking/classes/language_constants.dart';
import 'package:hotel_booking/main.dart';
import 'package:hotel_booking/utils/app_export.dart';
import 'package:hotel_booking/widgets/app_bar/appbar_subtitle.dart';
import 'package:hotel_booking/widgets/logout_prompt.dart';
import 'package:xen_popup_card/xen_card.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);
  @override
  // ignore: library_private_types_in_public_api
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  TextEditingController saleTypeController = TextEditingController();

  final List<String> saleType = [
    'Hotel 1',
    'Hotel 2',
    'Hotel 3',
  ];
  String? selectedValue;

  bool lockInBackground = true;

  bool notificationsEnabled = false;
  late SharedPreferences logindata;
  String? email, phone, name, nameHotel;
  @override
  void initState() {
    super.initState();
    initial();
  }

// the ar
  void initial() async {
    logindata = await SharedPreferences.getInstance();
    setState(() {
      var userdata = jsonDecode(logindata.getString('userData') ?? "");
      email = userdata["email"] ?? "";
      phone = userdata["phone"] ?? "";
      name = userdata["name"] ?? "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconTheme: IconThemeData(
          color: Color.fromARGB(255, 8, 8, 8)),
          title: Center(
            child: AppbarSubtitle(
              text: translation(context).settings,
            ),
          )
          ),
      body: buildSettingsList(),
    );
  }
  
  Widget buildSettingsList() {
    return SettingsList(
      sections: [
        SettingsSection(
          title: 'Switch Account',
          tiles: [
            SettingsTile(
              title: 'Switch Account',
              subtitle: 'Lodge 1',
              // subtitleBelowTitle: true,
              leading: const Icon(Icons.switch_account),
              onPressed: (context) {
                showDialog(
                  context: context,
                  builder: (builder) => XenPopupCard(
                    body: ListView(
                      children: [
                        // Padding(
                        //   padding: const EdgeInsets.all(20.0),
                        //   child: Center(child: SearchSwitch()),
                        // ),

                        SizedBox(
                            child: Padding(
                                padding: getPadding(left: 8, top: 10, right: 6),
                                child: DropdownButtonFormField2<String>(
                                    isExpanded: true,
                                    decoration: InputDecoration(
                                      labelText: 'Switch Account',
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
                                    hint: const Text(
                                      '',
                                      style: TextStyle(fontSize: 12),
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
                                        return translation(context)
                                            .identity_type;
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
                                        Icons.switch_access_shortcut,
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
                                            hintText: 'Switch Account',
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
                                        saleTypeController.clear();
                                      }
                                    }
                                    )
                                    )
                                    ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
        SettingsSection(
          title: 'Common',
          tiles: [
            SettingsTile(
              title: 'Language',
              subtitle: 'English',
              // subtitleBelowTitle: true,
              leading: const Icon(Icons.language),
              onPressed: (context) {
                showModalBottomSheet(
                    context: context,
                    shape: const RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(20))),
                    builder: (context) {
                      return SizedBox(
                        height: 200,
                        child:
                            Column(mainAxisSize: MainAxisSize.min, children: [
                          DropdownButton<Language>(
                            borderRadius: BorderRadius.circular(6),
                            underline: const SizedBox(),
                            icon: const Icon(
                              Icons.language,
                              color: Color.fromARGB(255, 8, 8, 8),
                            ),
                            onChanged: (Language? language) async {
                              if (language != null) {
                                Locale _locale =
                                    await setLocale(language.languageCode);
                                // ignore: use_build_context_synchronously
                                MyApp.setLocale(context, _locale);
                              }
                            },
                            items: Language.languageList()
                                .map<DropdownMenuItem<Language>>(
                                  (e) => DropdownMenuItem<Language>(
                                      value: e, child: Text(e.name)),
                                )
                                .toList(),
                          ),
                        ]),
                      );
                    });
              },
            ),
          ],
        ),
        SettingsSection(
          title: 'Account',
          tiles: [
            SettingsTile(
                // phone number
                title: phone.toString(),
                leading: const Icon(Icons.phone),
                onPressed: (context) {
                  showModalBottomSheet(
                    shape: const RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.vertical(
                            top: Radius.circular(20))),
                    context: context,
                    builder: (context) {
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ListTile(
                            leading: const Icon(
                              Icons.call,
                              color: Colors.greenAccent,
                            ),
                            title: const Text('Call'),
                            onTap: () async {
                              // Launch the tel scheme with the phone number
                              // ignore: deprecated_member_use
                              await launch('tel:$phone');
                              // ignore: use_build_context_synchronously
                              Navigator.pop(context);
                            },
                          ),
                          ListTile(
                            leading: const Icon(
                              Icons.message,
                              color: Color.fromARGB(255, 25, 11, 219),
                            ),
                            title: const Text('Message'),
                            onTap: () async {
                              // ignore: deprecated_member_use
                              await launch('sms:$phone');
                              Navigator.pop(context);
                            },
                          ),
                          ListTile(
                            leading: const FaIcon(
                              FontAwesomeIcons.whatsapp,
                              color: Colors.greenAccent,
                            ),
                            title: const Text('WhatsApp'),
                            onTap: () async {
                              // Launch the WhatsApp URL with the phone number
                              // ignore: deprecated_member_use
                              await launch('https://wa.me/$phone');
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      );
                    },
                  );
                }),
            // the given area of the area of the angle of the
            SettingsTile(
                title: email.toString(), leading: const Icon(Icons.email)),
            SettingsTile(
              title: 'Sign out',
              leading: const Icon(Icons.exit_to_app),
              // ignore: deprecated_member_use
              onTap: () {
                onTapLogOut(context);
              },
            ),
          ],
        ),
        SettingsSection(
          title: 'Security',
          tiles: [
            SettingsTile(
              title: 'Change password',
              leading: const Icon(Icons.lock),
              // ignore: deprecated_member_use
              onTap: () {
                showModalBottomSheet(
                    shape: const RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.vertical(
                            top: Radius.circular(20)
                            )
                            ),
                    context: context,
                    builder: (context) {
                      return Container(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 30),
                        height: 300,
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
                                const TextField(
                                  decoration: InputDecoration(
                                      suffixIcon: Icon(
                                        Icons.visibility_off,
                                        color: Colors.grey,
                                      ),
                                      label: Text(
                                        'New Password',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xffB81736),
                                        ),
                                      )),
                                ),
                                const TextField(
                                  decoration: InputDecoration(
                                      suffixIcon: Icon(
                                        Icons.visibility_off,
                                        color: Colors.grey,
                                      ),
                                      label: Text(
                                        'Confirm New Password',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xffB81736),
                                        ),
                                      )),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Container(
                                  height: 40,
                                  width: 200,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    gradient: const LinearGradient(
                                      colors: [
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
                      );
                    }
                );
              },
            ),
          ],
        ),
      ],
    );
  }

  onTapLogOut(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.login);
    logOut();
  }
// logout button
  logOut() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.clear();
  }
}
