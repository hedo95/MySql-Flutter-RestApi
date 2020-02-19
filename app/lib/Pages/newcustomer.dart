import 'package:flutter/material.dart';
import 'package:frontend/BO/BO.dart';
import 'package:frontend/models/customer.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class Newcustomer extends StatefulWidget{
  Customer customer;
  Newcustomer({this.customer});
  @override
  _NewcustomerState createState() => _NewcustomerState();
}

class _NewcustomerState extends State<Newcustomer> {
  TextEditingController _controller1;
  TextEditingController _controller2;
  TextEditingController _controller3;
  TextEditingController _controller4;
  TextEditingController _controller5;
  bool validate1 = true;
  bool validate2 = true;
  bool validate3 = true;
  bool validate4 = true;
  bool validate5 = true;

  isDefault(Customer customer){
    if(customer.name == '' && customer.lastname == ''){
      return true;
    } else {
      return false;
    }
  }

  @override
  void initState() {
    if(widget.customer == null) widget.customer = new Customer.def();
    _controller1 = TextEditingController();
    _controller1.text = widget.customer.username;
    _controller2 = TextEditingController();
    _controller2.text = widget.customer.name;
    _controller3 = TextEditingController();
    _controller3.text = widget.customer.lastname;
    _controller4 = TextEditingController();
    _controller4.text = widget.customer.mail;
    _controller5 = TextEditingController();
    _controller5.text = widget.customer.password;
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

  Widget _inputData(BuildContext context){
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          TextField(
            decoration: InputDecoration(
              labelText: 'User name',
              errorText: validate1 ? null : 'Field can\'t be empty',
            ),
            controller: _controller1,
          ),
          SizedBox(height: 10),
          TextField(
            decoration: InputDecoration(
              labelText: 'Name',
              errorText: validate2 ? null : 'Field can\'t be empty',
            ),
            controller: _controller2,
          ),
          SizedBox(height: 10),
          TextField(
            decoration: InputDecoration(
              labelText: 'Last name',
              errorText: validate3 ? null:  'Field can\'t be empty',
            ),
            controller: _controller3,
          ),
          SizedBox(height: 10),
          TextField(
            decoration: InputDecoration(
              labelText: 'Mail',
              errorText: validate4 ? null : 'Field can\'t be empty',
            ),
            controller: _controller4,
          ),
          SizedBox(height: 10),
          TextField(
            obscureText: true,
            decoration: InputDecoration(
              labelText: 'Password',
              errorText: validate5 ? null : 'Field can\'t be empty',
            ),
            controller: _controller5,
          ),
          SizedBox(height: 50),
          RaisedButton(
                child: isDefault(widget.customer) ? Text('Insert') : Text('Update'),
                onPressed: () {
                  String username = _controller1.text;
                  String name = _controller2.text;
                  String lastname = _controller3.text;
                  String mail = _controller4.text;
                  String password = _controller5.text;
                  setState(() {
                    username == '' ? validate1 = false : validate1 = true;
                    name == '' ? validate2 = false : validate2 = true;
                    lastname == '' ? validate3 = false : validate3 = true;
                    mail == '' ? validate4 = false : validate4 = true;
                    password == '' ? validate5 = false : validate5 = true;
                  });
                  if(validate1 == true && validate2 == true && validate3 == true && validate4 == true && validate5 == true ){
                    widget.customer = new Customer(username, name, lastname, mail, password, id: widget.customer.id);
                    Navigator.of(context).pop(widget.customer);
                  }
                },
              ),
        ],
      ),
    );
  }

  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: new Text('New customer'),
      ),
      body: Center(
        child: _inputData(context)
      )
    );
  }
}