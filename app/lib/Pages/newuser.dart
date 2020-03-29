import 'package:flutter/material.dart';
import 'package:frontend/BO/BO.dart';
import 'package:frontend/models/user.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class Newuser extends StatefulWidget {
  User user;
  Newuser({this.user});
  @override
  _NewuserState createState() => _NewuserState();
}

class _NewuserState extends State<Newuser> {
  TextEditingController _controller1;
  TextEditingController _controller2;
  TextEditingController _controller3;
  TextEditingController _controller4;
  TextEditingController _controller5;
  bool validate1;
  bool validate2;
  bool validate3;
  bool validate4;
  bool validate5;
  double spaceBetweenTextfields;
  double spaceWithButton;
  bool outlineBorder;

  @override
  void initState() {
    if (widget.user == null) widget.user = new User.def();
    _controller1 = TextEditingController();
    _controller1.text = widget.user.username;
    _controller2 = TextEditingController();
    _controller2.text = widget.user.name;
    _controller3 = TextEditingController();
    _controller3.text = widget.user.lastname;
    _controller4 = TextEditingController();
    _controller4.text = widget.user.mail;
    _controller5 = TextEditingController();
    _controller5.text = widget.user.hashBase64;
    validate1 = true;
    validate2 = true;
    validate3 = true;
    validate4 = true;
    validate5 = true;
    spaceBetweenTextfields = 10.0;
    spaceWithButton = 30.0;
    outlineBorder = false;
    super.initState();
  }

  @override
  void dispose() {
    _controller1.dispose();
    _controller2.dispose();
    _controller3.dispose();
    _controller4.dispose();
    _controller5.dispose();
    super.dispose();
  }

  onPressed() {
    String username = _controller1.text;
    String name = _controller2.text;
    String lastname = _controller3.text;
    String mail = _controller4.text;
    String password = _controller5.text;
    setState(() {
      isNullOrEmpty(username) ? validate1 = false : validate1 = true;
      isNullOrEmpty(name) ? validate2 = false : validate2 = true;
      isNullOrEmpty(lastname) ? validate3 = false : validate3 = true;
      isNullOrEmpty(mail) ? validate4 = false : validate4 = true;
      isNullOrEmpty(password) ? validate5 = false : validate5 = true;
    });
    if (validate1 == true &&
        validate2 == true &&
        validate3 == true &&
        validate4 == true &&
        validate5 == true) {
          setState(() {
            widget.user.username = username;
            widget.user.name = name;
            widget.user.lastname = lastname;
            widget.user.mail = mail;
            widget.user.hash = password;
          });
      
      Navigator.of(context).pop(widget.user);
    }
  }

  Widget _inputData(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          textfield('User name', _controller1,
              obscureText: false,
              validate: validate1,
              outlineBorder: outlineBorder),
          SizedBox(height: spaceBetweenTextfields),
          textfield('Name', _controller2,
              obscureText: false,
              validate: validate2,
              outlineBorder: outlineBorder),
          SizedBox(height: spaceBetweenTextfields),
          textfield('Last name', _controller3,
              obscureText: false,
              validate: validate3,
              outlineBorder: outlineBorder),
          SizedBox(height: spaceBetweenTextfields),
          textfield('Mail', _controller4,
              obscureText: false,
              validate: validate4,
              outlineBorder: outlineBorder),
          SizedBox(height: spaceBetweenTextfields),
          textfield('Password', _controller5,
              obscureText: true,
              validate: validate5,
              outlineBorder: outlineBorder),
          SizedBox(height: spaceWithButton),
          isDefault(widget.user)
              ? raisedButton('Insert', fontSize: 18.0, onPressed: onPressed, height: 50.0)
              : raisedButton('Update', fontSize: 18.0, onPressed: onPressed, height: 50.0),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: isDefault(widget.user)
              ? new Text('New user')
              : new Text('Update user'),
        ),
        body: Center(child: _inputData(context)));
  }
}
