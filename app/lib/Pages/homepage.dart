import 'package:flutter/material.dart';
import 'package:frontend/Pages/newcustomer.dart';
import 'package:frontend/models/customer.dart';
import 'package:frontend/models/http.dart';
import 'dart:async';
import 'dart:convert';
import 'package:provider/provider.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage();
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Customer> customers = [];
  Http http = new Http();

  @override
  initState() {
    super.initState();
  }

  Widget _buildList(BuildContext context) {
    customers = Provider.of<List<Customer>>(context);
    return ListView.builder(
        itemCount: customers.length,
        itemBuilder: (BuildContext context, index) {
          return ExpansionTile(
            leading: CircleAvatar(
              radius: 20.0,
              child: Icon(Icons.contacts),
              backgroundColor: Colors.white,
            ),
            title:
                Text('${customers[index].name} ${customers[index].lastname}'),
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    InkWell(
                      child: RaisedButton(
                        child: Text('Update'),
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => Newcustomer(
                                    customer: customers[index],
                                  ))).then((customer) {
                                    http.makeCustomerPutRequest(customer);
                                    setState(() {
                                      customers.removeAt(index);
                                      customers.insert(index, customer);
                                    });
                                  });
                        },
                      ),
                    ),
                    InkWell(
                      child: RaisedButton(
                        child: Text('Delete'),
                        onPressed: () {
                          http.makeCustomerDeleteRequest(customers[index]);
                          setState(() {
                            customers.removeAt(index);
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mysql + NodeJS Rest Api'),
        automaticallyImplyLeading: false,
      ),
      body: Center(
          child: Padding(
              padding: const EdgeInsets.all(8.0), child: _buildList(context))),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => Newcustomer()))
              .then((customer) {
            if (customer != null) {
              if (customer.id == null) {
                int id = customers[customers.length - 1].id + 1;
                http.makeCustomerPostRequest(customer);
                customer.id = id;
                setState(() {
                  customers.add(customer);
                });
              } else {
                http.makeCustomerPutRequest(customer);
                int index =
                    customers.indexWhere((item) => item.id == customer.id);
                customers.removeAt(index);
                customers.insert(index, customer);
                print('${customers[index].password.length}');
              }
            }
          });
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
