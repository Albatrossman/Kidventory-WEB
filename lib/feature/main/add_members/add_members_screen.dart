import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kidventory_flutter/core/domain/model/member.dart';
import 'package:kidventory_flutter/core/ui/component/csv_card.dart';

class AddMembersScreen extends StatelessWidget {
  final Map<File, List<Member>> filesAndParticipants;
  final Function onDownloadTemplateClick;
  final Function onImportCSVClick;
  final Function(File file) onRemoveCSVClick;
  final Function(File file) onCSVFileClick;

  const AddMembersScreen({
    super.key,
    required this.filesAndParticipants,
    required this.onImportCSVClick,
    required this.onRemoveCSVClick,
    required this.onDownloadTemplateClick,
    required this.onCSVFileClick,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Members')),
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
                          'Please ensure that the CSV file you upload matches the provided format for proper parsing. It\'s important to note that columns marked with an asterisk (*) are mandatory and must be filled when adding a record.',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        const SizedBox(height: 8.0),
                        TextButton(
                          onPressed: () => onDownloadTemplateClick(),
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
                onPressed: () => onImportCSVClick(),
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
                child: ListView.builder(
                  itemCount: filesAndParticipants.length,
                  itemBuilder: (context, index) {
                    File file = filesAndParticipants.keys.elementAt(index);
                    return Column(
                      children: [
                        CSVCard(
                          file: file,
                          members: filesAndParticipants[file]!,
                          onClick: () => onCSVFileClick(file),
                          onRemoveClick: () => onRemoveCSVClick(file),
                        ),
                        const SizedBox(height: 8.0),
                      ],
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