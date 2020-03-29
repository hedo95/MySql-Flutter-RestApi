import 'package:flutter/material.dart';
import 'package:frontend/Pages/homepage.dart';
import 'package:frontend/Pages/newuser.dart';
import 'package:frontend/models/user.dart';
import 'package:frontend/models/http.dart';
import 'dart:async';
import 'dart:convert';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  // Passwords are "12345678". They are encrypted at database.
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool hidePassword = true;
  Http http = new Http();

  void openDialog(BuildContext context, String dialogContent) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: new Text('Invalid data'),
            content:
                new Text(dialogContent),
            actions: <Widget>[
              new FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: new Text('Back'))
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    List<User> users = Provider.of<List<User>>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text('Login'),
        ),
        body: Padding(
            padding: EdgeInsets.all(10),
            child: ListView(
              children: <Widget>[
                Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'Company',
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 30),
                    )),
                Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'Sign in',
                      style: TextStyle(fontSize: 20),
                    )),
                Container(
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'User Name',
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: TextField(
                    obscureText: hidePassword,
                    controller: passwordController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Password',
                        suffixIcon: IconButton(
                            icon: Icon(hidePassword
                                ? Icons.visibility_off
                                : Icons.visibility),
                            onPressed: () {
                              setState(() {
                                hidePassword = !hidePassword;
                              });
                            })),
                  ),
                ),
                FlatButton(
                  onPressed: () {
                    //forgot password screen
                  },
                  textColor: Colors.orange,
                  child: Text('Forgot Password'),
                ),
                Container(
                    height: 50,
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: RaisedButton(
                      textColor: Colors.white,
                      child: Text('Login'),
                      onPressed: () {
                        if (users.any(
                            (item) => item.username == nameController.text)) {
                          User user = users.firstWhere(
                              (item) => item.username == nameController.text);
                          if (user
                              .passwordVerify(passwordController.text)) {
                            // Login App: openDialog(context, 'You're in! App gets started here with the current user')    
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => MyHomePage()));
                          } else {
                            openDialog(context, 'Invalid password');
                          }
                        } else {
                          openDialog(context, 'Make sure your username and password are correct');
                        }
                        print(nameController.text);
                        print(passwordController.text);
                      },
                    )), // kldj-34gb-gj89-45gd
                Container(
                    child: Row(
                  children: <Widget>[
                    Text('Does not have account?'),
                    FlatButton(
                      textColor: Colors.orange,
                      child: Text(
                        'Sign in',
                        style: TextStyle(fontSize: 20),
                      ),
                      onPressed: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(
                                builder: (context) => Newuser()))
                            .then((user) {
                          int id = users[users.length - 1].id + 1;
                          http.makeUserPostRequest(user);
                          user.id = id;
                          users.add(user);
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => MyHomePage()));
                        });
                      },
                    )
                  ],
                  mainAxisAlignment: MainAxisAlignment.center,
                ))
              ],
            )));
  }
}
