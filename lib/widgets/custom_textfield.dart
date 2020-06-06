import 'package:flutter/material.dart';
import 'package:mymarket/constants.dart';

class CustomTextField extends StatelessWidget {
  final String hint;
  final IconData icon;
  final Function onClick;

  String _errorMessage() {
    switch (hint) {
      case 'Enter your Name':
        return 'Name is empty';
      case 'Enter your Email':
        return 'Email is empty';
      case 'Enter your Password':
        return 'Password is empty';
    }
  }

  CustomTextField(
      {@required this.onClick, @required this.hint, @required this.icon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: TextFormField(
        validator: (value) {
          // ignore: missing_return
          if (value.isEmpty) return _errorMessage();
        },
        onSaved: onClick,
        obscureText: hint == 'Enter your Password' ? true : false,
        cursorColor: kMainColor,
        decoration: InputDecoration(
          hintText: hint,
          prefixIcon: Icon(
            icon,
            color: kMainColor,
          ),
          filled: true,
          fillColor: kSecondaryColor,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
            borderSide: BorderSide(
              color: Colors.white,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
            borderSide: BorderSide(
              color: Colors.white,
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
            borderSide: BorderSide(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
