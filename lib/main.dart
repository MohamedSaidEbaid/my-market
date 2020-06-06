import 'package:flutter/material.dart';
import 'package:mymarket/provider/admin_mode.dart';
import 'package:mymarket/provider/cart_item.dart';
import 'package:mymarket/provider/model_hud.dart';
import 'package:mymarket/screens/admin/add_product.dart';
import 'package:mymarket/screens/admin/admin_home.dart';
import 'package:mymarket/screens/admin/edit_product.dart';
import 'package:mymarket/screens/admin/manage_product.dart';
import 'file:///E:/MyAndroidProjects/my_market/lib/screens/user/home_page.dart';
import 'package:mymarket/screens/login_screen.dart';
import 'package:mymarket/screens/signup_screen.dart';
import 'package:mymarket/screens/user/cart_screen.dart';
import 'package:mymarket/screens/user/product_info.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ModelHud>(
          create: (context) => ModelHud(),
        ),
        ChangeNotifierProvider<AdminMode>(
          create: (context) => AdminMode(),
        ),
        ChangeNotifierProvider<CartItem>(
          create: (context) => CartItem(),
        )
      ],
      child: MaterialApp(
        initialRoute: LoginScreen.id,
        routes: {
          LoginScreen.id: (context) => LoginScreen(),
          SignupScreen.id: (context) => SignupScreen(),
          HomePage.id: (context) => HomePage(),
          AdminHome.id: (context) => AdminHome(),
          AddProduct.id: (context) => AddProduct(),
          ManageProduct.id: (context) => ManageProduct(),
          EditProduct.id: (context) => EditProduct(),
          ProductInfo.id: (context) => ProductInfo(),
          CartScreen.id: (context) => CartScreen(),
        },
      ),
    );
  }
}
