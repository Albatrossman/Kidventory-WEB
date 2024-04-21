import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:kidventory_flutter/core/ui/component/button.dart';

import 'package:kidventory_flutter/core/ui/component/image_picker.dart';
import 'package:kidventory_flutter/core/ui/util/message_mixin.dart';
import 'package:kidventory_flutter/core/ui/util/navigation_mixin.dart';
import 'package:rounded_loading_button_plus/rounded_loading_button.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _EditProfileScreenState();
  }
}

class _EditProfileScreenState extends State<EditProfileScreen>
    with MessageMixin, NavigationMixin {
  final TextEditingController _firstnameController = TextEditingController();
  final TextEditingController _lastnameController = TextEditingController();
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
                    onImageSelected: (File image) => {},
                    width: 100,
                    height: 100,
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
                        top: 32.0, bottom: kIsWeb ? 72.0 : 0.0),
                    child: saveButton(context),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
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
      onPressed: () => {},
    );
  }
}
