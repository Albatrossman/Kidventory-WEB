import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kidventory_flutter/feature/auth/forgot_password/forgot_password_screen.dart';
import 'package:kidventory_flutter/feature/auth/sign_up/sign_up_screen.dart';
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
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Spacer(),
              Padding(
                padding: const EdgeInsets.only(bottom: 48.0),
                child: Image.asset(
                  "assets/images/logo.png",
                  width: 100,
                  height: 100,
                ),
              ),
              SizedBox(
                width: kIsWeb ? 420 : null,
                child: Column(
                  children: [
                    emailTextField, 
                    passwordTextField
                    ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 32.0, bottom: 16.0),
                child: signInButton(context),
              ),
              forgotPasswordButton(context),
              Spacer(),
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
        "Sign In",
        style: Theme.of(context)
            .textTheme
            .labelLarge
            ?.copyWith(color: Theme.of(context).colorScheme.onPrimary),
      ),
    );
  }

  Widget forgotPasswordButton(BuildContext context) {
    return CupertinoButton(
      child: Text(
        "Forgot Password?",
        style: Theme.of(context).textTheme.labelMedium?.copyWith(
              color: Theme.of(context).colorScheme.primary,
            ),
      ),
      onPressed: () => {
        Navigator.push(
          context,
          CupertinoPageRoute(
            builder: (context) => const ForgotPasswordScreen(),
          ),
        ),
      },
    );
  }

  Widget signUpRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        Text(
          "Don't have an account?",
          style: Theme.of(context).textTheme.labelMedium?.copyWith(
                color: Theme.of(context).colorScheme.outline,
              ),
        ),
        CupertinoButton(
          child: const Text("Sign Up"),
          onPressed: () => {
            Navigator.push(
              context,
               CupertinoPageRoute(builder: 
                (context) => const SignUpScreen())
               )
          },
        )
      ],
    );
  }
}
