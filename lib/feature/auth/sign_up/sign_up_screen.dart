import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kidventory_flutter/feature/auth/sign_in/sign_in_screen.dart';
import 'package:rounded_loading_button_plus/rounded_loading_button.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return _SignUpScreenContent();
  }
}

class _SignUpScreenContent extends StatelessWidget {
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
      appBar: kIsWeb
          ? null
          : const CupertinoNavigationBar(
              middle: Text("Sign Up"),
            ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(bottom: 24.0),
                child: Image.asset(
                  "assets/images/logo.png",
                  width: 80,
                  height: 80,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 32.0),
                child: Text(
                  "Join milions in making child education \n Safer, Easier, and Better.",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                ),
              ),
              SizedBox(
                width: kIsWeb ? 420 : null,
                height: null,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    emailTextField,
                    firstNameTextField,
                    lastNameTextField,
                    passwordTextField
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 32.0, bottom: 16.0),
                child: signInButton(context),
              ),
              const Spacer(),
              signUpRow(context)
            ],
          ),
        ),
      ),
    );
  }

  final Widget emailTextField = const TextField(
    maxLines: 1,
    decoration: InputDecoration(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(8.0),
        ),
      ),
      label: Text("Email"),
    ),
  );

  final Widget firstNameTextField = const Padding(
    padding: EdgeInsets.only(top: 16.0),
    child: TextField(
      maxLines: 1,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(8.0),
          ),
        ),
        label: Text(
          "First Name",
        ),
      ),
      obscureText: true,
      enableSuggestions: false,
      autocorrect: false,
    ),
  );

  final Widget lastNameTextField = const Padding(
    padding: EdgeInsets.only(top: 16.0),
    child: TextField(
      maxLines: 1,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(8.0),
          ),
        ),
        label: Text(
          "Last Name",
        ),
      ),
      obscureText: true,
      enableSuggestions: false,
      autocorrect: false,
    ),
  );

  final Widget passwordTextField = const Padding(
    padding: EdgeInsets.only(top: 16.0),
    child: TextField(
      maxLines: 1,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(8.0),
          ),
        ),
        label: Text(
          "Password",
        ),
      ),
      obscureText: true,
      enableSuggestions: false,
      autocorrect: false,
    ),
  );

  Widget signInButton(BuildContext context) {
    return RoundedLoadingButton(
      controller: _btnController,
      onPressed: _doSomething,
      elevation: 0,
      width: kIsWeb ? 350 : 600,
      height: kIsWeb ? 56 : 40,
      loaderSize: 24,
      color: Theme.of(context).colorScheme.primary,
      child: Text(
        "Continue",
        style: Theme.of(context)
            .textTheme
            .labelLarge
            ?.copyWith(color: Theme.of(context).colorScheme.onPrimary),
      ),
    );
  }

  Widget signUpRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        Text(
          "Have an account?",
          style: Theme.of(context).textTheme.labelMedium?.copyWith(
                color: Theme.of(context).colorScheme.outline,
              ),
        ),
        CupertinoButton(
          child: const Text("Sign In"),
          onPressed: () => {Navigator.pop(context)},
        )
      ],
    );
  }
}
