import 'package:flutter/material.dart';
import 'package:kidventory_flutter/core/ui/component/clickable.dart';
import 'package:kidventory_flutter/core/ui/component/sheet_header.dart';
import 'package:kidventory_flutter/core/ui/util/mixin/message_mixin.dart';
import 'package:kidventory_flutter/core/ui/util/mixin/navigation_mixin.dart';
import 'package:kidventory_flutter/core/ui/util/mixin/picker_mixin.dart';
import 'package:kidventory_flutter/feature/main/edit_event/edit_event_screen_viewmodel.dart';
import 'package:provider/provider.dart';

class DescriptionScreen extends StatefulWidget {
  const DescriptionScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _DescriptionScreenState();
  }
}

class _DescriptionScreenState extends State<DescriptionScreen> with MessageMixin, NavigationMixin, PickerMixin {
  late final EditEventScreenViewModel _viewModel;
  final TextEditingController _descriptionController = TextEditingController();

  @override
  void initState() {
    _viewModel = Provider.of<EditEventScreenViewModel>(context, listen: false);
    _descriptionController.text = _viewModel.state.description;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SheetHeader(
        title: const Text('Description'),
        trailing: Clickable(
          onPressed: () => {
            _viewModel.editDescription(_descriptionController.text),
            pop()
          },
          child: const Text('Done'),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextField(
            controller: _descriptionController,
            minLines: 3,
            maxLines: null,
            maxLength: 255,
            keyboardType: TextInputType.multiline,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Enter a description',
            ),
          ),
        ),
      ),
    );
  }
}
