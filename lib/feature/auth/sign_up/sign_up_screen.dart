import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:kidventory_flutter/core/ui/util/extension/string_extension.dart';
import 'package:kidventory_flutter/core/ui/util/mixin/message_mixin.dart';
import 'package:kidventory_flutter/core/ui/util/mixin/navigation_mixin.dart';
import 'package:kidventory_flutter/feature/auth/sign_up/sign_up_screen_viewmodel.dart';
import 'package:kidventory_flutter/feature/main/main_screen.dart';
import 'package:provider/provider.dart';
import 'package:rounded_loading_button_plus/rounded_loading_button.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({
    super.key,
  });

  @override
  State<StatefulWidget> createState() {
    return _SignUpScreenContent();
  }
}

class _SignUpScreenContent extends State<SignUpScreen>
    with MessageMixin, NavigationMixin {
  late final SignUpScreenViewModel _viewModel;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _firstnameController = TextEditingController();
  final TextEditingController _lastnameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final RoundedLoadingButtonController _btnController =
      RoundedLoadingButtonController();

  bool isValidEmail = true;
  bool passwordStrong = true;

  @override
  void initState() {
    super.initState();
    _viewModel = Provider.of<SignUpScreenViewModel>(context, listen: false);
    _viewModel.addListener(_listener);
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
        child: Center(
          child: SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
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
                            color:
                                Theme.of(context).colorScheme.onSurfaceVariant,
                          ),
                    ),
                  ),
                  SizedBox(
                    width: kIsWeb ? 420 : null,
                    height: null,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        TextField(
                          controller: _emailController,
                          maxLines: 1,
                          decoration: InputDecoration(
                            errorText: isValidEmail
                                ? null
                                : "Email address is invalid",
                            border: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(8.0),
                              ),
                            ),
                            label: const Text("Email"),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 16.0),
                          child: TextField(
                            controller: _firstnameController,
                            maxLines: 1,
                            decoration: const InputDecoration(
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
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 16.0),
                          child: TextField(
                            controller: _lastnameController,
                            maxLines: 1,
                            decoration: const InputDecoration(
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
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 16.0),
                          child: TextField(
                            controller: _passwordController,
                            maxLines: 1,
                            decoration: InputDecoration(
                              errorText: passwordStrong
                                ? null
                                : "Password must contain at least one special character, one number, one capital letter and be at least one 6 characters long",
                              border: const OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(8.0),
                                ),
                              ),
                              label: const Text(
                                "Password",
                              ),
                            ),
                            obscureText: true,
                            enableSuggestions: false,
                            autocorrect: false,
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 32.0, bottom: 16.0),
                    child: signUpButton(context),
                  ),
                  signUpRow(context)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget signUpButton(BuildContext context) {
    return RoundedLoadingButton(
      controller: _btnController,
      onPressed: _onSignUp,
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

  void _listener() {
    if (_viewModel.state.message != null) {
      snackbar(_viewModel.state.message!);
    }
  }

  void _onSignUp() async {
    setState(() {
      isValidEmail = _emailController.text.isValidEmail();
      passwordStrong = _passwordController.text.isStrongForPassowrd();
    });

    if (isValidEmail && passwordStrong) {
      _viewModel
          .signUp(
            _emailController.text,
            _firstnameController.text,
            _lastnameController.text,
            _passwordController.text,
          )
          .whenComplete(() => _btnController.reset())
          .then(
            (value) => {
              _viewModel
                  .signIn(_emailController.text, _passwordController.text)
                  .whenComplete(() => _btnController.reset())
                  .then(
                    (value) => pushAndClear(const MainScreen(),
                        fullscreenDialog: true),
                    onError: (error) => {
                      snackbar(error.toString()),
                    },
                  )
            },
            onError: (error) => {
              snackbar(error.toString()),
            },
          );
    } else {
      _btnController.reset();
      if (!isValidEmail) {
        snackbar("Email is not valid");
      } else if (!passwordStrong) {
        snackbar("Password is not strong enough.");
      }
    }
  }
}
