// ignore_for_file: use_build_context_synchronously, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:hotel_booking/routes/app_routes.dart';
import 'package:hotel_booking/widgets/restart_app_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LogoutPrompt extends StatefulWidget {
  LogoutPrompt({Key? key}) : super(key: key);

  @override
  State<LogoutPrompt> createState() => _LogoutPromptState();
}

class _LogoutPromptState extends State<LogoutPrompt> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height * .15,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Are you sure you want to log out?",
              style: TextStyle(
                color: Colors.orange,
                fontWeight: FontWeight.bold,
              ),
            ),
            isLoading
                ? Align(
                    alignment: Alignment.bottomRight,
                    child: SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        color: Colors.green,
                        backgroundColor: Colors.orange,
                      ),
                    ),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        child: Text(
                          "No",
                          style:
                              TextStyle(color: Theme.of(context).primaryColor),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      SizedBox(width: 10),
                      TextButton(
                        child: Text(
                          "Yes",
                          style: TextStyle(color: Colors.red[700]),
                        ),
                        onPressed: () async {
                          setState(() {
                            isLoading = true;
                          });
                          RestartWidget.restartApp(context);
                        },
                      ),
                    ],
                  )
          ],
        ),
      ),
    );
  }
}