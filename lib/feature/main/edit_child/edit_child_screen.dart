import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:kidventory_flutter/core/domain/util/datetime_ext.dart';
import 'package:kidventory_flutter/core/ui/component/button.dart';
import 'package:kidventory_flutter/core/ui/component/image_picker.dart';
import 'package:kidventory_flutter/core/ui/component/option.dart';
import 'package:kidventory_flutter/core/ui/util/mixin/message_mixin.dart';
import 'package:kidventory_flutter/core/ui/util/mixin/navigation_mixin.dart';
import 'package:kidventory_flutter/core/ui/util/mixin/picker_mixin.dart';
import 'package:kidventory_flutter/core/ui/util/model/child_info.dart';
import 'package:rounded_loading_button_plus/rounded_loading_button.dart';

class EditChildScreen extends StatefulWidget {
  final ChildInfo? childInfo;
  const EditChildScreen({super.key, this.childInfo});

  @override
  State<StatefulWidget> createState() {
    return _EditChildScreenState();
  }
}

class _EditChildScreenState extends State<EditChildScreen> with MessageMixin, NavigationMixin, PickerMixin {
  final TextEditingController _firstnameController = TextEditingController();
  final TextEditingController _lastnameController = TextEditingController();
  final RoundedLoadingButtonController _btnController =
      RoundedLoadingButtonController();

  // @override
  // void initState() {
  //   super.initState();
  //   _viewModel = Provider.of<EditChildScreenViewModel>(context, listen: false);
  // }

  @override
  void initState() {
    _firstnameController.text = widget.childInfo?.firstName ?? "";
    _lastnameController.text = widget.childInfo?.lastName ?? "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => pop(),
          icon: const Icon(CupertinoIcons.arrow_left),
        ),
        title: const Text('Edit Child'),
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
                        Padding(
                          padding: const EdgeInsets.only(top: 16.0),
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 1,
                                color: Theme.of(context)
                                    .colorScheme
                                    .outlineVariant,
                              ),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(12.0)),
                            ),
                            clipBehavior: Clip.antiAlias,
                            child: Column(
                              children: [
                                birthdayOption(context),
                                const Divider(height: 1.0, indent: 16.0),
                                relationOption(context),
                              ],
                            ),
                          ),
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

  Widget birthdayOption(BuildContext context) {
    return Option(
      icon: CupertinoIcons.calendar_circle_fill,
      iconBackgroundColor: Theme.of(context).colorScheme.primaryContainer,
      iconColor: Theme.of(context).colorScheme.onPrimaryContainer,
      label: "Birthday",
      onTap: () => {_showDatePicker()},
      trailing: Text(widget.childInfo?.birthday.formatDate() ?? selectedDate.formatDate()),
    );
  }

  Widget relationOption(BuildContext context) {
    return Option(
      icon: CupertinoIcons.person_alt_circle_fill,
      iconBackgroundColor: Theme.of(context).colorScheme.primaryContainer,
      iconColor: Theme.of(context).colorScheme.onPrimaryContainer,
      label: "Relation",
      onTap: () => {_showRelationPicker()},
      trailing: const Text("None"),
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

  void _showDatePicker() {
    datePicker(context, firstDate: DateTime(1900), lastDate: DateTime.now());
  }

  void _showRelationPicker() {
    
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return CupertinoActionSheet(
          title: const Text("Select Relation"),
          actions: [
            CupertinoActionSheetAction(
              child: const Text("Son"),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            CupertinoActionSheetAction(
              child: const Text("Daughter"),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            CupertinoActionSheetAction(
              child: const Text("None"),
              onPressed: () {
                widget.childInfo?.relation = "";
                Navigator.pop(context);
              },
            ),
          ],
          cancelButton: CupertinoActionSheetAction(
            onPressed: () {
              Navigator.pop(context);
            },
            isDestructiveAction: true,
            child: const Text("Cancel"),
          ),
        );
      },
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  color: CupertinoColors.separator.resolveFrom(context),
                  width: 0.0))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CupertinoButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          CupertinoButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Done'),
          ),
        ],
      ),
    );
  }
}
