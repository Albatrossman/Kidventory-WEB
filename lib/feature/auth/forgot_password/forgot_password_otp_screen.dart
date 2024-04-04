import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kidventory_flutter/feature/auth/sign_in/sign_in_screen.dart';
import 'package:otp_text_field/style.dart';
import 'package:rounded_loading_button_plus/rounded_loading_button.dart';
import 'package:otp_text_field/otp_text_field.dart';

class ForgotPasswordOTPScreen extends StatelessWidget {
  const ForgotPasswordOTPScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return _ForgotPasswordOTPScreenContent();
  }
}

class _ForgotPasswordOTPScreenContent extends StatelessWidget {
  final RoundedLoadingButtonController _btnController =
      RoundedLoadingButtonController();
  final OtpFieldController _otpController = OtpFieldController();

  void _verifyCode() async {
    Timer(const Duration(seconds: 3), () {
      print(_otpController.toString());
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
                child: Icon(size: 64, CupertinoIcons.mail),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: SizedBox(
                  width: 350,
                  child: Text(
                    "Enter Verification Code",
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
                    "We sent a code to your email address \nThis code will expire in 3 minutes.",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                  ),
                ),
              ),
              SizedBox(
                width: kIsWeb ? 350 : null,
                height: null,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    verifyCodeField(context),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 32.0, bottom: 16.0),
                child: verifyCodeButton(context),
              ),
              resendCodeButton(context),
              const Spacer(),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }

  Widget verifyCodeField(BuildContext context) {
    return OTPTextField(
      controller: _otpController,
      length: 4,
      fieldWidth: 48,
      style: const TextStyle(fontSize: 14),
      textFieldAlignment: MainAxisAlignment.spaceAround,
      fieldStyle: FieldStyle.box,
      outlineBorderRadius: 8,
      width: MediaQuery.of(context).size.width,
      onChanged: (value) {
        //
      },
      onCompleted: (pin) {
        _btnController.start();
        _verifyCode();
      },
    );
  }

  Widget verifyCodeButton(BuildContext context) {
    return RoundedLoadingButton(
      controller: _btnController,
      onPressed: _verifyCode,
      elevation: 0,
      width: kIsWeb ? 350 : 600,
      height: kIsWeb ? 56 : 40,
      loaderSize: 24,
      color: Theme.of(context).colorScheme.primary,
      child: Text(
        "Verify Code",
        style: Theme.of(context)
            .textTheme
            .labelLarge
            ?.copyWith(color: Theme.of(context).colorScheme.onPrimary),
      ),
    );
  }

  Widget resendCodeButton(BuildContext context) {
    return CupertinoButton(
        child: Text(
          "Resend Code",
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                color: Theme.of(context).colorScheme.primary,
              ),
        ),
        onPressed: () => {
              Navigator.pop(context),
            });
  }
}
