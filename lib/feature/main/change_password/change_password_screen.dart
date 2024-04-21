import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:kidventory_flutter/core/ui/component/button.dart';
import 'package:kidventory_flutter/core/ui/util/mixin/message_mixin.dart';
import 'package:kidventory_flutter/core/ui/util/mixin/navigation_mixin.dart';
import 'package:rounded_loading_button_plus/rounded_loading_button.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _ChangePasswordScreenState();
  }
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> with MessageMixin, NavigationMixin {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _newPasswordConfirmationController =
      TextEditingController();
  final RoundedLoadingButtonController _btnController =
      RoundedLoadingButtonController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    padding: const EdgeInsets.only(top: 32.0, bottom: kIsWeb ? 72.0 : 0.0),
                    child: savePasswordButton(context),
                  ),
                ],
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
      decoration: const InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(8.0),
          ),
        ),
        label: Text("New Password"),
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
      decoration: const InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(8.0),
          ),
        ),
        label: Text("Confirm New Password"),
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
      onPressed: () => {},
      child: Text(
        'Save',
        style: Theme.of(context).textTheme.labelLarge?.copyWith(
              color: Theme.of(context).colorScheme.onPrimary,
            ),
      ),
    );
  }
}
