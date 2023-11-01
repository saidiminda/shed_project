import 'package:flutter/material.dart';
import 'package:hotel_booking/classes/language_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hotel_booking/routes/app_routes.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:workmanager/workmanager.dart';

void main() {
  runApp(
    const MyApp(),
  );
  WidgetsFlutterBinding.ensureInitialized();

  Workmanager().initialize(

      // The top level function, aka callbackDispatcher
      callbackDispatcher,

      // If enabled it will post a notification whenever
      // the task is running. Handy for debugging tasks
      isInDebugMode: true);
  Workmanager().registerPeriodicTask(
    "2",
    //This is the value that will be
    // returned in the callbackDispatcher
    "simplePeriodicTask",

    // When no frequency is provided
    // the default 15 minutes is set.
    // Minimum frequency is 15 min.
    // Android will automatically change
    // your frequency to 15 min
    // if you have configured a lower frequency.
    frequency: const Duration(minutes: 15),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();

  static void setLocale(BuildContext context, Locale newLocale) {
    _MyAppState? state = context.findAncestorStateOfType<_MyAppState>();
    state?.setLocale(newLocale);
  }
}
// action
String? finalEmail;
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) {
    FlutterLocalNotificationsPlugin flip = FlutterLocalNotificationsPlugin();

    // app_icon needs to be a added as a drawable
    // resource to the Android head project.
    var android = const AndroidInitializationSettings('@mipmap/ic_launcher');

    var settings = InitializationSettings(android: android);
    flip.initialize(settings);
    _showNotificationWithDefaultSound(flip);
    return Future.value(true);
  });
}

Future _showNotificationWithDefaultSound(flip) async {
  // Show a notification after every 15 minute with the first
  // appearance happening a minute after invoking the method
  var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
    'Emasuite Hotel App',
    'Emasuite Hotel App',
    importance: Importance.max,
    priority: Priority.high,
    channelShowBadge: true, //
  );

  // initialise channel platform for both Android and iOS device.
  var platformChannelSpecifics = NotificationDetails(
    android: androidPlatformChannelSpecifics,
  );
  await flip.show(
      0,
      'Hotel Booking From Emasuite',
      'Your are one step away to connect with Emasuite App',
      platformChannelSpecifics,
      payload: 'Default_Sound');
}

class _MyAppState extends State<MyApp> {
  Locale? _locale;

  setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  void didChangeDependencies() {
    getLocale().then((locale) => {setLocale(locale)});
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.deepPurple,
          brightness: Brightness.dark,
        ).copyWith(secondary: Colors.deepPurple),
      ),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: _locale,
      home: const Scaffold(
        body: Center(
          child: Text('Hotel Booking'),
        ),
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.login,
      routes: AppRoutes.routes,
    );
  }
}
