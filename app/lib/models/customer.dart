

import 'package:password/password.dart';

class Customer {
  int id;
  String username, name, lastname, mail, password;
  PBKDF2 algorithm;

  Customer(this.username, this.name, this.lastname, this.mail, String password, {this.id}){
    algorithm = new PBKDF2();
    this.password = Password.hash(password, algorithm);
  } 
  Customer.def(){
    id = null;
    username = '';
    name = '';
    lastname = '';
    mail = '';
    password = '';
  }

  bool passwordVerify(String password){
    String hash = Password.hash(password, algorithm);
    return Password.verify(hash, this.password);
  }

  toJson(){
    Map<String,dynamic> json = {};
    if(id != null){
      json.putIfAbsent('id', () => id);
    }
    json.putIfAbsent('username', () => username);
    json.putIfAbsent('name', () => name);
    json.putIfAbsent('lastname', () => lastname);
    json.putIfAbsent('mail', () => mail);
    json.putIfAbsent('password', () => password);
    return json;
  }

  factory Customer.fromJson(Map<String, dynamic> json){
    return new Customer(
      json['username'] as String,
      json['name'] as String,
      json['lastname'] as String,
      json['mail'] as String,
      json['password'] as String,
      id: json['id'] as int
    );
  }
}