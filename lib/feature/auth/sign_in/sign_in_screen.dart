import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:kidventory_flutter/core/data/service/http/auth_api_service.dart';
import 'package:kidventory_flutter/core/data/service/http/user_api_service.dart';
import 'package:kidventory_flutter/core/data/service/preferences/token_preferences_manager.dart';
import 'package:kidventory_flutter/core/ui/util/extension/string_extension.dart';
import 'package:kidventory_flutter/core/ui/util/mixin/navigation_mixin.dart';
import 'package:kidventory_flutter/di/app_module.dart';
import 'package:kidventory_flutter/feature/auth/forgot_password/forgot_password_screen.dart';
import 'package:kidventory_flutter/feature/auth/sign_up/sign_up_screen.dart';
import 'package:kidventory_flutter/core/ui/util/mixin/message_mixin.dart';
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

class _SignInScreenState extends State<SignInScreen>
    with MessageMixin, NavigationMixin {
  late final SignInScreenViewModel _viewModel;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final RoundedLoadingButtonController _btnController =
      RoundedLoadingButtonController();

  bool isValidEmail = true;

  @override
  void initState() {
    super.initState();
    _viewModel = SignInScreenViewModel(
        getIt<AuthApiService>(), getIt<TokenPreferencesManager>());
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
    return ChangeNotifierProvider<SignInScreenViewModel>.value(
      value: _viewModel,
      child: Scaffold(
        resizeToAvoidBottomInset: true,
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
                    signUpRow(context)
                  ],
                ),
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
            fontWeight: FontWeight.w600),
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
          child: Text(
            "Sign Up",
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.bold),
          ),
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
    setState(() {
      isValidEmail = _emailController.text.isValidEmail();
    });
    if (isValidEmail) {
      _viewModel
          .signIn(_emailController.text, _passwordController.text)
          .whenComplete(() => _btnController.reset())
          .then(
            (value) => pushAndClear(const MainScreen(), fullscreenDialog: true),
            onError: (error) => {
              snackbar((error as DioException).message ?? "Something went wrong"),
            },
          );
    } else {
      _btnController.reset();
      snackbar("Email is not valid");
    }
  }
}
