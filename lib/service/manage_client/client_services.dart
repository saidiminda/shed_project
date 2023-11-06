import 'package:dio/dio.dart';
import 'package:hotel_booking/database/database_manager.dart';
import 'package:hotel_booking/models/manageClient/clientModel.dart';

import '../../apis.dart';
// the given area of the following above
class ClientServices {
  final Dio _dio = Dio();
  final String _host = apis.host;

  Future<List<ClientclientModel>> getClients({required int user}) async {
    List<ClientclientModel> clients = [];
    final response =
        await _dio.get("$_host/get_hotel_client/$user/index/");

    if (response.statusCode == 200) {
      final results = response.data;
      if (results['success']) {
        final clientsMap = results['client'].toList();
        final dataMap = clientsMap.cast<Map<String, dynamic>>();
        clients = dataMap.map<ClientclientModel>((json) {
          return ClientclientModel.fromJson(json);
        }).toList();
      }

      clients.forEach((client) async {
        await client.saveToLocalDatabase(client);
      });
      return clients;
    } else {
      return clients;
    }
  }

  Future<List<ClientclientModel>> getClientsLocally() async {
    List<ClientclientModel> clients = [];
    final db = await DatabaseManager.instance.database;
    final _clients = await db.query("clients", orderBy: "id ASC");
    if (_clients.isNotEmpty) {
      clients = _clients.map((gap) {
        return ClientclientModel.fromJson(gap);
      }).toList();
    }
    return clients;
  }

  Future<List<ClientclientModel>> getNewClients(
      {required int last, required int user}) async {
    List<ClientclientModel> clients = [];
    final response =
        await _dio.get("$_host/get_hotel_client/$user/$last/index");

    if (response.statusCode == 200) {
      final results = response.data;
      if (results['success']) {
        final clientsMap = results['client'].toList();
        final dataMap = clientsMap.cast<Map<String, dynamic>>();
        clients = dataMap.map<ClientclientModel>((json) {
          return ClientclientModel.fromJson(json);
        }).toList();
      }
      clients.forEach((client) async {
        await client.saveToLocalDatabase(client);
      });
      return clients;
    } else {
      return clients;
    }
  }

  Future createClient({required Map<String, dynamic> clientData}) async {
    final FormData data = FormData.fromMap(clientData);
    print("$_host/get_hotel_client/save");
    final response =
        await _dio.post("$_host/get_hotel_client/save", data: data);
    if (response.statusCode == 200) {
      final results = response.data;
      return results['success'];
    } else {
      return "server returned error";
    }
  }
}

ClientServices clientServices = ClientServices();
