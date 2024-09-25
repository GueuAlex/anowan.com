import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:ticketwave/model/event_model.dart';
import 'package:ticketwave/model/organizer_model.dart';

import '../model/prestator_model.dart';

final token = dotenv.env['API_TOKEN']!;

class RemoteService {
  //////////////////////////////////
  ///initialisation du client http
  var client = http.Client();
  //////////////////////////////
  ///////////////// base uri prod //////////////
  final baseUri = dotenv.env['BASE_URL']!;

///////////////// prod headers //////////////
  final headers = {
    'Content-Type': 'application/json',
    'Authorization': token,
  };

  ///
  ///
  Future<dynamic> putSomethings({
    required String api,
    required Map<String, dynamic> data,
  }) async {
    ////////// parse our url /////////////////////
    var url = Uri.parse(baseUri + api);
    //var postEmail = {"email": email};
    ///////////// encode email to json objet/////////
    var payload = jsonEncode(data);
    // http request headers

    var response = await client.put(url, body: payload, headers: headers);
    print('------------------------${response.statusCode}');
    // print('------------------------///////////////////${response.body}');
    print(response.body);
    if (response.statusCode == 201 || response.statusCode == 200) {
      //Tontine tontine = tontineFromJson(response.body);
      var jsdecod = jsonDecode(response.body);
      //print('puuuuut : ${jsdecod['id']}');
      return jsdecod['id'];
    } else {
      return null;
    }
  }

  //////////////////////////////// get single user by id //////////////////////
  ///
  Future<http.Response> getTicket({required String uniqueCode}) async {
    var uri = Uri.parse('${baseUri}tickets/$uniqueCode');
    var response = await client.get(uri, headers: headers);
    //print('my user Dans remote /////////////////////////// : ${response.body}');
    print('Dans remote////////////////////////////// : ${response.statusCode}');

    return response;
  }

  //////////////////////////////// get single user by id //////////////////////
  ///
  Future<http.Response> postSomethings(
      {required String api, required Map<String, dynamic> data}) async {
    ////////// parse our url /////////////////////

    var uri = Uri.parse('$baseUri$api');
    print(uri);
    var _payload = jsonEncode(data);
    var response = await client.post(
      uri,
      body: _payload,
      headers: headers,
    );
    print('$data was posted  /////////////////////////// : ${response.body}');
    print('response statut code //////////////////// : ${response.statusCode}');

    return response;
  }

  /////// fetch all organizers
  ///ameliore cette fonction (try catch et throw les exceptions)
  Future<List<OrganizerModel>> getOrganisers() async {
    try {
      var uri = Uri.parse('${baseUri}organizers');
      var response = await client.get(uri, headers: headers);

      print('organizers response code ----------> : ${response.statusCode}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        var json = response.body;
        print('organizers response body ----------> : $json');
        List<OrganizerModel> organizers = listOrganizerModelFromJson(json);
        return organizers;
      } else {
        throw Exception(
            'Failed to load organizers. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching organizers: $e');
      throw Exception('Error fetching organizers: $e');
    }
  }

  /////// fetch all organizers
  ///le endpoints events renvie la list des events de façons paginé avec maximum 50 events par page.
  ///ameliore la fonction de sorte apprendre cela en compte
  ///l'appel cette fonction se fera également avec riverpod
  ///implement le provider pour le riverpod
  Future<List<EventModel>> getEvents() async {
    try {
      var uri = Uri.parse('${baseUri}events');
      var response = await client.get(uri, headers: headers);

      print('events response code ----------> : ${response.statusCode}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        var json = response.body;
        print('events response body ----------> : $json');
        List<EventModel> events = listEventModelFromJson(json);
        return events;
      } else {
        throw Exception(
            'Failed to load events. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching events: $e');
      throw Exception('Error fetching events: $e');
    }
  }

  /////// fetch all organizers
  ///le endpoints events renvie la list des events de façons paginé avec maximum 50 events par page.
  ///ameliore la fonction de sorte apprendre cela en compte
  ///l'appel cette fonction se fera également avec riverpod
  ///implement le provider pour le riverpod
  Future<List<PrestatorMdel>> getServceProviders() async {
    try {
      var uri = Uri.parse('${baseUri}service-providers');
      var response = await client.get(uri, headers: headers);

      print('prestators response code ----------> : ${response.statusCode}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        // Décodage de la réponse JSON
        var json = response.body;
        print('prestators response body ----------> : $json');

        // Récupération des données à partir de la clé 'data'
        List<PrestatorMdel> prestators = prestatorMdelListFromJson(json);
        return prestators;
      } else {
        throw Exception(
            'Failed to load service providers. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching providers print: $e');
      throw Exception('Error fetching service providers throw: $e');
    }
  }

  /// get organizer events
  Future<List<EventModel>> getOrganizerEvents(
      {required String organizerId}) async {
    try {
      var uri = Uri.parse('${baseUri}organizers/$organizerId/events');
      var response = await client.get(uri, headers: headers);

      print('prestators response code ----------> : ${response.statusCode}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        // Décodage de la réponse JSON
        var json = response.body;
        print('prestators response body ----------> : $json');

        // Récupération des données à partir de la clé 'data'
        List<EventModel> events = listEventModelFromJson(json);
        return events;
      } else {
        throw Exception(
            'Failed to load organizers events. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching organizers events print: $e');
      throw Exception('Error fetching organizers events throw: $e');
    }
  }
}



/* class reponseData<T> {
  String? id;
  List<T> data;

  reponseData({this.id,  required this.data});
  factory reponseData.fromJson(Map<String, dynamic> json) => reponseData(
    id: json['id'],
    data: List<T>.from(json['data'].map((x) => T.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'data': List<dynamic>.from(data.map((x) => x.toJson())),
  };
} */
