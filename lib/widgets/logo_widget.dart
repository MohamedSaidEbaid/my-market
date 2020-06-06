import 'package:flutter/material.dart';

class LogoWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 50.0),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.2,
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Image(
              image: AssetImage('images/icons/logo.jpg'),
            ),
            Positioned(
              bottom: 0,
              child: Text(
                'My Market',
                style: TextStyle(fontFamily: 'Pacifico', fontSize: 25.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
