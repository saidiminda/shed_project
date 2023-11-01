import 'package:flutter/material.dart';
import 'package:hotel_booking/classes/language.dart';
import 'package:hotel_booking/classes/language_constants.dart';
import 'package:hotel_booking/main.dart';
import 'package:hotel_booking/widgets/app_bar/appbar_subtitle.dart';

class LanguagesScreen extends StatefulWidget {
  const LanguagesScreen({Key? key}) : super(key: key);
  @override
  // ignore: library_private_types_in_public_api
  _LanguagesScreenState createState() => _LanguagesScreenState();
}

class _LanguagesScreenState extends State<LanguagesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconTheme: const IconThemeData(color: Color.fromARGB(255, 8, 8, 8)),
          title: Center(
            child: AppbarSubtitle(
              // translation(context).booking_list
              // Client List
              text: 'Language',
            ),
          )),
      body: Center(
        heightFactor: 40,
        child: DropdownButton<Language>(
          borderRadius: BorderRadius.circular(6),
          underline: const SizedBox(),
          icon: const Icon(
            Icons.language,
            color: Color.fromARGB(255, 8, 8, 8),
          ),
          onChanged: (Language? language) async {
            if (language != null) {
              Locale locale = await setLocale(language.languageCode);
              // ignore: use_build_context_synchronously
              MyApp.setLocale(context, locale);
            }
          },
          items: Language.languageList()
              .map<DropdownMenuItem<Language>>(
                (e) =>
                    DropdownMenuItem<Language>(value: e, child: Text(e.name)),
              )
              .toList(),
        ),
      ),
    );
  }
}
