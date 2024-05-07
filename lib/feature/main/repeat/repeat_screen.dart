import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kidventory_flutter/core/domain/model/repeat_unit.dart';
import 'package:kidventory_flutter/core/domain/util/datetime_ext.dart';
import 'package:kidventory_flutter/core/ui/component/card.dart';
import 'package:kidventory_flutter/core/ui/component/clickable.dart';
import 'package:kidventory_flutter/core/ui/component/sheet_header.dart';
import 'package:kidventory_flutter/core/ui/component/weekday_picker.dart';
import 'package:kidventory_flutter/core/ui/util/mixin/message_mixin.dart';
import 'package:kidventory_flutter/core/ui/util/mixin/navigation_mixin.dart';
import 'package:kidventory_flutter/core/domain/model/repeat_end.dart';
import 'package:kidventory_flutter/core/ui/util/mixin/picker_mixin.dart';
import 'package:kidventory_flutter/core/ui/util/model/weekday.dart';
import 'package:kidventory_flutter/feature/main/edit_event/edit_event_screen_viewmodel.dart';
import 'package:provider/provider.dart';

class RepeatScreen extends StatefulWidget {
  const RepeatScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _RepeatScreenState();
  }
}

class _RepeatScreenState extends State<RepeatScreen>
    with PickerMixin, MessageMixin, NavigationMixin {
  final FixedExtentScrollController _periodController = FixedExtentScrollController();
  final TextEditingController _occurrenceController = TextEditingController();
  late final EditEventScreenViewModel _viewModel;
  RepeatEnd _selectedRepeatEnd = RepeatEnd.onDate;
  int period = 1;
  List<WeekDay> daysOfWeek = [];

  @override
  void initState() {
    _viewModel = Provider.of<EditEventScreenViewModel>(context, listen: false);
    _occurrenceController.text = "1";
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      // This will check if the controller is attached and if not, will not attempt to jump
      if (_periodController.hasClients) {
        _periodController.jumpToItem(_viewModel.state.repeat.period - 1);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SheetHeader(
        title: const Text('Custom recurrence'),
        trailing: Clickable(
          onPressed: () => {
            _viewModel.editRepeat(
              period,
              _viewModel.state.selectedRepeatUnit,
              daysOfWeek,
              _selectedRepeatEnd,
              selectedDate,
              _occurrenceController.text,
            ),
            pop()
          },
          child: const Text('Done'),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        'Repeats every',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        flex: 1,
                        child: SizedBox(
                          height: 100,
                          child: CupertinoPicker(
                            itemExtent: 32,
                            looping: true,
                            scrollController: _periodController,
                            onSelectedItemChanged: (int index) => {
                              setState(() {
                                period = index + 1;
                              })
                            },
                            children: List.generate(
                              30,
                              (int index) => Center(child: Text((index + 1).toString())),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: SizedBox(
                          height: 100,
                          child: CupertinoPicker(
                            itemExtent: 32,
                            onSelectedItemChanged: (int index) =>
                                _viewModel.selectRepeatUnit(RepeatUnit.values.elementAt(index)),
                            children: [
                              for (RepeatUnit unit in RepeatUnit.values)
                                Center(child: Text(unit.label)),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  AnimatedSize(
                    duration: const Duration(milliseconds: 300),
                    child: Consumer<EditEventScreenViewModel>(
                      builder: (_, model, __) {
                        return model.state.selectedRepeatUnit != RepeatUnit.week
                            ? const SizedBox(width: double.infinity, height: 0)
                            : Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.symmetric(vertical: 16.0),
                                    child: Divider(),
                                  ),
                                  const Text('Repeats on'),
                                  const SizedBox(height: 8.0),
                                  WeekdayPicker(
                                    initialSelectedDays: model.state.repeat.daysOfWeek ?? [WeekDay.now()],
                                    onSelectionChanged: (days) => {daysOfWeek = days},
                                  ),
                                ],
                              );
                      },
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                    child: Divider(),
                  ),
                  const Text('Ends'),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      RadioListTile<RepeatEnd>(
                        title: Row(
                          children: [
                            const Text('On'),
                            const SizedBox(width: 8.0),
                            InkWell(
                              onTap: () => {
                                datePicker(
                                  context,
                                  firstDate: _viewModel.state.repeat.startDatetime,
                                  initialDateTime: _viewModel.state.repeat.startDatetime
                                      .add(const Duration(days: 365)),
                                )
                              },
                              child: AppCard(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(selectedDate.formatDate()),
                                ),
                              ),
                            ),
                          ],
                        ),
                        value: RepeatEnd.onDate,
                        groupValue: _selectedRepeatEnd,
                        onChanged: (RepeatEnd? value) {
                          setState(() {
                            if (value != null) {
                              _selectedRepeatEnd = value;
                            }
                          });
                        },
                      ),
                      const Divider(indent: 72),
                      RadioListTile<RepeatEnd>(
                        title: Row(
                          children: [
                            const Text('After'),
                            const SizedBox(width: 8.0),
                            SizedBox(
                              width: 56,
                              child: AppCard(
                                child: Center(
                                  child: TextField(
                                      controller: _occurrenceController,
                                      decoration: const InputDecoration(
                                        isDense: true,
                                        border: InputBorder.none,
                                      ),
                                      keyboardType: TextInputType.number,
                                      textAlign: TextAlign.center,
                                      maxLines: 1),
                                ),
                              ),
                            ),
                            const SizedBox(width: 8.0),
                            const Text('Occurrence'),
                          ],
                        ),
                        value: RepeatEnd.afterOccurrence,
                        groupValue: _selectedRepeatEnd,
                        onChanged: (RepeatEnd? value) {
                          setState(() {
                            if (value != null) {
                              _selectedRepeatEnd = value;
                            }
                          });
                        },
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
