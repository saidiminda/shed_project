import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hotel_booking/constants.dart';
import 'package:hotel_booking/models/roomHotel/roomHotelModel.dart';
import 'package:http/http.dart' as http;
class Update{

Future<RegisterroomsModel> updateAlbum(String 
roomNameController,
priceController,toiletController,
selectTypeRoomController,descriptionController) async {
  final response = await http.put(
    Uri.parse('$domainUrl/hotel_rooms_update/update'),
    headers:headers,
    body: jsonEncode(<String, String>{
      "name": roomNameController,
      "price": priceController,
      "toilet":toiletController,
      "room_type": selectTypeRoomController,
      "description": descriptionController
    }),
  );

  if (response.statusCode == 200) {
    return RegisterroomsModel.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to update album.');
  }
}

}



// class Update extends StatefulWidget {
//   const Update({super.key});

//   @override
//   State<Update> createState() {
//     return _UpdateState();
//   }
// }

// class _UpdateState extends State<Update> {
//   final TextEditingController _controller = TextEditingController();
//   late Future<RegisterroomsModel> _futureAlbum;

//   @override
//   void initState() {
//     super.initState();
//     _futureAlbum = fetchAlbum();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Update Data Example',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: Scaffold(
//         // appBar: AppBar(
//         //   title: const Text('Update Data Example'),
//         // ),
//         body: Container(
//           alignment: Alignment.center,
//           padding: const EdgeInsets.all(8),
//           child: FutureBuilder<RegisterroomsModel>(
//             future: _futureAlbum,
//             builder: (context, snapshot) {
//               if (snapshot.connectionState == ConnectionState.done) {
//                 if (snapshot.hasData) {
//                   return Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: <Widget>[
//                       Text(snapshot.data!.roomsName!),
//                       TextField(
//                         controller: _controller,
//                         decoration: const InputDecoration(
//                           hintText: 'Enter Title',
//                         ),
//                       ),
//                       ElevatedButton(
//                         onPressed: () {
//                           setState(() {
//                             _futureAlbum = updateAlbum(_controller.text);
//                           });
//                         },
//                         child: const Text('Update Data'),
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
