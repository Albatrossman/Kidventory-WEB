import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:kidventory_flutter/core/domain/util/datetime_ext.dart';
import 'package:kidventory_flutter/core/ui/component/event_option.dart';
import 'package:kidventory_flutter/core/ui/component/image_picker.dart';
import 'package:kidventory_flutter/core/ui/util/message_mixin.dart';
import 'package:kidventory_flutter/core/ui/util/navigation_mixin.dart';
import 'package:kidventory_flutter/core/ui/util/picker_mixin.dart';
import 'package:kidventory_flutter/feature/main/edit_event/edit_event_screen_viewmodel.dart';
import 'package:provider/provider.dart';

class EditEventScreen extends StatefulWidget {
  const EditEventScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _EditEventScreenState();
  }
}

class _EditEventScreenState extends State<EditEventScreen>
    with MessageMixin, NavigationMixin, PickerMixin {
  late final EditEventScreenViewModel _viewModel;

  final TextEditingController _nameController = TextEditingController();
  String selectedOption = 'Does not repeat';

  @override
  void initState() {
    super.initState();
    _viewModel = Provider.of<EditEventScreenViewModel>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => pop(),
          icon: const Icon(CupertinoIcons.arrow_left),
        ),
        title: const Text('Create Event'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              Row(
                children: [
                  AppImagePicker(
                    onImageSelected: (File image) => {},
                    width: 72,
                    height: 72,
                  ),
                  const SizedBox(width: 16.0),
                  Expanded(
                    child: TextField(
                      controller: _nameController,
                      maxLines: 1,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(8.0),
                          ),
                        ),
                        label: Text("Name"),
                      ),
                      keyboardType: TextInputType.name,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32.0),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Theme.of(context).colorScheme.outlineVariant),
                  borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 8.0),
                      child: Text(
                        'Occurrence',
                        style: Theme.of(context)
                            .textTheme
                            .labelSmall
                            ?.copyWith(color: Theme.of(context).colorScheme.outline),
                      ),
                    ),
                    EventOption(
                      leading: Icon(
                        CupertinoIcons.calendar_circle,
                        color: Theme.of(context).colorScheme.primary,
                        size: 20.0,
                      ),
                      label: selectedDate.formatDate(),
                      onTap: () => datePicker(context, minDate: DateTime.now().atStartOfDay),
                    ),
                    const SizedBox(height: 4.0),
                    const Divider(
                      height: 1.0,
                      indent: 28 + 16,
                    ),
                    const SizedBox(height: 4.0),
                    EventOption(
                      label: 'Repeat',
                      onTap: () => {showOptions()},
                      trailing: Container(
                        width: 120,
                        height: 32.0,
                        decoration: BoxDecoration(
                          border: Border.all(color: Theme.of(context).colorScheme.outlineVariant),
                          borderRadius: BorderRadius.circular(96.0),
                        ),
                        child: Center(child: Text(selectedOption)),
                      ),
                    ),
                    const SizedBox(height: 4.0),
                    const Divider(
                      height: 1.0,
                      indent: 28 + 16,
                    ),
                    const SizedBox(height: 4.0),
                    EventOption(
                      label: 'All day',
                      onTap: () => {_viewModel.toggleAllDay()},
                      trailing: Consumer<EditEventScreenViewModel>(
                        builder: (_, viewModel, __) {
                          return Switch(
                            value: _viewModel.state.allDay,
                            onChanged: (_) => _viewModel.toggleAllDay(),
                          );
                        },
                      ),
                    ),
                    AnimatedSize(
                      duration: const Duration(milliseconds: 300),
                      child: Consumer<EditEventScreenViewModel>(
                        builder: (_, viewModel, __) {
                          return viewModel.state.allDay
                              ? const SizedBox.shrink()
                              : Column(
                                  children: [
                                    const SizedBox(height: 4.0),
                                    const Divider(
                                      height: 1.0,
                                      indent: 28 + 16,
                                    ),
                                    const SizedBox(height: 4.0),
                                    EventOption(
                                      leading: Icon(
                                        CupertinoIcons.clock,
                                        color: Theme.of(context).colorScheme.primary,
                                        size: 20.0,
                                      ),
                                      label: '9:00 AM - 10:00 AM',
                                      onTap: () => {},
                                    ),
                                  ],
                                );
                        },
                      ),
                    ),
                    const SizedBox(height: 12.0),
                  ],
                ),
              ),
              EventOption(
                leading: Icon(
                  CupertinoIcons.person_crop_circle_badge_plus,
                  color: Theme.of(context).colorScheme.primary,
                  size: 20.0,
                ),
                label: 'Invite members',
                onTap: () => {},
                trailing: Icon(
                  size: 20,
                  CupertinoIcons.chevron_up,
                  color: Theme.of(context).colorScheme.outlineVariant,
                ),
              ),
              EventOption(
                leading: Icon(
                  CupertinoIcons.videocam_circle,
                  color: Theme.of(context).colorScheme.primary,
                  size: 20.0,
                ),
                label: 'Online location',
                onTap: () => {},
                trailing: Icon(
                  size: 20,
                  CupertinoIcons.chevron_up,
                  color: Theme.of(context).colorScheme.outlineVariant,
                ),
              ),
              EventOption(
                leading: Container(
                  height: 20.0,
                  width: 20.0,
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      border: Border.all(color: Theme.of(context).colorScheme.outlineVariant),
                      shape: BoxShape.circle),
                ),
                label: 'Color',
                onTap: () => {},
                trailing: Icon(
                  size: 20,
                  CupertinoIcons.chevron_up,
                  color: Theme.of(context).colorScheme.outlineVariant,
                ),
              ),
              EventOption(
                leading: Icon(
                  CupertinoIcons.pencil_circle,
                  color: Theme.of(context).colorScheme.primary,
                  size: 20.0,
                ),
                label: 'Description',
                onTap: () => {},
                trailing: Icon(
                  size: 20,
                  CupertinoIcons.chevron_up,
                  color: Theme.of(context).colorScheme.outlineVariant,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showOptions() {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return CupertinoActionSheet(
          title: const Text("Repeat Options"),
          actions: <Widget>[
            _buildActionSheetOption("Does not repeat"),
            _buildActionSheetOption("Every day"),
            _buildActionSheetOption("Every week"),
            _buildActionSheetOption("Every month"),
            _buildActionSheetOption("Custom", isCustom: true),
          ],
          cancelButton: CupertinoActionSheetAction(
            child: const Text('Cancel'),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        );
      },
    );
  }

  Widget _buildActionSheetOption(String option, {bool isCustom = false}) {
    return CupertinoActionSheetAction(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(option),
          if (selectedOption == option)
            const Icon(CupertinoIcons.check_mark, color: CupertinoColors.activeBlue),
        ],
      ),
      onPressed: () {
        setState(() {
          selectedOption = option;
        });
        Navigator.pop(context);
        if (isCustom) {
          showCustomBottomSheet();
        }
      },
    );
  }

  void showCustomBottomSheet() {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 250,
          color: Colors.white,
          child: const Center(
            child: Text("Custom repeat option"),
          ),
        );
      },
    );
  }
}
