import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mymarket/constants.dart';
import 'package:mymarket/models/product.dart';
import 'package:mymarket/provider/cart_item.dart';
import 'package:mymarket/screens/user/product_info.dart';
import 'package:mymarket/services/store.dart';
import 'package:mymarket/widgets/my_popup_menu_item.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  static String id = 'cartScreen';
  @override
  Widget build(BuildContext context) {
    List<Product> products = Provider.of<CartItem>(context).products;
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    final appBarHeight = AppBar().preferredSize.height;
    final statusBarHeight = MediaQuery.of(context).padding.top;
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
          ),
          title: Text(
            'My Cart',
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: Column(
          children: <Widget>[
            LayoutBuilder(builder: (context, constrains) {
              if (products.isNotEmpty) {
                return Container(
                  height: screenHeight -
                      (screenHeight * 0.08) -
                      appBarHeight -
                      statusBarHeight,
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.all(15),
                        child: GestureDetector(
                          onTapUp: (details) {
                            showCustomMenu(details, context, products[index]);
                          },
                          child: Container(
                            height: screenHeight * 0.1,
                            color: kSecondaryColor,
                            child: Row(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: CircleAvatar(
                                    radius: screenHeight * .15 / 2,
                                    backgroundImage:
                                        AssetImage(products[index].pLocation),
                                  ),
                                ),
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Padding(
                                        padding: EdgeInsets.only(left: 10),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Text(
                                              products[index].pName,
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              '\$ ${products[index].pPrice}',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            )
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 20.0),
                                        child: Text(
                                          products[index].pQuantity.toString(),
                                          style: TextStyle(
                                            fontSize: 16,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                    itemCount: products.length,
                  ),
                );
              } else {
                return Container(
                  height: screenHeight -
                      (screenHeight * 0.08) -
                      appBarHeight -
                      statusBarHeight,
                  child: Center(
                    child: Text(
                      'Cart is Empty',
                      style: TextStyle(),
                    ),
                  ),
                );
              }
            }),
            Builder(
              builder: (context) => ButtonTheme(
                minWidth: screenWidth,
                height: screenHeight * 0.08,
                child: RaisedButton(
                  color: kMainColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  onPressed: () {
                    showCustomDialog(products, context);
                  },
                  child: Text(
                    'Order'.toUpperCase(),
                  ),
                ),
              ),
            )
          ],
        ));
  }

  void showCustomMenu(details, context, product) {
    double dx = details.globalPosition.dx;
    double dy = details.globalPosition.dy;
    double dx2 = MediaQuery.of(context).size.width - dx;
    double dy2 = MediaQuery.of(context).size.width - dy;
    showMenu(
        context: context,
        position: RelativeRect.fromLTRB(dx, dy, dx2, dy2),
        items: [
          MyPopupMenuItem(
            child: Text('Edit'),
            onClick: () {
              Navigator.pop(context);
              Provider.of<CartItem>(context, listen: false)
                  .deleteProduct(product);
              Navigator.pushNamed(context, ProductInfo.id, arguments: product);
            },
          ),
          MyPopupMenuItem(
            child: Text('Delete'),
            onClick: () {
              Navigator.pop(context);
              Provider.of<CartItem>(context, listen: false)
                  .deleteProduct(product);
            },
          )
        ]);
  }

  void showCustomDialog(List<Product> products, context) async {
    var price = getTotalPrice(products);
    var address;
    AlertDialog alertDialog = AlertDialog(
      title: Text('Total Price = \$ $price'),
      content: TextField(
        onChanged: (value) {
          address = value;
        },
        decoration: InputDecoration(hintText: ('Enter your Email')),
      ),
      actions: <Widget>[
        MaterialButton(
          child: Text('Confirm'),
          onPressed: () {
            try {
              Store _store = Store();
              _store.storeOrder({
                kTotalPrice: price,
                kAddress: address,
              }, products);
              Scaffold.of(context).showSnackBar(
                SnackBar(
                  content: Text('Ordered Successfully'),
                ),
              );
              Navigator.pop(context);
            } catch (ex) {
              print(ex.message);
            }
          },
        ),
      ],
    );
    await showDialog(
        context: context,
        builder: (context) {
          return alertDialog;
        });
  }

  getTotalPrice(List<Product> products) {
    var price = 0;
    for (var product in products) {
      price += product.pQuantity * int.parse(product.pPrice);
    }
    return price;
  }
}
