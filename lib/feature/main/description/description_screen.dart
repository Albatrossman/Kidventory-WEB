import 'package:flutter/material.dart';
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

  @override
  void initState() {
    _viewModel = Provider.of<EditEventScreenViewModel>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: TextField(
            minLines: 3,
            maxLines: null,
            maxLength: 255,
            keyboardType: TextInputType.multiline,
            decoration: InputDecoration(border: OutlineInputBorder(), hintText: 'Enter a description'),
          ),
        ),
      ),
    );
  }
}
