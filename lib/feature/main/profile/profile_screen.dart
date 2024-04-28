import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kidventory_flutter/core/ui/component/child_row.dart';
import 'package:kidventory_flutter/core/ui/component/clickable.dart';
import 'package:kidventory_flutter/core/ui/component/option.dart';
import 'package:kidventory_flutter/core/ui/util/mixin/message_mixin.dart';
import 'package:kidventory_flutter/core/ui/util/mixin/navigation_mixin.dart';
import 'package:kidventory_flutter/core/ui/util/model/child_info.dart';
import 'package:kidventory_flutter/feature/auth/sign_in/sign_in_screen.dart';
import 'package:kidventory_flutter/feature/main/change_password/change_password_screen.dart';
import 'package:kidventory_flutter/feature/main/edit_child/edit_child_screen.dart';
import 'package:kidventory_flutter/feature/main/edit_profile/edit_profile_screen.dart';
import 'package:kidventory_flutter/feature/main/profile/profile_screen_viewmodel.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _ProfileScreenState();
  }
}

class _ProfileScreenState extends State<ProfileScreen>
    with MessageMixin, NavigationMixin {
  late final ProfileScreenViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = Provider.of<ProfileScreenViewModel>(context, listen: false);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Consumer<ProfileScreenViewModel>(
                  builder: (_, model, __) {
                    return accountButton(context);
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0.0),
                child: Text(
                  "Children",
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        color: Theme.of(context).colorScheme.outline,
                      ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Consumer<ProfileScreenViewModel>(
                      builder: (_, model, __) {
                        if (model.state.profile?.children?.isEmpty ?? true) {
                          if (model.state.loading) {
                            return const SizedBox(
                                height: 64,
                                child:
                                    Center(child: CircularProgressIndicator()));
                          } else {
                            return Padding(
                              padding: const EdgeInsets.all(8),
                              child: Container(
                                width: double.infinity,
                                height: 64,
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade300,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                alignment: Alignment.center,
                                child: const Text("You have no children"),
                              ),
                            );
                          }
                        } else {
                          return childList(context);
                        }
                      },
                    ),
                    addChildButton(context),
                  ],
                ),
              ),
              const Divider(),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                child: Text(
                  "Account".toUpperCase(),
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: Theme.of(context).colorScheme.outline,
                      ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Column(
                  children: [
                    changePasswordButton(context),
                    signOutButton(context),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget childList(BuildContext context) {
    return ListView.separated(
      physics: const BouncingScrollPhysics(),
      shrinkWrap: true,
      itemCount: _viewModel.state.profile?.children?.length ?? 0,
      separatorBuilder: (context, index) => const SizedBox(
        height: 8,
      ),
      itemBuilder: (context, index) {
        ChildInfo child =
            _viewModel.state.profile!.children![index].convertToChildInfo();
        return childRow(
          context,
          child,
        );
      },
    );
  }

  Widget childRow(BuildContext context, ChildInfo info) {
    return Clickable(
      onPressed: () => {push(EditChildScreen(childInfo: info))},
      child: ChildRow(info: info),
    );
  }

  Widget accountButton(BuildContext context) {
    return CupertinoButton(
      padding: const EdgeInsets.only(right: 8.0),
      onPressed: () => push(const EditProfileScreen()),
      child: Row(
        children: [
          Container(
            width: 56.0,
            height: 56.0,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Theme.of(context).colorScheme.outlineVariant,
                width: 1.0,
              ),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(_viewModel.state.profile?.avatarUrl ?? ""),
              ),
            ),
          ),
          const SizedBox(width: 8.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${_viewModel.state.profile?.firstName ?? ""} ${_viewModel.state.profile?.lastName ?? ""}",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Text(
                _viewModel.state.profile?.email ?? "",
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
          const Spacer(),
          Icon(
            CupertinoIcons.slider_horizontal_3,
            color: Theme.of(context).colorScheme.outline,
          ),
        ],
      ),
    );
  }

  Widget addChildButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
      child: SizedBox(
        width: double.infinity,
        height: 40,
        child: FilledButton(
          onPressed: () => push(const EditChildScreen()),
          child: const Text("Add New Child"),
        ),
      ),
    );
  }

  Widget changePasswordButton(BuildContext context) {
    return Option(
      icon: CupertinoIcons.lock_fill,
      iconBackgroundColor: Theme.of(context).colorScheme.primaryContainer,
      iconColor: Theme.of(context).colorScheme.onPrimaryContainer,
      label: 'Change Password',
      onTap: () => push(const ChangePasswordScreen()),
      trailing: const Icon(CupertinoIcons.forward),
    );
  }

  Widget signOutButton(BuildContext context) {
    return Option(
      icon: CupertinoIcons.arrow_left_circle_fill,
      iconBackgroundColor: Theme.of(context).colorScheme.errorContainer,
      iconColor: Theme.of(context).colorScheme.onErrorContainer,
      label: 'Sign Out',
      onTap: () => {
        dialog(
          const Text("Sign Out"),
          const Text(
              "Are you sure you want to sign out? You will need to sign in again to access your account."),
          [
            CupertinoDialogAction(
              isDefaultAction: true,
              onPressed: () => {Navigator.pop(context)},
              child: const Text("No"),
            ),
            CupertinoDialogAction(
              isDestructiveAction: true,
              onPressed: () => {
                _viewModel
                    .signOut()
                    .whenComplete(() => _pushToSignInScreen(context))
              },
              child: const Text("Yes"),
            ),
          ],
        ),
      },
    );
  }

  void _pushToSignInScreen(BuildContext context) {
    Navigator.pop(context);
    pushAndClear(const SignInScreen());
  }
}
