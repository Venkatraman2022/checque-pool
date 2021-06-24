import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter_app_checkque_pool/services/app_exception.dart';
import 'package:http/http.dart' as http;

class BaseClient {
    static int Time_Out_Duration = 20;
  //Get
  Future<dynamic> get(String baseUrl,String api ) async{
    var uri = Uri.parse(baseUrl + api);

   try
       {
         var response = await http.get(uri).timeout(Duration(seconds: Time_Out_Duration));
         var r = jsonDecode(response.body);
         print(r);
         print(r['completed']);
         return processResponse(response);

       }
       on SocketException {
     throw FetchDataException('No Internet Connection', uri.toString());
       }
       on TimeoutException {
     throw ApiNotRespondingException('Api not responding in time ', uri.toString() );
       }
  }

  //Post
    Future<dynamic> post(String baseUrl,String api , dynamic payloadObj) async{
      var uri = Uri.parse(baseUrl + api);
      var payload = json.encode(payloadObj);
      try
      {
        var response = await http.post(uri,body: payload).timeout(Duration(seconds: Time_Out_Duration));
        return processResponse(response);
      }
      on SocketException {
        throw FetchDataException('No Internet Connection', uri.toString());
      }
      on TimeoutException {
        throw ApiNotRespondingException('Api not responding in time ', uri.toString() );
      }
    }



  dynamic processResponse(http.Response response){
    switch (response.statusCode){
      case 200:
        var responseJson = utf8.decode(response.bodyBytes);
        return responseJson;
        break;
      case 400:
        throw BadRequestException(utf8.decode(response.bodyBytes), response.request.url.toString());
      case 401:
      case 403:
      throw UnAuthorizedException(utf8.decode(response.bodyBytes), response.request.url.toString());

      case 500:
      default:
      throw FetchDataException('Error occured with code : ${response.statusCode}', response.request.url.toString());

    }
  }

}