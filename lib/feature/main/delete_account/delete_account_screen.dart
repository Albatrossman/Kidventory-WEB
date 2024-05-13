import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:kidventory_flutter/core/data/service/http/auth_api_service.dart';
import 'package:kidventory_flutter/core/data/service/preferences/token_preferences_manager.dart';
import 'package:kidventory_flutter/core/ui/component/button.dart';
import 'package:kidventory_flutter/core/ui/util/extension/string_extension.dart';
import 'package:kidventory_flutter/core/ui/util/mixin/message_mixin.dart';
import 'package:kidventory_flutter/core/ui/util/mixin/navigation_mixin.dart';
import 'package:kidventory_flutter/di/app_module.dart';
import 'package:kidventory_flutter/feature/auth/sign_in/sign_in_screen.dart';
import 'package:kidventory_flutter/feature/main/delete_account/delete_account_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:rounded_loading_button_plus/rounded_loading_button.dart';

class DeleteAccountScreen extends StatefulWidget {
  final String email;

  const DeleteAccountScreen({super.key, required this.email});

  @override
  State<StatefulWidget> createState() {
    return _DeleteAccountScreenState();
  }
}

class _DeleteAccountScreenState extends State<DeleteAccountScreen>
    with MessageMixin, NavigationMixin {
  late final DeleteAccountScreenViewModel _viewModel;

  final TextEditingController _passwordController = TextEditingController();
  final RoundedLoadingButtonController _btnController =
      RoundedLoadingButtonController();

  bool newPasswordsMatch = true;
  bool passwordStrong = true;

  @override
  void initState() {
    _viewModel = DeleteAccountScreenViewModel(
        getIt<AuthApiService>(), getIt<TokenPreferencesManager>());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<DeleteAccountScreenViewModel>.value(
      value: _viewModel,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => pop(),
            icon: const Icon(CupertinoIcons.chevron_left),
          ),
          title: DefaultTextStyle(
            style: Theme.of(context).textTheme.titleSmall ?? const TextStyle(),
            child: const Text('Delete Account'),
          ),
          centerTitle: true,
        ),
        body: SafeArea(
          child: Center(
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
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(bottom: 16.0),
                            child: Icon(
                                size: 64,
                                CupertinoIcons.exclamationmark_triangle),
                          ),
                          SizedBox(
                            width: 350,
                            child: Text(
                              "Attention",
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge
                                  ?.copyWith(
                                    color:
                                        Theme.of(context).colorScheme.onSurface,
                                  )
                                  .copyWith(fontWeight: FontWeight.bold),
                            ),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          const Text(
                              "Deleting your account is irreversible. By proceeding with this action, you will permanently erase all of your account information, including the details of any associated children and the records of events you've attended. This cannot be undone.\n\nAre you sure you want to proceed with the deletion of your account?"),
                          const SizedBox(
                            height: 8,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 16.0),
                            child: currentPasswordField(context),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 32.0, bottom: kIsWeb ? 72.0 : 0.0),
                      child: deleteAccountButton(context),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget currentPasswordField(BuildContext context) {
    return TextField(
      controller: _passwordController,
      maxLines: 1,
      decoration: const InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(8.0),
          ),
        ),
        label: Text("Confirm Password"),
      ),
      keyboardType: TextInputType.visiblePassword,
      textCapitalization: TextCapitalization.none,
      obscureText: true,
      enableSuggestions: false,
      autocorrect: false,
    );
  }

  Widget deleteAccountButton(BuildContext context) {
    return AppButton(
      controller: _btnController,
      onPressed: () => {_onSave(context)},
      color: Theme.of(context).colorScheme.error,
      child: Text(
        'Delete my account',
        style: Theme.of(context).textTheme.labelLarge?.copyWith(
              color: Theme.of(context).colorScheme.onPrimary,
            ),
      ),
    );
  }

  void _onSave(BuildContext context) async {
    setState(() {});
    if (newPasswordsMatch && passwordStrong) {
      _viewModel
          .deleteAccount(
            widget.email,
            _passwordController.text,
          )
          .whenComplete(() => _btnController.reset())
          .then(
            (value) => {
              _viewModel
                  .signOut()
                  .whenComplete(() => _pushToSignInScreen(context))
            },
            onError: (error) => {
              snackbar(
                  (error as DioException).message ?? "Something went wrong"),
            },
          );
    } else {
      _btnController.reset();
      snackbar("Passwords does not match");
    }
  }

  void _pushToSignInScreen(BuildContext context) {
    Navigator.pop(context);
    pushAndClear(const SignInScreen());
  }
}
