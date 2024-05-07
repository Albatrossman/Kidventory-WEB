import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:kidventory_flutter/core/data/service/http/user_api_service.dart';
import 'package:kidventory_flutter/core/ui/component/button.dart';
import 'package:kidventory_flutter/core/ui/component/image_picker.dart';
import 'package:kidventory_flutter/core/ui/util/mixin/message_mixin.dart';
import 'package:kidventory_flutter/core/ui/util/mixin/navigation_mixin.dart';
import 'package:kidventory_flutter/core/ui/util/model/user_info.dart';
import 'package:kidventory_flutter/di/app_module.dart';
import 'package:kidventory_flutter/feature/main/edit_profile/edit_profile_screen_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:rounded_loading_button_plus/rounded_loading_button.dart';

class EditProfileScreen extends StatefulWidget {
    final UserInfo? userInfo;
  const EditProfileScreen({super.key, this.userInfo});

  @override
  State<StatefulWidget> createState() {
    return _EditProfileScreenState();
  }
}

class _EditProfileScreenState extends State<EditProfileScreen> with MessageMixin, NavigationMixin {
    late final EditProfileScreenViewModel _viewModel;

  final TextEditingController _firstnameController = TextEditingController();
  final TextEditingController _lastnameController = TextEditingController();
  final RoundedLoadingButtonController _btnController = RoundedLoadingButtonController();

  bool validFirstname = true;
  bool validLastname = true;
  bool isDeleting = false;
  File? _selectedImage;

  @override
  void initState() {
    _firstnameController.text = widget.userInfo?.firstName ?? "";
    _lastnameController.text = widget.userInfo?.lastName ?? "";
    _viewModel = EditProfileScreenViewModel(getIt<UserApiService>());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<EditProfileScreenViewModel>.value(
      value: _viewModel,
      child: Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => pop(),
          icon: const Icon(CupertinoIcons.arrow_left),
        ),
        title: const Text('Edit Profile'),
        centerTitle: true,
      ),
      body: Center(
        heightFactor: kIsWeb ? null : 1.0,
        child: SingleChildScrollView(
          clipBehavior: Clip.none,
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  const SizedBox(height: 16.0),
                  AppImagePicker(
                    onImageSelected: (File image) => {
                      _selectedImage = image
                    },
                    width: 100,
                    height: 100,
                    currentImage: widget.userInfo?.image ?? "",
                  ),
                  SizedBox(
                    width: kIsWeb ? 420 : null,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 32.0),
                          child: firstNameField(context),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 16.0),
                          child: lastNameField(context),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 32.0),
                    child: saveButton(context),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    ),);
  }

  Widget firstNameField(BuildContext context) {
    return TextField(
      controller: _firstnameController,
      maxLines: 1,
      decoration: const InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(8.0),
          ),
        ),
        label: Text("First Name"),
      ),
      keyboardType: TextInputType.name,
    );
  }

  Widget lastNameField(BuildContext context) {
    return TextField(
      controller: _lastnameController,
      maxLines: 1,
      decoration: const InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(8.0),
          ),
        ),
        label: Text("Last Name"),
      ),
      keyboardType: TextInputType.name,
    );
  }

  Widget saveButton(BuildContext context) {
    return AppButton(
      controller: _btnController,
      child: Text(
        "Save",
        style: Theme.of(context).textTheme.labelLarge?.copyWith(
              color: Theme.of(context).colorScheme.onPrimary,
            ),
      ),
      onPressed: () => {_onSave(context, widget.userInfo!)},
    );
  }

  void _onSave(BuildContext context, UserInfo info) async {
    setState(() {
      validFirstname = _firstnameController.text.isNotEmpty;
      validLastname = _lastnameController.text.isNotEmpty;
    });
    if (validFirstname && validLastname) {
      _viewModel
          .editUser(
            _firstnameController.text,
            _lastnameController.text,
            _selectedImage == null ? null : info.image,
            _selectedImage == null
                ? null
                : base64Encode(_selectedImage!.readAsBytesSync()),
          )
          .whenComplete(() => _btnController.reset())
          .then(
            (value) => pop(),
            onError: (error) => {
              snackbar((error as DioException).message ?? "Something went wrong"),
            },
          );
    } else {
      _btnController.reset();
      snackbar("First name and last name is required");
    }
  }
}
