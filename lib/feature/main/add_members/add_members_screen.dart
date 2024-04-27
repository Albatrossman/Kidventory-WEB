import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kidventory_flutter/core/ui/component/csv_card.dart';
import 'package:kidventory_flutter/core/ui/component/sheet_header.dart';
import 'package:kidventory_flutter/core/ui/util/mixin/message_mixin.dart';
import 'package:kidventory_flutter/core/ui/util/mixin/navigation_mixin.dart';
import 'package:kidventory_flutter/core/ui/util/mixin/picker_mixin.dart';
import 'package:kidventory_flutter/feature/main/edit_event/edit_event_screen_viewmodel.dart';
import 'package:kidventory_flutter/feature/main/roster/roster_screen.dart';
import 'package:provider/provider.dart';

class AddMembersScreen extends StatefulWidget {
  const AddMembersScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _AddMembersScreenState();
  }
}

class _AddMembersScreenState extends State<AddMembersScreen>
    with MessageMixin, NavigationMixin, PickerMixin {
  late final EditEventScreenViewModel _viewModel;

  @override
  void initState() {
    _viewModel = Provider.of<EditEventScreenViewModel>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SheetHeader(title: Text('Add Members')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(8)),
                child: Container(
                  color: Colors.amberAccent.shade100,
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      children: [
                        Text(
                          'Please ensure that the CSV file you upload matches the provided format for proper parsing. it\'s important to note that columns marked with an asterisk (*) are mandatory and must be filled when adding a record.',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        const SizedBox(height: 8.0),
                        TextButton(
                          onPressed: () => {},
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                CupertinoIcons.cloud_download_fill,
                                color: Colors.amber.shade900,
                              ),
                              const SizedBox(width: 8.0),
                              Text(
                                'Download Template',
                                style: Theme.of(context)
                                    .textTheme
                                    .labelSmall
                                    ?.copyWith(color: Colors.amber.shade900),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              OutlinedButton(
                onPressed: () async {
                  File? file = await csvPicker();

                  if (file != null) {
                    _viewModel.importCSV(file);
                  }
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(CupertinoIcons.add_circled),
                    SizedBox(width: 8.0),
                    Text('Import CSV'),
                  ],
                ),
              ),
              const SizedBox(height: 16.0),
              Expanded(
                child: Consumer<EditEventScreenViewModel>(
                  builder: (context, model, child) {
                    return ListView.builder(
                      itemCount: model.state.filesAndParticipants.length,
                      itemBuilder: (context, index) {
                        File file = model.state.filesAndParticipants.keys.elementAt(index);
                        return Column(
                          children: [
                            CSVCard(
                              file: file,
                              members: model.state.filesAndParticipants[file]!,
                              onClick: () => pushSheet(RosterScreen(members: model.state.filesAndParticipants[file] ?? List.empty())),
                              onRemoveClick: () => _viewModel.removeCSV(file),
                            ),
                            const SizedBox(height: 8.0),
                          ],
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
