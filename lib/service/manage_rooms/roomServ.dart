import 'package:dio/dio.dart';
import 'package:hotel_booking/database/database_manager.dart';
import 'package:hotel_booking/models/roomHotel/roomHotelModel.dart';

import '../apis.dart';

class ClientServices {
  final Dio _dio = Dio();
  final String _host = apis.host;

  Future<List<RegisterroomsModel>> getClients({required int user}) async {
    List<RegisterroomsModel> clients = [];
    final response =
        await _dio.get("$_host/get_hotel_client/$user/index/");

    if (response.statusCode == 200) {
      final results = response.data;
      if (results['success']) {
        final clientsMap = results['client'].toList();
        final dataMap = clientsMap.cast<Map<String, dynamic>>();
        clients = dataMap.map<RegisterroomsModel>((json) {
          return RegisterroomsModel.fromJson(json);
        }).toList();
      }

      clients.forEach((client) async {
        // await client.saveToLocalDatabase(client);
      });
      return clients;
    } else {
      return clients;
    }
  }

  Future<List<RegisterroomsModel>> getClientsLocally() async {
    List<RegisterroomsModel> clients = [];
    final db = await DatabaseManager.instance.database;
    final _clients = await db.query("roomHotel", orderBy: "hotel_id ASC");
    if (_clients.isNotEmpty) {
      clients = _clients.map((gap) {
        return RegisterroomsModel.fromJson(gap);
      }).toList();
    }
    return clients;
  }

  Future<List<RegisterroomsModel>> getNewClients(
      {required int last, required int user}) async {
    List<RegisterroomsModel> clients = [];
    final response =
        await _dio.get("$_host/get_hotel_client/$user/$last/index");

    if (response.statusCode == 200) {
      final results = response.data;
      if (results['success']) {
        final clientsMap = results['client'].toList();
        final dataMap = clientsMap.cast<Map<String, dynamic>>();
        clients = dataMap.map<RegisterroomsModel>((json) {
          return RegisterroomsModel.fromJson(json);
        }).toList();
      }
      clients.forEach((client) async {
        // await client.saveToLocalDatabase(client);
      });
      return clients;
    } else {
      return clients;
    }
  }

  Future createClient(Map<String, dynamic> newccount, {required Map<String, dynamic> clientData}) async {
    final FormData data = FormData.fromMap(clientData);
    print("$_host/mazaohub/pos/get_client/save");
    final response =
        await _dio.post("$_host/mazaohub/pos/get_client/save", data: data);
    if (response.statusCode == 200) {
      final results = response.data;
      return results['success'];
    } else {
      return "server returned error";
    }
  }
}

ClientServices clientServices = ClientServices();
