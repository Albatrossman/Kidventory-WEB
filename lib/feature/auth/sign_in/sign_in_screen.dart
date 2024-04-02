import 'package:flutter/material.dart';

class SignInScreen extends StatelessWidget {

  const SignInScreen({Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _SignInScreenContent();
  }
}

class _SignInScreenContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TextField(
          decoration: InputDecoration(
            label: Text("Email"),

          ),
        )
      ],
    );
  }
}
