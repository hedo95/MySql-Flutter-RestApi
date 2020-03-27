import 'package:frontend/BO/BO.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'customer.dart';

class Http {
  // localhost || 10.0.2.2 (mysql) || 192.168.1.165 (home) || 10.192.82.178 (eduroam) || 10.10.10.47 (PIA despscho Juanjo) 
  final url = 'http://localhost:4000/';
  final customers = 'customers/';
  final headers = {'Content-Type': 'application/json'};
  final encoding = Encoding.getByName('utf-8');

  Http ();

  Future<List<Customer>> getCustomers() async {
    http.Response response = await http.get('$url$customers');
    List<Customer> result = new List<Customer>.from(json
          .decode(response.body)
          .map((jsonObject) => new Customer.fromJson(jsonObject)));
    result.sort((a, b) => a.id.compareTo(b.id));
    print('${getstatusCode(response.statusCode)}');
    return result;
  }


  makeCustomerDeleteRequest(Customer customer) async {
    http.Response response = await http.delete('$url$customers${customer.id}', headers: headers);
    print(response.body);
    print('Estado de respuesta ${response.statusCode} => ${getstatusCode(response.statusCode)}');
  }

  makeCustomerPutRequest(Customer customer) async {
    String body = json.encode(customer.toJson());
    http.Response response = await http.put('$url$customers${customer.id}',
        headers: headers, body: body, encoding: encoding);
    print(response.body);
    print(
        'Estado de respuesta ${response.statusCode} => ${getstatusCode(response.statusCode)}');
  }

  makeCustomerPostRequest(Customer customer) async {
    String body = json.encode(customer.toJson());
    http.Response response =
        await http.post('$url$customers', headers: headers, body: body, encoding: encoding);
    print(response.body);
    print(
        'Estado de respuesta ${response.statusCode} => ${getstatusCode(response.statusCode)}');
  }
  
}