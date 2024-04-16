import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:kidventory_flutter/core/ui/util/navigation_mixin.dart';
import 'package:kidventory_flutter/feature/auth/forgot_password/forgot_password_screen.dart';
import 'package:kidventory_flutter/feature/auth/sign_up/sign_up_screen.dart';
import 'package:kidventory_flutter/core/ui/util/message_mixin.dart';
import 'package:kidventory_flutter/feature/auth/sign_in/sign_in_screen_viewmodel.dart';
import 'package:kidventory_flutter/feature/main/main_screen.dart';
import 'package:provider/provider.dart';
import 'package:rounded_loading_button_plus/rounded_loading_button.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _SignInScreenState();
  }
}

class _SignInScreenState extends State<SignInScreen> with MessageMixin, NavigationMixin {
  late final SignInScreenViewModel _viewModel;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final RoundedLoadingButtonController _btnController = RoundedLoadingButtonController();

  @override
  void initState() {
    super.initState();
    _viewModel = Provider.of<SignInScreenViewModel>(context, listen: false);
    _viewModel.addListener(_listener);
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _viewModel.removeListener(_listener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Spacer(),
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
                        TextField(
                          controller: _emailController,
                          maxLines: 1,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(8.0),
                              ),
                            ),
                            label: Text("Email"),
                          ),
                          keyboardType: TextInputType.emailAddress,
                          textCapitalization: TextCapitalization.none,
                          autocorrect: false,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 16.0),
                          child: TextField(
                            controller: _passwordController,
                            maxLines: 1,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(8.0),
                                ),
                              ),
                              label: Text("Password"),
                            ),
                            keyboardType: TextInputType.visiblePassword,
                            textCapitalization: TextCapitalization.none,
                            obscureText: true,
                            enableSuggestions: false,
                            autocorrect: false,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 32.0, bottom: 16.0),
                    child: signInButton(context),
                  ),
                  forgotPasswordButton(context),
                  const Spacer(),
                  signUpRow(context)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget signInButton(BuildContext context) {
    return RoundedLoadingButton(
      controller: _btnController,
      onPressed: () => _onSignIn(context),
      elevation: 0,
      width: kIsWeb ? 350 : 600,
      height: kIsWeb ? 56 : 40,
      loaderSize: 24,
      color: Theme.of(context).colorScheme.primary,
      child: Text(
        "Sign In",
        style: Theme.of(context).textTheme.labelLarge?.copyWith(
              color: Theme.of(context).colorScheme.onPrimary,
            ),
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
              CupertinoPageRoute(
                builder: (context) => const SignUpScreen(),
              ),
            )
          },
        ),
      ],
    );
  }

  void _listener() {
    if (_viewModel.state.message != null) {
      // snackbar(_viewModel.state.message!);
    }
  }

  void _onSignIn(BuildContext context) async {
    _viewModel
        .signIn(_emailController.text, _passwordController.text)
        .whenComplete(() => _btnController.reset())
        .then((value) => pushAndClear(const MainScreen(), fullscreenDialog: true));
  }
}
