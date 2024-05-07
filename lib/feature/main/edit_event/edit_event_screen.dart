import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kidventory_flutter/core/domain/model/repeat_end.dart';
import 'package:kidventory_flutter/core/domain/model/repeat_unit.dart';
import 'package:kidventory_flutter/core/domain/util/datetime_ext.dart';
import 'package:kidventory_flutter/core/ui/component/button.dart';
import 'package:kidventory_flutter/core/ui/component/event_option.dart';
import 'package:kidventory_flutter/core/ui/component/image_picker.dart';
import 'package:kidventory_flutter/core/ui/util/extension/color_extension.dart';
import 'package:kidventory_flutter/core/ui/util/extension/date_time_extension.dart';
import 'package:kidventory_flutter/core/ui/util/mixin/message_mixin.dart';
import 'package:kidventory_flutter/core/ui/util/mixin/navigation_mixin.dart';
import 'package:kidventory_flutter/core/ui/util/mixin/picker_mixin.dart';
import 'package:kidventory_flutter/core/ui/util/model/weekday.dart';
import 'package:kidventory_flutter/feature/main/add_members/add_members_screen.dart';
import 'package:kidventory_flutter/feature/main/color/color_screen.dart';
import 'package:kidventory_flutter/feature/main/description/description_screen.dart';
import 'package:kidventory_flutter/feature/main/edit_event/edit_event_screen_viewmodel.dart';
import 'package:kidventory_flutter/feature/main/event/event_screen.dart';
import 'package:kidventory_flutter/feature/main/online_location/online_location_screen.dart';
import 'package:kidventory_flutter/feature/main/repeat/repeat_screen.dart';
import 'package:kidventory_flutter/feature/main/roster/roster_screen.dart';
import 'package:provider/provider.dart';
import 'package:rounded_loading_button_plus/rounded_loading_button.dart';

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
  final RoundedLoadingButtonController _btnController = RoundedLoadingButtonController();
  String selectedOption = 'Does not repeat';
  File? _selectedImage;

  @override
  void initState() {
    super.initState();
    _viewModel = Provider.of<EditEventScreenViewModel>(context, listen: false);
    _nameController.text = _viewModel.state.name ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => pop(),
          icon: const Icon(CupertinoIcons.back),
        ),
        title: const Text('Create Event'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                Row(
                  children: [
                    AppImagePicker(
                      onImageSelected: (File image) => {_selectedImage = image},
                      width: 72,
                      height: 72,
                      currentImage: "",
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
                      EventOption.withText(
                        leading: Icon(
                          CupertinoIcons.calendar,
                          color: Theme.of(context).colorScheme.primary,
                          size: 20.0,
                        ),
                        label: selectedDate.formatDate(),
                        onTap: () => datePicker(context, firstDate: DateTime.now().atStartOfDay),
                      ),
                      const SizedBox(height: 4.0),
                      const Divider(
                        height: 1.0,
                        indent: 28 + 16,
                      ),
                      const SizedBox(height: 4.0),
                      EventOption.withText(
                        label: 'Repeat',
                        onTap: () => {showOptions()},
                        leading: Icon(
                          CupertinoIcons.repeat,
                          color: Theme.of(context).colorScheme.primary,
                          size: 20.0,
                        ),
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
                      EventOption.withText(
                        label: 'All day',
                        leading: Icon(
                          CupertinoIcons.sun_max,
                          color: Theme.of(context).colorScheme.primary,
                          size: 20.0,
                        ),
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
                                ? const SizedBox(width: double.infinity, height: 0)
                                : Column(
                                    children: [
                                      const SizedBox(height: 4.0),
                                      const Divider(
                                        height: 1.0,
                                        indent: 28 + 16,
                                      ),
                                      const SizedBox(height: 4.0),
                                      EventOption.withWidget(
                                        leading: Icon(
                                          CupertinoIcons.clock,
                                          color: Theme.of(context).colorScheme.primary,
                                          size: 20.0,
                                        ),
                                        label: Row(
                                          children: [
                                            Consumer<EditEventScreenViewModel>(
                                              builder: (_, model, __) {
                                                return CupertinoButton(
                                                  padding: EdgeInsets.zero,
                                                  onPressed: () => {
                                                    timePicker(
                                                      context,
                                                      onTimeChanged: (time) =>
                                                          {_viewModel.selectedStartTime(time)},
                                                      title: const Text('Select Start Time'),
                                                      initialTime: model.state.startTime,
                                                    ),
                                                  },
                                                  child: Text(
                                                    model.state.startTime.formatted,
                                                    style: Theme.of(context).textTheme.labelMedium,
                                                  ),
                                                );
                                              },
                                            ),
                                            const SizedBox(width: 16.0),
                                            const Text('-'),
                                            const SizedBox(width: 16.0),
                                            Consumer<EditEventScreenViewModel>(
                                              builder: (_, model, __) {
                                                return CupertinoButton(
                                                  padding: EdgeInsets.zero,
                                                  onPressed: () => {
                                                    timePicker(context,
                                                        onTimeChanged: (time) =>
                                                            {_viewModel.selectedEndTime(time)},
                                                        title: const Text('Select End Time'),
                                                        initialTime: model.state.endTime,
                                                        minimumTime: model.state.startTime
                                                            .roundedToNextQuarter()),
                                                  },
                                                  child: Text(
                                                    model.state.endTime.formatted,
                                                    style: Theme.of(context).textTheme.labelMedium,
                                                  ),
                                                );
                                              },
                                            ),
                                          ],
                                        ),
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
                const SizedBox(height: 16),
                EventOption.withText(
                  leading: Icon(
                    CupertinoIcons.person_crop_circle_badge_plus,
                    color: Theme.of(context).colorScheme.primary,
                    size: 20.0,
                  ),
                  label: 'Add members',
                  onTap: () => pushSheet(
                    Consumer<EditEventScreenViewModel>(builder: (_, model, __) {
                      return AddMembersScreen(
                        filesAndParticipants: model.state.filesAndParticipants,
                        onDownloadTemplateClick: () async {
                          await _viewModel.downloadCSVTemplate();
                        },
                        onImportCSVClick: () async {
                          File? file = await csvPicker();

                          if (file != null) {
                            _viewModel.importCSV(file);
                          }
                        },
                        onRemoveCSVClick: (file) => _viewModel.removeCSV(file),
                        onCSVFileClick: (file) => pushSheet(RosterScreen(
                            members: model.state.filesAndParticipants[file] ?? List.empty())),
                      );
                    }),
                  ),
                  trailing: Icon(
                    size: 20,
                    CupertinoIcons.chevron_up,
                    color: Theme.of(context).colorScheme.outlineVariant,
                  ),
                ),
                EventOption.withText(
                  leading: Icon(
                    CupertinoIcons.videocam_circle,
                    color: Theme.of(context).colorScheme.primary,
                    size: 20.0,
                  ),
                  label: 'Online location',
                  onTap: () => pushSheet(const OnlineLocationScreen()),
                  trailing: Icon(
                    size: 20,
                    CupertinoIcons.chevron_up,
                    color: Theme.of(context).colorScheme.outlineVariant,
                  ),
                ),
                EventOption.withText(
                  leading: Consumer<EditEventScreenViewModel>(
                    builder: (_, model, __) {
                      return Container(
                        height: 20.0,
                        width: 20.0,
                        decoration: BoxDecoration(
                            color: model.state.color.value,
                            border: Border.all(color: Theme.of(context).colorScheme.outlineVariant),
                            shape: BoxShape.circle),
                      );
                    },
                  ),
                  label: 'Color',
                  onTap: () => pushSheet(const ColorScreen()),
                  trailing: Icon(
                    size: 20,
                    CupertinoIcons.chevron_up,
                    color: Theme.of(context).colorScheme.outlineVariant,
                  ),
                ),
                EventOption.withText(
                  leading: Icon(
                    CupertinoIcons.pencil_circle,
                    color: Theme.of(context).colorScheme.primary,
                    size: 20.0,
                  ),
                  label: 'Description',
                  onTap: () => pushSheet(const DescriptionScreen()),
                  trailing: Icon(
                    size: 20,
                    CupertinoIcons.chevron_up,
                    color: Theme.of(context).colorScheme.outlineVariant,
                  ),
                ),
                const SizedBox(
                  height: 32,
                ),
                _buildSaveButton(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSaveButton(BuildContext context) {
    return AppButton(
      controller: _btnController,
      onPressed: () => _viewModel
          .createEvent(
            _nameController.text,
            _selectedImage != null ? base64Encode(_selectedImage!.readAsBytesSync()) : null,
            selectedDate,
          )
          .whenComplete(() => _btnController.reset())
          .then(
        (value) => replace(EventScreen(id: value)),
        onError: (error) {
          String message = 'Something went wrong';
          if (error is DioException) {
            message = error.message ?? message;
          }

          snackbar(message);
        },
      ),
      child: Text(
        'Save',
        style: Theme.of(context).textTheme.labelLarge?.copyWith(
          color: Theme.of(context).colorScheme.onPrimary,
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
            _buildActionSheetOption("Does not repeat", unit: RepeatUnit.day),
            _buildActionSheetOption("Every day", unit: RepeatUnit.day),
            _buildActionSheetOption("Every week", unit: RepeatUnit.week),
            _buildActionSheetOption("Every month", unit: RepeatUnit.month),
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

  Widget _buildActionSheetOption(String option, {bool isCustom = false, RepeatUnit? unit}) {
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
          DateTime now = DateTime.now();
          int? maxOccurrence;
          DateTime? endDateTime;
          int? period;
          RepeatEnd? endsOnMode;
          List<WeekDay>? daysOfWeek;

          if (option == "Does not repeat") {
            period = 1;
            endsOnMode = RepeatEnd.afterOccurrence;
            maxOccurrence = 1;
            endDateTime = null;
          } else if (option == "Every day") {
            period = 1;
            unit = RepeatUnit.day;
            endsOnMode = RepeatEnd.onDate;
            endDateTime = _viewModel.state.repeat.endDatetime.copyWith(
              year: now.year + 1,
              month: now.month,
              day: now.day,
            );
          } else if (option == "Every week") {
            period = 1;
            unit = RepeatUnit.week;
            endsOnMode = RepeatEnd.onDate;
            endDateTime = _viewModel.state.repeat.endDatetime.copyWith(
              year: now.year + 1,
              month: now.month,
              day: now.day,
            );
            daysOfWeek = [WeekDay.now()];
          } else if (option == "Every month") {
            period = 1;
            unit = RepeatUnit.month;
            endsOnMode = RepeatEnd.onDate;
            endDateTime = _viewModel.state.repeat.endDatetime.copyWith(
              year: now.year + 1,
              month: now.month,
              day: now.day,
            );
          }

          selectedOption = option;
          _viewModel.editRepeat(
            period ?? _viewModel.state.repeat.period,
            unit ?? _viewModel.state.repeat.unit,
            daysOfWeek ?? _viewModel.state.repeat.daysOfWeek ?? [],
            endsOnMode ?? _viewModel.state.repeat.endsOnMode,
            endDateTime ?? _viewModel.state.repeat.endDatetime,
            maxOccurrence ?? _viewModel.state.repeat.maxOccurrence,
          );
        });
        Navigator.pop(context);
        if (isCustom) {
          pushSheet(const RepeatScreen());
        }
      },
    );
  }
}
