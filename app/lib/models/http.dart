import 'package:frontend/BO/BO.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'user.dart';

class Http {
  // localhost || 10.0.2.2 (mysql) || 192.168.1.165 (home) || 10.192.82.178 (eduroam) || 10.10.10.47 (PIA despscho Juanjo) 
  final url = 'http://localhost:4000/';
  final users = 'Users/';
  final headers = {'Content-Type': 'application/json'};
  final encoding = Encoding.getByName('utf-8');

  Http ();

  Future<List<User>> getUsers() async {
    http.Response response = await http.get('$url$users');
    List<User> result = new List<User>.from(json
          .decode(response.body)
          .map((jsonObject) => new User.fromJson(jsonObject)));
    result.sort((a, b) => a.id.compareTo(b.id));
    print('${getstatusCode(response.statusCode)}');
    return result;
  }

  makeUserDeleteRequest(User user) async {
    http.Response response = await http.delete('$url$users${user.id}', headers: headers);
    print(response.body);
    print('Estado de respuesta ${response.statusCode} => ${getstatusCode(response.statusCode)}');
  }

  makeUserPutRequest(User user) async {
    String body = json.encode(user.toJson());
    http.Response response = await http.put('$url$users${user.id}',
        headers: headers, body: body, encoding: encoding);
    print(response.body);
    print(
        'Estado de respuesta ${response.statusCode} => ${getstatusCode(response.statusCode)}');
  }

  makeUserPostRequest(User user) async {
    String body = json.encode(user.toJson());
    http.Response response =
        await http.post('$url$users', headers: headers, body: body, encoding: encoding);
    print(response.body);
    print(
        'Estado de respuesta ${response.statusCode} => ${getstatusCode(response.statusCode)}');
  }
  
}