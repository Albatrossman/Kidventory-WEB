import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kidventory_flutter/core/data/model/role_dto.dart';
import 'package:kidventory_flutter/core/data/service/csv/csv_parser.dart';
import 'package:kidventory_flutter/core/data/service/http/event_api_service.dart';
import 'package:kidventory_flutter/core/data/util/downloader/downloader.dart';
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
import 'package:kidventory_flutter/di/app_module.dart';
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
  final RoundedLoadingButtonController _btnController =
      RoundedLoadingButtonController();
  String selectedOption = 'Never';
  File? _selectedImage;
  DateTime _selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    _viewModel = EditEventScreenViewModel(
      getIt<CSVParser>(),
      getIt<EventApiService>(),
      getIt<Downloader>(),
    );
    _nameController.text = _viewModel.state.name;
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<EditEventScreenViewModel>.value(
      value: _viewModel,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => pop(),
            icon: const Icon(CupertinoIcons.back),
          ),
          title: DefaultTextStyle(
            style: Theme.of(context).textTheme.titleSmall ?? const TextStyle(),
            child: const Text('Create Event'),
          ),
          centerTitle: true,
        ),
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: SizedBox(
                width: 600,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          AppImagePicker(
                            onImageSelected: (File image) =>
                                {_selectedImage = image},
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
                          border: Border.all(
                              color:
                                  Theme.of(context).colorScheme.outlineVariant),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(8.0)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 12.0),
                            EventOption.withText(
                              leading: Icon(
                                CupertinoIcons.calendar,
                                color: Theme.of(context).colorScheme.primary,
                                size: 20.0,
                              ),
                              trailing: Text(
                                _selectedDate.formatDate(),
                                style: Theme.of(context).textTheme.labelMedium,
                              ),
                              label: "Start date",
                              onTap: () => datePicker(
                                context,
                                firstDate: DateTime.now().atStartOfDay,
                                onSelectedDate: (date) {
                                  setState(() {
                                    _selectedDate = date;
                                  });
                                },
                              ),
                            ),
                            const SizedBox(height: 4.0),
                            _buildDivider(context),
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
                                  border: Border.all(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .outlineVariant),
                                  borderRadius: BorderRadius.circular(96.0),
                                ),
                                child: Center(child: Text(selectedOption)),
                              ),
                            ),
                            const SizedBox(height: 4.0),
                            _buildDivider(context),
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
                                      ? const SizedBox(
                                          width: double.infinity, height: 0)
                                      : _buildStartEndTimePicker(context);
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
                          ChangeNotifierProvider<
                              EditEventScreenViewModel>.value(
                            value: _viewModel,
                            child: Consumer<EditEventScreenViewModel>(
                              builder: (_, model, __) {
                                return AddMembersScreen(
                                  filesAndParticipants:
                                      model.state.filesAndParticipants,
                                  onDownloadTemplateClick: () async {
                                    await _viewModel.downloadCSVTemplate();
                                  },
                                  onImportCSVClick: () async {
                                    File? file = await csvPicker();

                                    if (file != null) {
                                      _viewModel.importCSV(file);
                                    }
                                  },
                                  onRemoveCSVClick: (file) =>
                                      _viewModel.removeCSV(file),
                                  onCSVFileClick: (file) => pushSheet(
                                      RosterScreen(
                                          members: model.state
                                                  .filesAndParticipants[file] ??
                                              List.empty())),
                                );
                              },
                            ),
                          ),
                        ),
                        trailing: Icon(
                          size: 20,
                          CupertinoIcons.chevron_up,
                          color: Theme.of(context).colorScheme.outlineVariant,
                        ),
                      ),
                      const SizedBox(height: 8),
                      EventOption.withText(
                        leading: Icon(
                          CupertinoIcons.videocam_circle,
                          color: Theme.of(context).colorScheme.primary,
                          size: 20.0,
                        ),
                        label: 'Online location',
                        onTap: () => pushSheet(
                          ChangeNotifierProvider<
                              EditEventScreenViewModel>.value(
                            value: _viewModel,
                            child: const OnlineLocationScreen(),
                          ),
                        ),
                        trailing: Icon(
                          size: 20,
                          CupertinoIcons.chevron_up,
                          color: Theme.of(context).colorScheme.outlineVariant,
                        ),
                      ),
                      const SizedBox(height: 8),
                      EventOption.withText(
                        leading: Consumer<EditEventScreenViewModel>(
                          builder: (_, model, __) {
                            return Container(
                              height: 20.0,
                              width: 20.0,
                              decoration: BoxDecoration(
                                  color: model.state.color.value,
                                  border: Border.all(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .outlineVariant),
                                  shape: BoxShape.circle),
                            );
                          },
                        ),
                        label: 'Color',
                        onTap: () => pushSheet(
                          ChangeNotifierProvider<
                              EditEventScreenViewModel>.value(
                            value: _viewModel,
                            child: const ColorScreen(),
                          ),
                        ),
                        trailing: Icon(
                          size: 20,
                          CupertinoIcons.chevron_up,
                          color: Theme.of(context).colorScheme.outlineVariant,
                        ),
                      ),
                      const SizedBox(height: 8),
                      EventOption.withText(
                        leading: Icon(
                          CupertinoIcons.pencil_circle,
                          color: Theme.of(context).colorScheme.primary,
                          size: 20.0,
                        ),
                        label: 'Description',
                        onTap: () => pushSheet(ChangeNotifierProvider<
                            EditEventScreenViewModel>.value(
                          value: _viewModel,
                          child: const DescriptionScreen(),
                        )),
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
          ),
        ),
      ),
    );
  }

  Widget _buildStartEndTimePicker(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 4.0),
        _buildDivider(context),
        const SizedBox(height: 8.0),
        Column(
          children: [
            Consumer<EditEventScreenViewModel>(
              builder: (_, model, __) {
                return EventOption.withText(
                  label: "Start time",
                  leading: Icon(
                    CupertinoIcons.sunrise,
                    color: Theme.of(context).colorScheme.primary,
                    size: 20.0,
                  ),
                  trailing: Text(
                    model.state.startTime.formatted,
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                  onTap: () {
                    timePicker(context,
                        onSelectedTime: (time) =>
                            {_viewModel.selectedStartTime(time)},
                        title: 'Start Time',
                        initialTime: model.state.startTime,
                        minimumTime: _selectedDate.isSameDay(DateTime.now())
                            ? null
                            : const TimeOfDay(hour: 0, minute: 0));
                  },
                );
              },
            ),
            Consumer<EditEventScreenViewModel>(
              builder: (_, model, __) {
                return EventOption.withText(
                  label: "End time",
                  leading: Icon(
                    CupertinoIcons.sunset,
                    color: Theme.of(context).colorScheme.primary,
                    size: 20.0,
                  ),
                  trailing: Text(
                    model.state.endTime.formatted,
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                  onTap: () {
                    timePicker(context,
                        onSelectedTime: (time) =>
                            {_viewModel.selectedEndTime(time)},
                        title: 'End Time',
                        initialTime: model.state.endTime,
                        minimumTime:
                            model.state.startTime.roundedToNextQuarter());
                  },
                );
              },
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDivider(BuildContext context) {
    return const Divider(
      indent: 28 + 16,
    );
  }

  Widget _buildSaveButton(BuildContext context) {
    return AppButton(
      controller: _btnController,
      onPressed: () => _viewModel
          .createEvent(
            _nameController.text,
            _selectedImage != null
                ? base64Encode(_selectedImage!.readAsBytesSync())
                : null,
            _selectedDate,
          )
          .whenComplete(() => _btnController.reset())
          .then(
        (value) => replace(EventScreen(
          id: value,
          role: RoleDto.owner,
        )),
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
            _buildActionSheetOption("Never", unit: RepeatUnit.day),
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

  Widget _buildActionSheetOption(String option,
      {bool isCustom = false, RepeatUnit? unit}) {
    return CupertinoActionSheetAction(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(option),
          if (selectedOption == option)
            const Icon(CupertinoIcons.check_mark,
                color: CupertinoColors.activeBlue),
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

          if (option == "Never") {
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
          pushSheet(
            ChangeNotifierProvider<EditEventScreenViewModel>.value(
              value: _viewModel,
              child: const RepeatScreen(),
            ),
          );
        }
      },
    );
  }
}

extension DateTimeExtension on DateTime {
  bool isSameDay(DateTime date) {
    return year == date.year && month == date.month && day == date.day;
  }
}
