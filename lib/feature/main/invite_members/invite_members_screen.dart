import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kidventory_flutter/core/domain/util/datetime_ext.dart';
import 'package:kidventory_flutter/core/ui/component/button.dart';

import 'package:kidventory_flutter/core/ui/util/mixin/message_mixin.dart';
import 'package:kidventory_flutter/core/ui/util/mixin/navigation_mixin.dart';

import 'package:rounded_loading_button_plus/rounded_loading_button.dart';

class InviteMembersScreen extends StatefulWidget {
  const InviteMembersScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _InviteMembersScreenState();
  }
}

class _InviteMembersScreenState extends State<InviteMembersScreen> with MessageMixin, NavigationMixin {
  final TextEditingController _firstnameController = TextEditingController();
  final TextEditingController _lastnameController = TextEditingController();
  final RoundedLoadingButtonController _btnController =
      RoundedLoadingButtonController();

  final MaterialStateProperty<Icon?> _thumbIcon =
      MaterialStateProperty.resolveWith<Icon?>(
    (Set<MaterialState> states) {
      if (states.contains(MaterialState.selected)) {
        return const Icon(Icons.check);
      }
      return const Icon(Icons.close);
    },
  );

  late final String _inviteLink = "https://kidventory.baseballforce.com/invite?id=6612334a83788182defcbleb";
  bool _isPrivate = false;
  bool _canExpire = false;
  DateTime _expirationDate = DateTime.now().add(const Duration(days: 1));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => pop(),
          icon: const Icon(CupertinoIcons.arrow_left),
        ),
        title: const Text('Add Members'),
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
                  SizedBox(
                    width: kIsWeb ? 420 : null,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 32.0),
                          child: inviteLinkSection(context),
                        ),
                        const SizedBox(height: 16),
                        uploadCSVButton(context),
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

  Widget inviteLinkSection(BuildContext context) {
    return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          border:
              Border.all(color: Theme.of(context).colorScheme.outlineVariant),
          borderRadius: BorderRadius.circular(8),
        ),
        alignment: Alignment.centerLeft,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'Invite Link',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16.0),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(8),
              ),
              alignment: Alignment.centerLeft,
              child: SelectionArea(child: Text(_inviteLink)),
            ),
            const SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: SizedBox(
                    height: kIsWeb ? 40 : 32,
                    child: FilledButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateColor.resolveWith(
                              (states) => Theme.of(context)
                                  .colorScheme
                                  .primaryContainer)),
                      child: Text(
                        "Copy",
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onPrimaryContainer,
                            ),
                      ),
                      onPressed: () => {
                        Clipboard.setData(
                          ClipboardData(text: _inviteLink),
                        )
                      },
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: SizedBox(
                    height: kIsWeb ? 40 : 32,
                    child: FilledButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateColor.resolveWith(
                              (states) => Theme.of(context)
                                  .colorScheme
                                  .primaryContainer)),
                      child: Text(
                        "Share",
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onPrimaryContainer,
                            ),
                      ),
                      onPressed: () =>
                          {_btnController.stop(), _btnController.reset()},
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            inviteLinkOptions(context),
          ],
        ));

  }

  Widget inviteLinkOptions(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: Theme.of(context).colorScheme.outlineVariant),
        borderRadius: BorderRadius.circular(8),
      ),
      alignment: Alignment.centerLeft,
      child: Column(
        children: [
          expirationDateField(context),
          const Divider(),
          isPrivateModeToggle(context),
        ],
      ),
    );
  }

  Widget expirationDateField(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              "Expires",
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
            ),
            const Spacer(),
            Switch(
              thumbIcon: _thumbIcon,
              value: _canExpire,
              onChanged: (bool value) {
                setState(() {
                  _canExpire = value;
                });
              },
            ),
            // Text("Never"),
          ],
        ),
        AnimatedSize(
          duration: const Duration(milliseconds: 200),
          child: _canExpire
              ? Column(
                  children: [
                    const SizedBox(height: 8.0),
                    SizedBox(
                      height: 40,
                      width: 500,
                      child: OutlinedButton(
                        onPressed: _showDatePicker,
                        child: Text(
                          _expirationDate.formatDate(),
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(
                                color: Theme.of(context).colorScheme.primary,
                              ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8.0),
                  ],
                )
              : const SizedBox(width: double.infinity, height: 0),
        ),
      ],
    );
  }

  Widget isPrivateModeToggle(BuildContext context) {
    return Row(
      children: [
        Text(
          "Private",
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
              ),
        ),
        const Spacer(),
        Switch(
          thumbIcon: _thumbIcon,
          value: _isPrivate,
          onChanged: (bool value) {
            setState(() {
              _isPrivate = value;
            });
          },
        ),
      ],
    );
  }

  Widget uploadCSVButton(BuildContext context) {
    return SizedBox(
      width: 800,
      height: 40,
      child: OutlinedButton(
          onPressed: () => {},
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Upload CSV",
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                    ),
              ),
              const SizedBox(width: 8),
              const Icon(CupertinoIcons.plus),
            ],
          )),
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
    if (kIsWeb) {
      showDatePicker(
        context: context,
        firstDate: DateTime.now(),
        lastDate: DateTime(3000),
      ).then((selectedDate) =>
          {_expirationDate = selectedDate ?? _expirationDate});
    } else {
      showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: 260,
            padding: const EdgeInsets.only(top: 6),
            color: CupertinoColors.systemBackground.resolveFrom(context),
            child: Column(
              children: [
                // Header with done button
                _buildHeader(context),
                // Date picker
                Expanded(
                  child: CupertinoDatePicker(
                    mode: CupertinoDatePickerMode.date,
                    initialDateTime: DateTime.now(),
                    onDateTimeChanged: (DateTime date) {},
                    maximumDate: DateTime.now(),
                    minimumDate: DateTime(1900),
                  ),
                ),
              ],
            ),
          );
        },
      ).then((selectedDate) {
        _expirationDate = selectedDate;
      });
    }
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
            child: const Text('Cancel'),
            onPressed: () => Navigator.pop(context),
          ),
          CupertinoButton(
            child: const Text('Done'),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
