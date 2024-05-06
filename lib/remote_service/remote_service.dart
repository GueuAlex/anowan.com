import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:ticketwave/model/ticket_model.dart';

///////////////// base uri prod //////////////
const baseUri = 'https://anowan.com/api/';

///////////////// prod headers //////////////
const headers = {
  'Content-Type': 'application/json',
  'Authorization': 'Bearer 1|5c90mMGGSpu6u5jqQd7op6PzAsD2INjDrCCirOD1ac9e8555'
};

///////////////// base uri test //////////////
//const baseUri = 'https://anowan.digifaz.com/api/';

///////////////// test headers //////////////
/* const headers = {
  'Content-Type': 'application/json',
  'Authorization': 'Bearer 1|rFzkHZKwWinlyzuGQC9uV7IIgW3bM9SWkfGrksvO'
}; */

///////////////////////////////////////
///
class RemoteService {
  //////////////////////////////////
  ///initialisation du client http
  var client = http.Client();
  //////////////////////////////
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
  Future<TicketModel?> getTicket({required String uniqueCode}) async {
    var uri = Uri.parse('${baseUri}tickets/$uniqueCode');
    var response = await client.get(uri, headers: headers);
    //print('my user Dans remote /////////////////////////// : ${response.body}');
    print('Dans remote////////////////////////////// : ${response.statusCode}');
    if (response.statusCode == 200 || response.statusCode == 201) {
      var json = response.body;
      print(response.body);
      TicketModel user = ticketModelFromJson(json);
      return user;
    }
    return null;
  }

//////////////////////////////////
  ///
  Future<int> postUserCode({
    required String uniqueId,
  }) async {
    var url = Uri.parse(baseUri + 'users/ticket');
    var data = {
      "unique_id": uniqueId,
    };
    var payload = jsonEncode(data);
    /*  var headers = {
      'Content-Type': 'application/json',
    }; */

    var response = await client.post(
      url,
      body: payload,
      headers: headers,
    );
    print('testooo : ${response.statusCode}');
    print(response.body);
    return response.statusCode;
  }

  //////////////////////////////// get single user by id //////////////////////
  ///
  /* Future<List<MyUserModel>> getUserList() async {
    var uri = Uri.parse(baseUri + 'users');
    var response = await client.get(uri);
    print('my user Dans remote /////////////////////////// : ${response.body}');
    print('Dans remote////////////////////////////// : ${response.statusCode}');
    if (response.statusCode == 200 || response.statusCode == 201) {
      var json = response.body;
      //print(response.body);
      List<MyUserModel> qrCodeModel = myUserModeListFromJson(json);
      return qrCodeModel;
    }
    return [];
  } */

  ////////////////////
  ///
  ///////////////// post user detail when otp code is verify//////////////////
  ///
  Future<dynamic> postUserDetails({
    required String api,
    //required MyUser user,
  }) async {
    ////////// parse our url /////////////////////
    var url = Uri.parse(baseUri + api);

    /////////////// encode user to jsn //////////////////////
    // var payload = userToJson(user);

    // http request headers
    /* var headers = {
      'Content-Type': 'application/json',
    }; */

    //////////////// post user ////////////
    var response = await client.post(
      url,
      //body: payload,
      headers: headers,
    );

    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 201 || response.statusCode == 200) {
      return response.body;
    } else if (response.statusCode == 422) {
      //var result = jsonDecode(response.body);
      /* if (result.containsKey("email")) {
        return 'emailError';
      } */
      return null;
    }
  }

  /////////////
  ///
  /////////////////////////////////// edit totine /////////////////////
  ///
  ///
  Future<dynamic> putUser({
    required String api,
    required Map<String, dynamic> data,
  }) async {
    ////////// parse our url /////////////////////
    var url = Uri.parse(baseUri + api);
    //var postEmail = {"email": email};
    ///////////// encode email to json objet/////////
    var payload = jsonEncode(data);
    // http request headers
    /* var headers = {
      'Content-Type': 'application/json',
    }; */

    var response = await client.put(url, body: payload, headers: headers);
    print(
        '---------------------------------///////////////////${response.statusCode}');
    //print(response.body);
    if (response.statusCode == 201 || response.statusCode == 200) {
      //Tontine tontine = tontineFromJson(response.body);
      var jsdecod = jsonDecode(response.body);
      //print('puuuuut : ${jsdecod['id']}');
      return jsdecod['id'];
    } else {
      return null;
    }
  }
}
