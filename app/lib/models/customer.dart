import 'package:password/password.dart';

class Customer {
  int id;
  String username, name, lastname, mail, hash;
  PBKDF2 algorithm;

  Customer(this.username, this.name, this.lastname, this.mail, String password,
      {this.id}) {
    algorithm = new PBKDF2();
    this.hash = Password.hash(password, algorithm);
  }
  Customer.def() {
    id = -1;
    username = '';
    name = '';
    lastname = '';
    mail = '';
    hash = '';
  }

  passwordVerify(String password) {
    return Password.verify(password, hash);
  }

  toJson() => {
        'id': id,
        'username': username,
        'name': name,
        'lastname': lastname,
        'mail': mail,
        'password': hash
      };

  factory Customer.fromJson(Map<String, dynamic> json) {
    return new Customer(
        json['username'] as String,
        json['name'] as String,
        json['lastname'] as String,
        json['mail'] as String,
        json['password'] as String,
        id: json['id'] as int);
  }
}
