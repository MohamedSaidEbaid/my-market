import 'package:flutter/material.dart';
import 'package:mymarket/constants.dart';
import 'package:mymarket/models/product.dart';
import 'package:mymarket/services/store.dart';
import 'package:mymarket/widgets/custom_textfield.dart';

class EditProduct extends StatelessWidget {
  static String id = 'EditProduct';
  String _name, _price, _category, _description, _imageLocation;
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  final _store = Store();
  @override
  Widget build(BuildContext context) {
    Product product = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Form(
          key: _globalKey,
          child: ListView(
            children: <Widget>[
              Column(
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
                        _store.editProduct(
                            ({
                              kProductName: _name,
                              kProductCategory: _category,
                              kProductDescription: _description,
                              kProductLocation: _imageLocation,
                              kProductPrice: _price,
                            }),
                            product.pId);
                      }
                    },
                    child: Text('Edit Product'),
                  )
                ],
              ),
            ],
          )),
    );
  }
}
