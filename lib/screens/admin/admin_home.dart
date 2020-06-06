import 'package:flutter/material.dart';
import 'package:mymarket/constants.dart';
import 'package:mymarket/screens/admin/add_product.dart';
import 'package:mymarket/screens/admin/manage_product.dart';

class AdminHome extends StatelessWidget {
  static String id = 'adminHome';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kMainColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            width: double.infinity,
          ),
          RaisedButton(
            color: kSecondaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            onPressed: () {
              Navigator.pushNamed(context, AddProduct.id);
            },
            child: Text('Add Product'),
          ),
          RaisedButton(
            color: kSecondaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            onPressed: () {
              Navigator.pushNamed(context, ManageProduct.id);
            },
            child: Text('Edit Product'),
          ),
          RaisedButton(
            color: kSecondaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            onPressed: () {},
            child: Text('View Orders'),
          )
        ],
      ),
    );
  }
}
