import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:kidventory_flutter/core/data/service/http/auth_api_service.dart';
import 'package:kidventory_flutter/core/ui/component/button.dart';
import 'package:kidventory_flutter/core/ui/util/extension/string_extension.dart';
import 'package:kidventory_flutter/core/ui/util/mixin/message_mixin.dart';
import 'package:kidventory_flutter/core/ui/util/mixin/navigation_mixin.dart';
import 'package:kidventory_flutter/di/app_module.dart';
import 'package:kidventory_flutter/feature/main/change_password/change_password_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:rounded_loading_button_plus/rounded_loading_button.dart';

class ChangePasswordScreen extends StatefulWidget {
  final String email;

  const ChangePasswordScreen(
      {super.key, required this.email});

  @override
  State<StatefulWidget> createState() {
    return _ChangePasswordScreenState();
  }
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen>
    with MessageMixin, NavigationMixin {
  late final ChangePasswordScreenViewModel _viewModel;

  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _newPasswordConfirmationController =
      TextEditingController();
  final RoundedLoadingButtonController _btnController =
      RoundedLoadingButtonController();

  bool newPasswordsMatch = true;
  bool passwordStrong = true;

  @override
  void initState() {
    _viewModel = ChangePasswordScreenViewModel(
        getIt<AuthApiService>()); 

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ChangePasswordScreenViewModel>.value(
      value: _viewModel,
      child: Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => pop(),
          icon: const Icon(CupertinoIcons.arrow_left),
        ),
        title: const Text('Change Password'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Center(
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
                          child: currentPasswordField(context),
                        ),
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
        ),
      ),
    ),);
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
        label: Text("Current Password"),
      ),
      keyboardType: TextInputType.visiblePassword,
      textCapitalization: TextCapitalization.none,
      obscureText: true,
      enableSuggestions: false,
      autocorrect: false,
    );
  }

  Widget newPasswordField(BuildContext context) {
    return TextField(
      controller: _newPasswordController,
      maxLines: 1,
      decoration: InputDecoration(
        errorText: passwordStrong
            ? newPasswordsMatch
                ? null
                : ""
            : "",
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
      controller: _newPasswordConfirmationController,
      maxLines: 1,
      decoration: InputDecoration(
        errorMaxLines: 6,
        errorText: passwordStrong
            ? newPasswordsMatch
                ? null
                : "Passwords do not match"
            : "Password must contain at least:\nOne special character\nOne number,\nOne capital letter\nAnd be at least 6 characters long",
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
      controller: _btnController,
      onPressed: () => {_onSave(context)},
      child: Text(
        'Save',
        style: Theme.of(context).textTheme.labelLarge?.copyWith(
              color: Theme.of(context).colorScheme.onPrimary,
            ),
      ),
    );
  }

  void _onSave(BuildContext context) async {
    setState(() {
      newPasswordsMatch = (_newPasswordConfirmationController.text ==
          _newPasswordController.text);
      passwordStrong = _newPasswordController.text.isStrongForPassowrd();
    });
    if (newPasswordsMatch && passwordStrong) {
      _viewModel
          .changePassword(
            widget.email,
            _passwordController.text,
            _newPasswordController.text,
            _newPasswordConfirmationController.text,
          )
          .whenComplete(() => _btnController.reset())
          .then(
            (value) => pop(),
            onError: (error) => {
              snackbar(error.toString()),
            },
          );
    } else {
      _btnController.reset();
      if (!passwordStrong) {
        snackbar("Password is not strong enough");
      } else if (!newPasswordsMatch) {
        snackbar("Passwords do not match");
      }
    }
  }
}
