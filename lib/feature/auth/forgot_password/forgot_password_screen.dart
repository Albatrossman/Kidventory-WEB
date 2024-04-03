import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kidventory_flutter/feature/auth/sign_in/sign_in_screen.dart';
import 'package:rounded_loading_button_plus/rounded_loading_button.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return _ForgotPasswordScreenContent();
  }
}

class _ForgotPasswordScreenContent extends StatelessWidget {
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
      appBar: kIsWeb ? null : const CupertinoNavigationBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Spacer(),
              const Padding(
                padding: EdgeInsets.only(bottom: 16.0),
                child: Icon(size: 64, CupertinoIcons.lock),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: SizedBox(
                  width: 350,
                  child: Text(
                    "Forgot Password?",
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(
                          color: Theme.of(context).colorScheme.onSurface,
                        )
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 32.0),
                child: SizedBox(
                  width: 350,
                  child: Text(
                    "Enter your email address and we will send you a code to reset your password.",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
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
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 32.0, bottom: 16.0),
                child: sendEmailButton(context),
              ),
              signInRow(context),
              const Spacer(),
              const Spacer(),
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

  Widget sendEmailButton(BuildContext context) {
    return RoundedLoadingButton(
      controller: _btnController,
      onPressed: _doSomething,
      elevation: 0,
      width: kIsWeb ? 350 : double.infinity,
      height: kIsWeb ? 56 : 40,
      loaderSize: 24,
      color: Theme.of(context).colorScheme.primary,
      child: Text(
        "Send Code",
        style: Theme.of(context)
            .textTheme
            .labelLarge
            ?.copyWith(color: Theme.of(context).colorScheme.onPrimary),
      ),
    );
  }

  Widget signInRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        Text(
          "Remember password?",
          style: Theme.of(context).textTheme.labelMedium?.copyWith(
                color: Theme.of(context).colorScheme.outline,
              ),
        ),
        CupertinoButton(
          child: Text("Sign In",
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                color: Theme.of(context).colorScheme.primary,
              ),
          ),
          onPressed: () => {
            Navigator.pop(context),
          }
        )
      ],
    );
  }
}