import 'package:flutter/material.dart';
import 'package:mymarket/constants.dart';
import 'package:mymarket/provider/model_hud.dart';
import 'file:///E:/MyAndroidProjects/my_market/lib/screens/user/home_page.dart';
import 'package:mymarket/screens/login_screen.dart';
import 'package:mymarket/widgets/custom_textfield.dart';
import 'package:mymarket/widgets/logo_widget.dart';
import 'package:mymarket/services/auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';

class SignupScreen extends StatelessWidget {
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  static String id = 'signupScreen';
  String _email;
  String _name;
  String _password;
  final _auth = Auth();

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
                hint: 'Enter your Name',
                icon: Icons.perm_identity,
                onClick: (value) {
                  _name = value;
                },
              ),
              SizedBox(
                height: height * 0.02,
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
                      final modelHud =
                          Provider.of<ModelHud>(context, listen: false);
                      modelHud.changingIsLoading(true);
                      if (_globalKey.currentState.validate()) {
                        try {
                          _globalKey.currentState.save();
                          final authResult = await _auth.signUp(
                              _email.trim(), _password.trim());
                          modelHud.changingIsLoading(false);
                          Navigator.pushNamed(context, HomePage.id);
                        } catch (e) {
                          print(e.toString());
                          modelHud.changingIsLoading(false);
                          Scaffold.of(context).showSnackBar(SnackBar(
                            content: Text(e.message),
                          ));
                        }
                      }
                      modelHud.changingIsLoading(false);
                    },
                    color: Colors.black,
                    child: Text(
                      'Sign up',
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
                    'Have an account?',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, LoginScreen.id);
                    },
                    child: Text(
                      'Login',
                      style: TextStyle(color: Colors.black, fontSize: 16),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
