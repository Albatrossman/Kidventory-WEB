import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kidventory_flutter/core/domain/model/color.dart';
import 'package:kidventory_flutter/core/ui/component/clickable.dart';
import 'package:kidventory_flutter/core/ui/component/sheet_header.dart';
import 'package:kidventory_flutter/core/ui/util/extension/color_extension.dart';
import 'package:kidventory_flutter/core/ui/util/mixin/message_mixin.dart';
import 'package:kidventory_flutter/core/ui/util/mixin/navigation_mixin.dart';
import 'package:kidventory_flutter/core/ui/util/mixin/picker_mixin.dart';
import 'package:kidventory_flutter/feature/main/edit_event/edit_event_screen_viewmodel.dart';
import 'package:provider/provider.dart';

class ColorScreen extends StatefulWidget {
  const ColorScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _ColorScreenState();
  }
}

class _ColorScreenState extends State<ColorScreen> with MessageMixin, NavigationMixin, PickerMixin {
  late final EditEventScreenViewModel _viewModel;

  @override
  void initState() {
    _viewModel = Provider.of<EditEventScreenViewModel>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SheetHeader(title: Text('Event color')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 6, // Number of columns
              crossAxisSpacing: 16.0, // Horizontal space between items
              mainAxisSpacing: 16.0, // Vertical space between items
              childAspectRatio: 1, // Aspect ratio of each item
            ),
            itemCount: EventColor.values.length,
            itemBuilder: (context, index) {
              EventColor color = EventColor.values[index];
              return Tooltip(
                message: color.name,
                child: ClipOval(
                  child: Clickable(
                    onPressed: () => {
                      _viewModel.selectColor(color),
                      pop(),
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: color.value,
                        shape: BoxShape.circle,
                      ),
                      child: Consumer<EditEventScreenViewModel>(
                        builder: (context, model, child) {
                          return model.state.color == color
                              ? const Icon(CupertinoIcons.checkmark)
                              : const SizedBox.shrink();
                        },
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
