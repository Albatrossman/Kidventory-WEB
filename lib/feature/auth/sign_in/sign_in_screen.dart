import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rounded_loading_button_plus/rounded_loading_button.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return _SignInScreenContent();
  }
}

class _SignInScreenContent extends StatelessWidget {
  final RoundedLoadingButtonController _btnController =
      RoundedLoadingButtonController();

  void _doSomething() async {
    Timer(const Duration(seconds: 3), () {
      _btnController.success();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            const TextField(
              decoration: InputDecoration(
                label: Text("Email"),
              ),
            ),
            const TextField(
              decoration: InputDecoration(
                label: Text(
                  "Password",
                ),
              ),
            ),
            RoundedLoadingButton(
              controller: _btnController,
              onPressed: _doSomething,
              elevation: 0,
              child: Text(
                "Sign In",
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onPrimary
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
