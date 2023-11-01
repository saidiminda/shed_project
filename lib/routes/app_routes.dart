import 'package:flutter/material.dart';
import 'package:hotel_booking/pages/loginPage/registerPage.dart';
import 'package:hotel_booking/pages/roomType/newRoomType.dart';
import 'package:hotel_booking/pages/roomType/roomTypeList.dart';
import 'package:hotel_booking/pages/home/home_page.dart';
import 'package:hotel_booking/pages/loginPage/loginPage.dart';
import 'package:hotel_booking/pages/manage_booking/add_room.dart';
import 'package:hotel_booking/pages/manage_booking/bookingList.dart';
import 'package:hotel_booking/pages/manage_booking/create_booking_screen.dart';
import 'package:hotel_booking/pages/manage_client/add_client_details.dart';
import 'package:hotel_booking/pages/manage_client/view_client.dart';
import 'package:hotel_booking/pages/manage_property/add_propertyRoom.dart';
import 'package:hotel_booking/pages/manage_property/view_propertyList.dart';
import 'package:hotel_booking/pages/managecheckAvailability/checkAvailability.dart';
import 'package:hotel_booking/pages/notification/notification.dart';
import 'package:hotel_booking/pages/settings/account.dart';
import 'package:hotel_booking/pages/settings/profile_page.dart';
import 'package:hotel_booking/pages/settings/setting_screen.dart';
import 'package:hotel_booking/pages/welcomePage/registerProperty.dart';
import 'package:hotel_booking/pages/welcomePage/welcomePage.dart';
import 'package:hotel_booking/service/delete&update/delete&update.dart';
import 'package:hotel_booking/service/delete&update/update.dart';
// the plugin 
class AppRoutes {
  static const String navigationPage = '/navigation';
  static const String dashboard = '/dashboard';
  static const String drawer = '/drawer';
  static const String settings = '/settings';
  static const String addClient = '/addclient';
  static const String addBooking = '/addbooking';
  static const String clientList = '/clientList';
  static const String addRooms = '/addRooms';
  static const String bookingList = '/bookingList';
  static const String propertyList = '/propertyList';
  static const String newProperty = '/newProperty';
  static const String viewProperty = '/addProperty';
  static const String roomList = '/roomList';
  static const String roomType = '/roomType';
  static const String checkAvailability = '/checkAva';
  static const String welcomePage = '/welcomePage';
  static const String registerPage = '/registerPage';
  static const String login = '/login';
  static const String notification = '/notification';
  static const String account = '/account';
  static const String register = '/register';
  static const String delete='/delete';
  static const String update='/update';
  static const String profile='/profile';
// the given area of the following area of the following angle of the table
  static Map<String, WidgetBuilder> routes = {
    dashboard: (context) => HomePage(),
    settings: (context) => const SettingsScreen(),
    addClient: (context) => const AddClientScreen(),
    addBooking: (context) => CreateBookingScreen(),
    clientList: (context) => const ClientListScreen(),
    addRooms: (context) => AddBookingScreen(),
    bookingList: (context) => const BookingListScreen(),
    propertyList: (context) => const ViewPropertyListScreen(),
    viewProperty: (context) => AddPropertyRoomScreen(),
    roomList: (context) => RoomListScreen(),
    roomType: (context) => RoomTypeScreen(),
    checkAvailability: (context) => const CheckAvailabilityScreen(),
    welcomePage: (context) => WelcomePage(),
    registerPage: (context) => RegisterProperty(),
    login: (context) => SignIn(),
    notification: (context) => NotificationScreen(),
    account: (context) => AccountsScreen(),
    register: (context) => RegistrationScreen(),
    // delete:(context) => const Delete(),
    // update:(context)  => const Update(),
    profile:(context) =>  ProfilePage()
  };
}
