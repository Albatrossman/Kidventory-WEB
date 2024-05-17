import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kidventory_flutter/core/data/service/http/user_api_service.dart';
import 'package:kidventory_flutter/core/domain/util/datetime_ext.dart';
import 'package:kidventory_flutter/core/ui/component/button.dart';
import 'package:kidventory_flutter/core/ui/component/image_picker.dart';
import 'package:kidventory_flutter/core/ui/component/option.dart';
import 'package:kidventory_flutter/core/ui/util/mixin/message_mixin.dart';
import 'package:kidventory_flutter/core/ui/util/mixin/navigation_mixin.dart';
import 'package:kidventory_flutter/core/ui/util/mixin/picker_mixin.dart';
import 'package:kidventory_flutter/core/ui/util/model/child_info.dart';
import 'package:kidventory_flutter/di/app_module.dart';
import 'package:kidventory_flutter/feature/main/edit_child/edit_child_screen_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:rounded_loading_button_plus/rounded_loading_button.dart';
import 'package:share_plus/share_plus.dart';

class EditChildScreen extends StatefulWidget {
  final ChildInfo? childInfo;
  const EditChildScreen({super.key, this.childInfo});

  @override
  State<StatefulWidget> createState() {
    return _EditChildScreenState();
  }
}

class _EditChildScreenState extends State<EditChildScreen>
    with MessageMixin, NavigationMixin, PickerMixin {
  late final EditChildScreenViewModel _viewModel;

  final TextEditingController _firstnameController = TextEditingController();
  final TextEditingController _lastnameController = TextEditingController();
  final RoundedLoadingButtonController _btnController =
      RoundedLoadingButtonController();

  String _relation = "";
  DateTime _selectedDate = DateTime.now().atStartOfDay;
  bool validFirstname = true;
  bool validLastname = true;
  bool isDeleting = false;
  XFile? _selectedImage;

  @override
  void initState() {
    _firstnameController.text = widget.childInfo?.firstName ?? "";
    _lastnameController.text = widget.childInfo?.lastName ?? "";
    _relation = widget.childInfo?.relation ?? "None";
    _selectedDate = widget.childInfo?.birthday ?? DateTime.now().atStartOfDay;
    _viewModel = EditChildScreenViewModel(getIt<UserApiService>());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<EditChildScreenViewModel>.value(
      value: _viewModel,
      child: Stack(
        children: [
          Scaffold(
            appBar: AppBar(
              leading: IconButton(
                onPressed: () => pop(),
                icon: const Icon(CupertinoIcons.chevron_left),
              ),
              title: DefaultTextStyle(
                style:
                    Theme.of(context).textTheme.titleSmall ?? const TextStyle(),
                child:
                    Text(widget.childInfo == null ? "Add Child" : 'Edit Child'),
              ),
              centerTitle: true,
            ),
            body: Center(
              heightFactor: kIsWeb ? null : 1.0,
              child: SingleChildScrollView(
                clipBehavior: Clip.none,
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      children: [
                        const SizedBox(height: 16.0),
                        AppImagePicker(
                          onImageSelected: (XFile image) =>
                              {_selectedImage = image},
                          width: 100,
                          height: 100,
                          currentImage: widget.childInfo?.image ?? "",
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
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(12.0)),
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
                        const SizedBox(height: 16),
                        if (widget.childInfo != null) deleteButton(context)
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          if (isDeleting)
            Container(
              width: double.infinity,
              height: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey.shade300.withAlpha(200),
                borderRadius: BorderRadius.circular(8),
              ),
              alignment: Alignment.center,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
        ],
      ),
    );
  }

  Widget firstNameField(BuildContext context) {
    return TextField(
      controller: _firstnameController,
      maxLines: 1,
      decoration: InputDecoration(
        errorText: validFirstname ? null : "First name is required",
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(8.0),
          ),
        ),
        label: const Text("First Name"),
      ),
      keyboardType: TextInputType.name,
    );
  }

  Widget lastNameField(BuildContext context) {
    return TextField(
      controller: _lastnameController,
      maxLines: 1,
      decoration: InputDecoration(
        errorText: validLastname ? null : "Last Name is required",
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(8.0),
          ),
        ),
        label: const Text("Last Name"),
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
      trailing: Text(
        _selectedDate.formatDate(),
      ),
    );
  }

  Widget relationOption(BuildContext context) {
    return Option(
      icon: CupertinoIcons.person_alt_circle_fill,
      iconBackgroundColor: Theme.of(context).colorScheme.primaryContainer,
      iconColor: Theme.of(context).colorScheme.onPrimaryContainer,
      label: "Relation",
      onTap: () => {_showRelationPicker()},
      trailing: Text(_relation),
    );
  }

  Widget saveButton(BuildContext context) {
    return AppButton(
      controller: _btnController,
      child: Text(
        widget.childInfo == null ? "Add" : "Save",
        style: Theme.of(context).textTheme.labelLarge?.copyWith(
              color: Theme.of(context).colorScheme.onPrimary,
            ),
      ),
      onPressed: () => {
        if (widget.childInfo == null)
          {_onAdd(context)}
        else
          {_onSave(context, widget.childInfo!)}
      },
    );
  }

  Widget deleteButton(BuildContext context) {
    return SizedBox(
      width: kIsWeb ? 350 : 600,
      child: OutlinedButton(
        onPressed: () => {deleteConfirmationDialog(widget.childInfo!)},
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: Theme.of(context).colorScheme.error),
        ),
        child: Text(
          "Delete",
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                color: Theme.of(context).colorScheme.error,
              ),
        ),
      ),
    );
  }

  void _showDatePicker() {
    datePicker(
      context,
      firstDate: DateTime(1900),
      lastDate: DateTime.now().add(const Duration(minutes: 1)),
      initialDateTime: _selectedDate,
      onSelectedDate: (date) => {
        setState(() {
          _selectedDate = date.atStartOfDay;
        })
      },
    );
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
                setState(() {
                  _relation = "Son";
                });
                Navigator.pop(context);
              },
            ),
            CupertinoActionSheetAction(
              child: const Text("Daughter"),
              onPressed: () {
                setState(() {
                  _relation = "Daughter";
                });
                Navigator.pop(context);
              },
            ),
            CupertinoActionSheetAction(
              child: const Text("None"),
              onPressed: () {
                setState(() {
                  _relation = "None";
                });
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

  void deleteConfirmationDialog(ChildInfo info) {
    dialog(
      const Text("Delete Child"),
      const Text(
          "Are you sure you want to delete this child?\nAll information such as events and attendance will be lost forever."),
      [
        CupertinoDialogAction(
          isDefaultAction: true,
          onPressed: () => {Navigator.pop(context)},
          child: const Text("Cancel"),
        ),
        CupertinoDialogAction(
          isDestructiveAction: true,
          onPressed: () => {_onDelete(context, info)},
          child: const Text("Delete"),
        ),
      ],
    );
  }

  void _onSave(BuildContext context, ChildInfo info) async {
    setState(() {
      validFirstname = _firstnameController.text.isNotEmpty;
      validLastname = _lastnameController.text.isNotEmpty;
    });
    if (validFirstname && validLastname) {
      Uint8List? imageBytes;
      if (_selectedImage!= null) {
        imageBytes = await _selectedImage!.readAsBytesAsync();
      }
      _viewModel
          .editChild(
            info.id,
            _firstnameController.text,
            _lastnameController.text,
            _selectedDate,
            _relation,
            imageBytes == null ? info.image : null,
            imageBytes == null
                ? null
                : base64Encode(imageBytes),
          )
          .whenComplete(() => _btnController.reset())
          .then(
            (value) => pop(),
            onError: (error) => {
              snackbar(
                  (error as DioException).message ?? "Something went wrong"),
            },
          );
    } else {
      _btnController.reset();
      snackbar("First name and last name is required");
    }
  }

  void _onAdd(BuildContext context) async {
    setState(() {
      validFirstname = _firstnameController.text.isNotEmpty;
      validLastname = _lastnameController.text.isNotEmpty;
    });
    if (validFirstname && validLastname) {
      Uint8List? imageBytes;
      if (_selectedImage!= null) {
        imageBytes = await _selectedImage!.readAsBytesAsync();
      }
      _viewModel
          .createChild(
            _firstnameController.text,
            _lastnameController.text,
            _selectedDate,
            _relation,
            null,
            imageBytes == null
                ? null
                : base64Encode(imageBytes),
          )
          .whenComplete(() => _btnController.reset())
          .then(
            (value) => pop(),
            onError: (error) => {
              snackbar(
                  (error as DioException).message ?? "Something went wrong"),
            },
          );
    } else {
      _btnController.reset();
      snackbar("First name and last name is required");
    }
  }

  void _onDelete(BuildContext context, ChildInfo info) async {
    pop();
    setState(() {
      isDeleting = true;
    });
    _viewModel.deleteChild(info.id).whenComplete(() => isDeleting = true).then(
          (value) => pop(),
          onError: (error) => {
            snackbar((error as DioException).message ?? "Something went wrong"),
          },
        );
  }
}
