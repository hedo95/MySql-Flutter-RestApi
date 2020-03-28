import 'package:flutter/material.dart';
import 'package:frontend/Pages/newcustomer.dart';
import 'package:frontend/models/customer.dart';
import 'package:frontend/models/http.dart';
import 'package:frontend/BO/BO.dart';
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
  int index;

  @override
  initState() {
    super.initState();
  }

  updateonPressed(int index) {
    Navigator.of(context)
        .push(MaterialPageRoute(
            builder: (context) => Newcustomer(
                  customer: customers[index],
                )))
        .then((customer) {
      http.makeCustomerPutRequest(customer);
      setState(() {
        customers.removeAt(index);
        customers.add(customer);
      });
    });
  }

  alertonPressed(int index) {
    http.makeCustomerDeleteRequest(customers[index]);
    setState(() {
      customers.removeAt(index);
    });
    Navigator.of(context).pop();
  }

  deleteonPressed(BuildContext context, int index) {
    openActionDialog(context, 'Alert', 'Are you sure want to delete ${customers[index].username} ?', 
    'Delete', () => alertonPressed(index));
  }

  Widget _buildList(BuildContext context) {
    return ListView.builder(
        itemCount: customers.length,
        itemBuilder: (context, index) {
          customers.sort((a, b) => a.id.compareTo(b.id));
          return ExpansionTile(
            leading: CircleAvatar(
              radius: 20.0,
              child: Icon(Icons.contacts),
              backgroundColor: Colors.white,
            ),
            title: Text('${customers[index].username}'),
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    raisedButton('Update', onPressed: () => updateonPressed(index)),
                    raisedButton('Delete', onPressed: () => deleteonPressed(context,index)),
                  ],
                ),
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    if (customers.isEmpty) {
      setState(() {
        customers = Provider.of<List<Customer>>(context);
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
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => Newcustomer()))
              .then((customer) {
            if (!isDefault(customer as Customer)) {
              // New customer
              if (customer.id == -1) {
                customer = asignid(customers, customer as Customer);
                http.makeCustomerPostRequest(customer);
                setState(() {
                  customers.add(customer);
                });
              } else {
                // Update customer
                http.makeCustomerPutRequest(customer);
                int index =
                    customers.indexWhere((item) => item.id == customer.id);
                customers.removeAt(index);
                customers.insert(index, customer);
                print('${customers[index].hash.length}');
              }
            }
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
