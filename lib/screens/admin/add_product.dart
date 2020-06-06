import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mymarket/constants.dart';
import 'package:mymarket/models/product.dart';
import 'package:mymarket/services/store.dart';
import 'package:mymarket/widgets/custom_textfield.dart';

class AddProduct extends StatelessWidget {
  static String id = 'addProduct';
  String _name, _price, _category, _description, _imageLocation;
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  final _store = Store();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _globalKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 10,
            ),
            CustomTextField(
              hint: 'Product Name',
              onClick: (value) {
                _name = value;
              },
            ),
            SizedBox(
              height: 10,
            ),
            CustomTextField(
              hint: 'Product Price',
              onClick: (value) {
                _price = value;
              },
            ),
            SizedBox(
              height: 10,
            ),
            CustomTextField(
              hint: 'Product Description',
              onClick: (value) {
                _description = value;
              },
            ),
            SizedBox(
              height: 10,
            ),
            CustomTextField(
              hint: 'Product Category',
              onClick: (value) {
                _category = value;
              },
            ),
            SizedBox(
              height: 10,
            ),
            CustomTextField(
              hint: 'Product Location',
              onClick: (value) {
                _imageLocation = value;
              },
            ),
            SizedBox(
              height: 20,
            ),
            RaisedButton(
              color: kMainColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              onPressed: () {
                if (_globalKey.currentState.validate()) {
                  _globalKey.currentState.save();
                  _store.addProduct(Product(
                    pName: _name,
                    pCategory: _category,
                    pDescription: _description,
                    pLocation: _imageLocation,
                    pPrice: _price,
                  ));
                }
              },
              child: Text('Add Product'),
            )
          ],
        ),
      ),
    );
  }
}
