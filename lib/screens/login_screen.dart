import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:mymarket/constants.dart';
import 'package:mymarket/provider/admin_mode.dart';
import 'package:mymarket/provider/model_hud.dart';
import 'file:///E:/MyAndroidProjects/my_market/lib/screens/admin/admin_home.dart';
import 'file:///E:/MyAndroidProjects/my_market/lib/screens/user/home_page.dart';
import 'package:mymarket/screens/signup_screen.dart';
import 'package:mymarket/widgets/custom_textfield.dart';
import 'package:mymarket/widgets/logo_widget.dart';
import 'package:mymarket/services/auth.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  final adminPassword = 'Admin1234';
  static String id = 'LoginScreen';
  final _auth = Auth();
  bool isAdmin = false;

  String _email;
  String _password;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: kMainColor,
      body: ModalProgressHUD(
        inAsyncCall: Provider.of<ModelHud>(context).isLoading,
        child: Form(
          key: _globalKey,
          child: ListView(
            children: <Widget>[
              LogoWidget(),
              SizedBox(
                height: height * 0.1,
              ),
              CustomTextField(
                hint: 'Enter your Email',
                icon: Icons.email,
                onClick: (value) {
                  _email = value;
                },
              ),
              SizedBox(
                height: height * 0.02,
              ),
              CustomTextField(
                hint: 'Enter your Password',
                icon: Icons.lock,
                onClick: (value) {
                  _password = value;
                },
              ),
              SizedBox(
                height: height * 0.05,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 120.0),
                child: Builder(
                  builder: (context) => FlatButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    onPressed: () async {
                      _validate(context);
                    },
                    color: Colors.black,
                    child: Text(
                      'Login',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: height * 0.05,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Don\'t have an account?',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, SignupScreen.id);
                    },
                    child: Text(
                      'Sign up',
                      style: TextStyle(color: Colors.black, fontSize: 16),
                    ),
                  )
                ],
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Provider.of<AdminMode>(context, listen: false)
                            .changeIsAdmin(true);
                      },
                      child: Text(
                        'I\'m an admin',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Provider.of<AdminMode>(context).isAdmin
                              ? kMainColor
                              : Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Provider.of<AdminMode>(context, listen: false)
                            .changeIsAdmin(false);
                      },
                      child: Text(
                        'I\'m a user',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Provider.of<AdminMode>(context).isAdmin
                              ? Colors.white
                              : kMainColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _validate(BuildContext context) async {
    final modelHud = Provider.of<ModelHud>(context, listen: false);
    modelHud.changingIsLoading(true);
    if (_globalKey.currentState.validate()) {
      _globalKey.currentState.save();
      if (Provider.of<AdminMode>(context, listen: false).isAdmin) {
        if (_password == adminPassword) {
          try {
            final authResult =
                await _auth.signIn(_email.trim(), _password.trim());
            modelHud.changingIsLoading(false);
            Navigator.pushNamed(context, AdminHome.id);
          } on PlatformException catch (e) {
            modelHud.changingIsLoading(false);
            Scaffold.of(context).showSnackBar(
              SnackBar(
                content: Text(e.message),
              ),
            );
            print(e.toString());
          }
        } else {
          Scaffold.of(context).showSnackBar(SnackBar(
            content: Text('Something went wrong !'),
          ));
        }
      } else {
        try {
          final authResult = await _auth.signIn(_email, _password);
          modelHud.changingIsLoading(false);
          Navigator.pushNamed(context, HomePage.id);
        } on PlatformException catch (e) {
          modelHud.changingIsLoading(false);
          Scaffold.of(context).showSnackBar(
            SnackBar(
              content: Text(e.message),
            ),
          );
          print(e.toString());
        }
      }
    }
    modelHud.changingIsLoading(false);
  }
}
