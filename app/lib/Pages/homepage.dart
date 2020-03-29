import 'package:flutter/material.dart';
import 'package:frontend/Pages/newuser.dart';
import 'package:frontend/models/user.dart';
import 'package:frontend/models/http.dart';
import 'package:frontend/BO/BO.dart';
import 'dart:async';
import 'dart:convert';
import 'package:provider/provider.dart';
import 'package:encrypt/encrypt.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage();
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<User> users = [];
  Http http = new Http();
  int index;
  Color leadingBackgroundColor;
  Color leadingNumberColor;

  @override
  initState() {
    super.initState();
  }

  onExpansionChanged(bool expanded) {
    if (expanded==true){
      setState(() {
        leadingBackgroundColor = Colors.orange;
        leadingNumberColor = Colors.white;
      });
    } else {
      setState(() {
        leadingBackgroundColor = Colors.white;
        leadingNumberColor = Colors.black;
      });
    }
  }
  updateonPressed(int index) {
    Navigator.of(context)
        .push(MaterialPageRoute(
            builder: (context) => Newuser(
                  user: users[index],
                )))
        .then((user) {
      if (user != null) {
        http.makeUserPutRequest(user);
        setState(() {
          users.removeAt(index);
          users.add(user);
        });
      }
    });
  }

  alertonPressed(int index) {
    http.makeUserDeleteRequest(users[index]);
    setState(() {
      users.removeAt(index);
    });
    Navigator.of(context).pop();
  }

  deleteonPressed(BuildContext context, int index) {
    openActionDialog(
        context,
        'Alert',
        'Are you sure want to delete ${users[index].username} ?',
        'Delete',
        () => alertonPressed(index));
  }

  floatingonPressed() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => Newuser()))
        .then((user) {
      if (!isDefault(user as User)) {
        // New user
        if (user.id == -1) {
          user = asignid(users, user as User);
          http.makeUserPostRequest(user);
          setState(() {
            users.add(user);
          });
        } else {
          // Update user
          http.makeUserPutRequest(user);
          int index = users.indexWhere((item) => item.id == user.id);
          users.removeAt(index);
          users.insert(index, user);
        }
      }
    });
  }

  Widget _buildList(BuildContext context) {
    return ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          users.sort((a, b) => a.id.compareTo(b.id));
          return ExpansionTile(
            leading: CircleAvatar(
              radius: 20.0,
              backgroundColor: leadingBackgroundColor,
              child: Text('${users[index].id}',style: TextStyle(fontSize: 20.0, color: leadingNumberColor),),
            ),
            onExpansionChanged: (boo) => onExpansionChanged(boo),
            title: Text('${users[index].username}'),
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    raisedButton('Update',
                        onPressed: () => updateonPressed(index),
                        fontSize: 15.0),
                    raisedButton('Delete',
                        onPressed: () => deleteonPressed(context, index),
                        fontSize: 15.0),
                  ],
                ),
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    if (users.isEmpty) {
      setState(() {
        users = Provider.of<List<User>>(context);
      });
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Mysql + NodeJS Rest Api'),
        automaticallyImplyLeading: false,
      ),
      body: Center(
          child: Padding(
              padding: const EdgeInsets.all(8.0), child: _buildList(context))),
      floatingActionButton: FloatingActionButton(
        onPressed: floatingonPressed,
        child: Icon(Icons.add),
      ),
    );
  }
}
