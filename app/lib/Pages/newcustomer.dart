import 'package:flutter/material.dart';
import 'package:frontend/BO/BO.dart';
import 'package:frontend/models/customer.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class Newcustomer extends StatefulWidget {
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


  @override
  void initState() {
    if (widget.customer == null) widget.customer = new Customer.def();
    _controller1 = TextEditingController();
    _controller1.text = widget.customer.username;
    _controller2 = TextEditingController();
    _controller2.text = widget.customer.name;
    _controller3 = TextEditingController();
    _controller3.text = widget.customer.lastname;
    _controller4 = TextEditingController();
    _controller4.text = widget.customer.mail;
    _controller5 = TextEditingController();
    _controller5.text = widget.customer.hash;
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

  Widget textfield(
      String labeltext, TextEditingController controller,
      {bool obscureText, bool validate, bool outlineBorder = false}) {
    InputDecoration inputDecoration;
    if (validate != null && outlineBorder == false) {
      inputDecoration = InputDecoration(
        labelText: labeltext,
        errorText: validate ? null : 'Field can\'t be empty',
      );
    } else if (validate != null && outlineBorder == true) {
      inputDecoration = InputDecoration(
        labelText: labeltext,
        border: OutlineInputBorder(),
        errorText: validate ? null : 'Field can\'t be empty',
      );
    } else if (validate == null && outlineBorder == false) {
      inputDecoration = InputDecoration(
        labelText: labeltext,
      );
    } else {
      inputDecoration = InputDecoration(
        labelText: labeltext,
        border: OutlineInputBorder(),
      );
    }
    return TextField(
      obscureText: obscureText,
      decoration: inputDecoration,
      controller: controller,
    );
  }

  Widget button(String buttonText) {
    {
      return Container(
          height: 50,
          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: RaisedButton(
            textColor: Colors.white,
            child: Text(
              buttonText,
              style: TextStyle(fontSize: 18),
            ),
            onPressed: () {
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
                widget.customer =
                    new Customer(username, name, lastname, mail, password, id: widget.customer.id);
                Navigator.of(context).pop(widget.customer);
              }
            },
          ));
    }
  }

  Widget _inputData(BuildContext context) {
    double height = 10.0;
    double height2 = 30.0;
    bool outlineBorder = false;
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          textfield('User name', _controller1, obscureText: false, validate: validate1, outlineBorder: outlineBorder),
          SizedBox(height: height),
          textfield('Name', _controller2, obscureText: false, validate: validate2, outlineBorder: outlineBorder),
          SizedBox(height: height),
          textfield('Last name', _controller3, obscureText: false, validate: validate3, outlineBorder: outlineBorder),
          SizedBox(height: height),
          textfield('Mail', _controller4, obscureText: false, validate: validate4, outlineBorder: outlineBorder),
          SizedBox(height: height),
          textfield('Password', _controller5, obscureText: true, validate: validate5, outlineBorder: outlineBorder),
          SizedBox(height: height2),
          isDefault(widget.customer) ? button('Insert') : button('Update'),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: IconButton(icon: Icon(Icons.arrow_left, size: 40,), onPressed: () {
            Navigator.of(context).pop(widget.customer);
          },),
          title: isDefault(widget.customer)
              ? new Text('New customer')
              : new Text('Update customer'),
        ),
        body: Center(child: _inputData(context)));
  }
}
