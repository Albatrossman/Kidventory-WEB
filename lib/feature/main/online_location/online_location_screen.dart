import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kidventory_flutter/core/ui/util/mixin/message_mixin.dart';
import 'package:kidventory_flutter/core/ui/util/mixin/navigation_mixin.dart';
import 'package:kidventory_flutter/feature/main/edit_event/edit_event_screen_viewmodel.dart';
import 'package:provider/provider.dart';

class OnlineLocationScreen extends StatefulWidget {
  const OnlineLocationScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _OnlineLocationScreenState();
  }
}

class _OnlineLocationScreenState extends State<OnlineLocationScreen>
    with MessageMixin, NavigationMixin {
  late final EditEventScreenViewModel _viewModel;

  int _selectedIndex = 0; // Default to the first image being selected

  final List<String> _imagePaths = [
    'assets/images/app_meet_active.png',
    'assets/images/app_skype_active.png',
    'assets/images/app_zoom_active.png',
  ];
  final List<String> _bwImagePaths = [
    'assets/images/app_meet_inactive.png',
    'assets/images/app_skype_inactive.png',
    'assets/images/app_zoom_inactive.png',
  ];
  final TextEditingController _linkController = TextEditingController();
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _commentController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _pinController = TextEditingController();

  @override
  void initState() {
    _viewModel = Provider.of<EditEventScreenViewModel>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Platform'),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: List.generate(_imagePaths.length, (index) {
                  return IconButton(
                    onPressed: () => setState(() {
                      _selectedIndex = index;
                    }),
                    icon: Image.asset(
                      _selectedIndex == index ? _imagePaths[index] : _bwImagePaths[index],
                      width: 48,
                      fit: BoxFit.contain,
                    ),
                  );
                }),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _linkController,
                maxLines: 1,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(8.0),
                    ),
                  ),
                  label: Text("Session Link"),
                ),
                keyboardType: TextInputType.url,
                textInputAction: TextInputAction.next,
                textCapitalization: TextCapitalization.none,
                autocorrect: false,
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _idController,
                maxLines: 1,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(8.0),
                    ),
                  ),
                  label: Text("Meeting ID"),
                ),
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                textCapitalization: TextCapitalization.none,
                autocorrect: false,
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _passwordController,
                maxLines: 1,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(8.0),
                    ),
                  ),
                  label: Text("Password"),
                ),
                keyboardType: TextInputType.visiblePassword,
                textInputAction: TextInputAction.next,
                textCapitalization: TextCapitalization.none,
                autocorrect: false,
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _commentController,
                maxLines: 1,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(8.0),
                    ),
                  ),
                  label: Text("Comment"),
                ),
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                textCapitalization: TextCapitalization.none,
                autocorrect: false,
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _phoneController,
                maxLines: 1,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(8.0),
                    ),
                  ),
                  label: Text("Phone"),
                ),
                keyboardType: TextInputType.phone,
                textInputAction: TextInputAction.next,
                textCapitalization: TextCapitalization.none,
                autocorrect: false,
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _pinController,
                maxLines: 1,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(8.0),
                    ),
                  ),
                  label: Text("Pin"),
                ),
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.done,
                textCapitalization: TextCapitalization.none,
                autocorrect: false,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
