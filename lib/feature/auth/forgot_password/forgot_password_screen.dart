import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:kidventory_flutter/core/ui/component/button.dart';
import 'package:kidventory_flutter/core/ui/util/extension/string_extension.dart';
import 'package:kidventory_flutter/core/ui/util/mixin/message_mixin.dart';
import 'package:kidventory_flutter/core/ui/util/mixin/navigation_mixin.dart';
import 'package:kidventory_flutter/feature/auth/forgot_password/forgot_password_screen_viewmodel.dart';
import 'package:kidventory_flutter/feature/main/main_screen.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:provider/provider.dart';
import 'package:rounded_loading_button_plus/rounded_loading_button.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({
    super.key,
  });

  @override
  State<StatefulWidget> createState() {
    return _ForgotPasswordScreenState();
  }
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen>
    with MessageMixin, NavigationMixin {
  final RoundedLoadingButtonController _btnController =
      RoundedLoadingButtonController();
  final RoundedLoadingButtonController _otpCheckbtnController =
      RoundedLoadingButtonController();
  final RoundedLoadingButtonController _changePassowrdBtnController =
      RoundedLoadingButtonController();

  final OtpFieldController _otpController = OtpFieldController();
  late final ForgotPasswordScreenViewModel _viewModel;

  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  final TextEditingController _emailController = TextEditingController();
  final PageController _pageViewController = PageController();

  bool isValidEmail = true;
  bool passwordsMatch = true;

  @override
  void initState() {
    super.initState();
    _viewModel =
        Provider.of<ForgotPasswordScreenViewModel>(context, listen: false);
    _viewModel.addListener(_listener);
  }

  @override
  void dispose() {
    _emailController.dispose();
    _viewModel.removeListener(_listener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: kIsWeb ? null : const CupertinoNavigationBar(),
      body: SafeArea(
        child: PageView(
          controller: _pageViewController,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            sendEmailPage(context),
            verifyOTPPage(context),
            changePasswordPage(context),
            const Expanded(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget sendEmailPage(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
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
                    emailTextField(context),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 32.0, bottom: 16.0),
                child: sendEmailButton(context),
              ),
              signInRow(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget verifyOTPPage(BuildContext context) {
    return Center(
        child: SingleChildScrollView(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
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
          ],
        ),
      ),
    ));
  }

  Widget changePasswordPage(BuildContext context) {
    return Center(
      heightFactor: kIsWeb ? null : 1.0,
      child: SingleChildScrollView(
        clipBehavior: Clip.none,
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              SizedBox(
                width: kIsWeb ? 420 : null,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: newPasswordField(context),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: confirmNewPasswordField(context),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 32.0, bottom: kIsWeb ? 72.0 : 0.0),
                child: savePasswordButton(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget emailTextField(BuildContext context) {
    return TextField(
      controller: _emailController,
      maxLines: 1,
      decoration: InputDecoration(
        errorText: isValidEmail ? null : "Email address is invalid",
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(8.0),
          ),
        ),
        label: const Text("Email"),
      ),
    );
  }

  Widget sendEmailButton(BuildContext context) {
    return RoundedLoadingButton(
      controller: _btnController,
      onPressed: () => {_sendEmail(context)},
      elevation: 0,
      width: kIsWeb ? 350 : 600,
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
          child: Text(
            "Sign In",
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                ),
          ),
          onPressed: () => {
            Navigator.pop(context),
          },
        ),
      ],
    );
  }

  Widget verifyCodeField(BuildContext context) {
    return OTPTextField(
      controller: _otpController,
      length: 5,
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
        () => {_validateOTP(context)};
      },
    );
  }

  Widget verifyCodeButton(BuildContext context) {
    return RoundedLoadingButton(
      controller: _otpCheckbtnController,
      onPressed: () => {_validateOTP(context)},
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
      },
    );
  }

  Widget newPasswordField(BuildContext context) {
    return TextField(
      controller: _passwordController,
      maxLines: 1,
      decoration: InputDecoration(
        errorText: passwordsMatch ? null : "",
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(8.0),
          ),
        ),
        label: const Text("New Password"),
      ),
      keyboardType: TextInputType.visiblePassword,
      textCapitalization: TextCapitalization.none,
      obscureText: true,
      enableSuggestions: false,
      autocorrect: false,
    );
  }

  Widget confirmNewPasswordField(BuildContext context) {
    return TextField(
      controller: _confirmPasswordController,
      maxLines: 1,
      decoration: InputDecoration(
        errorText: passwordsMatch ? null : "",
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(8.0),
          ),
        ),
        label: const Text("Confirm New Password"),
      ),
      keyboardType: TextInputType.visiblePassword,
      textCapitalization: TextCapitalization.none,
      obscureText: true,
      enableSuggestions: false,
      autocorrect: false,
    );
  }

  Widget savePasswordButton(BuildContext context) {
    return AppButton(
      controller: _changePassowrdBtnController,
      onPressed: () => {_changePassword(context)},
      child: Text(
        'Save',
        style: Theme.of(context).textTheme.labelLarge?.copyWith(
              color: Theme.of(context).colorScheme.onPrimary,
            ),
      ),
    );
  }

  void _listener() {
    if (_viewModel.state.message != null) {
      // snackbar(_viewModel.state.message!);
    }
  }

  void _sendEmail(BuildContext context) async {
    setState(() {
      isValidEmail = _emailController.text.isValidEmail();
    });
    if (isValidEmail) {
      _viewModel
          .sendOTP(_emailController.text)
          .whenComplete(() => _btnController.reset())
          .then(
            (value) => _pageViewController.animateToPage(1,
                duration: const Duration(milliseconds: 400),
                curve: Curves.easeInOut),
            onError: (error) => {
              snackbar(error.toString()),
            },
          );
    } else {
      _btnController.reset();
      snackbar("Email is not valid");
    }
  }

  void _validateOTP(BuildContext context) async {
    _viewModel
        .verifyOTP(_emailController.text, _otpController.toString())
        .whenComplete(() => _otpCheckbtnController.reset())
        .then(
          (value) => _pageViewController.animateToPage(2,
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeInOut),
          onError: (error) => {
            snackbar("OTP not correct or has expired"),
          },
        );
  }

  void _changePassword(BuildContext context) async {
    setState(() {
      passwordsMatch =
          _passwordController.text == _confirmPasswordController.text;
    });
    if (passwordsMatch) {
      _viewModel
          .resetPassword(_emailController.text, _otpController.toString(),
              _passwordController.text)
          .whenComplete(() => _changePassowrdBtnController.reset())
          .then(
            (value) => {
              _pageViewController.animateToPage(3,
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeInOut),
              _viewModel
                  .signIn(_emailController.text, _passwordController.text)
                  .whenComplete(() => _changePassowrdBtnController.reset())
                  .then(
                    (value) => pushAndClear(const MainScreen(),
                        fullscreenDialog: true),
                    onError: (error) => {
                      snackbar(error.toString()),
                    },
                  ),
            },
            onError: (error) => {
              snackbar(error.toString()),
            },
          );
    } else {
      _changePassowrdBtnController.reset();
      snackbar("Passwords do not match");
    }
  }
}
