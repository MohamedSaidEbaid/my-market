import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mymarket/constants.dart';
import 'package:mymarket/models/order.dart';
import 'package:mymarket/services/store.dart';

class OrdersScreen extends StatelessWidget {
  static String id = 'ordersScreen';
  Store _store = Store();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: _store.loadOrders(),
        builder: (Query, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: Text('There is no orders'));
          } else {
            List<Order> orders;
            for (var doc in snapshot.data.documents) {
              orders.add(Order(
                totalPrice: doc.data[kTotalPrice],
                address: doc.data[kAddress],
              ));
            }
            return ListView.builder(
              itemBuilder: (context, index) => Text(
                orders[index].totalPrice.toString(),
              ),
              itemCount: orders.length,
            );
          }
        },
      ),
    );
  }
}
