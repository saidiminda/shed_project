import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hotel_booking/constants.dart';
import 'package:hotel_booking/models/roomHotel/roomHotelModel.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
class Delete {
  late String username;
  late SharedPreferences logindata;

  Future<RegisterroomsModel> deleteAlbum(String id) async {
    var userdata = jsonDecode(logindata.getString('hotelRoomData') ?? "");
    int username = int.parse(userdata['id'].toString());
    final http.Response response = await http.delete(
      Uri.parse('$domainUrl/api/hotel_rooms_delete/$username/index'),
      headers:headers,
    );

    if (response.statusCode == 200) {
      return RegisterroomsModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to delete');
    }
  }
}

// class Delete extends StatefulWidget {
//   const Delete({super.key});

//   @override
//   State<Delete> createState() {
//     return _DeleteState();
//   }
// }

// class _DeleteState extends State<Delete> {
//    Future<RegisterroomsModel>? _futureAlbum;

//   @override
//   void initState() {
//     super.initState();
//     _futureAlbum = fetchAlbum();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Delete',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: Scaffold(
//         body: Center(
//           child: FutureBuilder<RegisterroomsModel>(
//             future: _futureAlbum,
//             builder: (context, snapshot) {
//               if (snapshot.connectionState == ConnectionState.done) {
//                 if (snapshot.hasData) {
//                   return Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: <Widget>[
//                       Text(snapshot.data?.roomsName ?? 'Deleted'),
//                       ElevatedButton(
//                         child: const Text('Delete Data'),
//                         onPressed: () {
//                           setState(() {
//                             _futureAlbum =
//                                 deleteAlbum(snapshot.data!.hotel_id.toString());
//                           });
//                         },
//                       ),
//                     ],
//                   );
//                 } else if (snapshot.hasError) {
//                   return Text('${snapshot.error}');
//                 }
//               }

//               return const CircularProgressIndicator();
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }