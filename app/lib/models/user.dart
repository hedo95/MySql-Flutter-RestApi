import 'package:password/password.dart';
import 'package:encrypt/encrypt.dart';
import 'package:random_string/random_string.dart';

class User {
  int _id;
  String _username, _name, _lastname, _mail;
  Encrypter _encrypter;
  Encrypted _hash;
  String _randomStr;

  set id(int id) {
    _id = id;
  }

  set username(String username) {
    _username = username;
  }

  set name(String name) {
    _name = name;
  }

  set lastname(String lastname) {
    _lastname = lastname;
  }

  set mail(String mail) {
    _mail = mail;
  }

  set hash(String password) {
    _encrypter =
        Encrypter(Salsa20(Key.fromUtf8('$_username$_name$_lastname$_mail')));
    _hash = _encrypter.encrypt(password, iv: IV.fromUtf8(_randomStr));
  }

  int get id {
    return _id;
  }

  String get username {
    return _username;
  }

  String get name {
    return _name;
  }

  String get lastname {
    return _lastname;
  }

  String get mail {
    return _mail;
  }

  String get randomStr {
    return '$_randomStr';
  }

  String get hashBase64 {
    if (_hash == null)
      return '';
    else
      return '${_hash.base64}';
  }

  User.db(this._id, this._username, this._name, this._lastname, this._mail,
      this._randomStr, String hash) {
    _encrypter =
        Encrypter(Salsa20(Key.fromUtf8('$_username$_name$_lastname$_mail')));
    _hash = Encrypted.from64(hash);
  }

  User.def() {
    _id = -1;
    _username = '';
    _name = '';
    _lastname = '';
    _mail = '';
    _randomStr = randomString(8);
    _encrypter = null;
    _hash = null;
  }

  bool passwordVerify(String newpassword) {
    Encrypted newhash =
        _encrypter.encrypt(newpassword, iv: IV.fromUtf8(_randomStr));
    if (newhash.base64 == hashBase64)
      return true;
    else
      return false;
  }

  toJson() => {
        'id': id,
        'username': username,
        'name': name,
        'lastname': lastname,
        'mail': mail,
        'randomstr': randomStr,
        'hash': hashBase64
      };

  factory User.fromJson(Map<String, dynamic> json) {
    return new User.db(
        json['id'] as int,
        json['username'] as String,
        json['name'] as String,
        json['lastname'] as String,
        json['mail'] as String,
        json['randomstr'] as String,
        json['hash'] as String);
  }
}
