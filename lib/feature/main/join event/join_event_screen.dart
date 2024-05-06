import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kidventory_flutter/core/data/model/child_dto.dart';
import 'package:kidventory_flutter/core/data/model/invited_event_dto.dart';
import 'package:kidventory_flutter/core/data/model/join_from_invite_dto.dart';
import 'package:kidventory_flutter/core/data/service/http/event_api_service.dart';
import 'package:kidventory_flutter/core/data/service/http/user_api_service.dart';
import 'package:kidventory_flutter/core/ui/component/button.dart';
import 'package:kidventory_flutter/core/ui/component/join_member_card.dart';
import 'package:kidventory_flutter/core/ui/component/sheet_header.dart';
import 'package:kidventory_flutter/core/ui/util/mixin/message_mixin.dart';
import 'package:kidventory_flutter/core/ui/util/mixin/navigation_mixin.dart';
import 'package:kidventory_flutter/di/app_module.dart';
import 'package:kidventory_flutter/feature/main/edit_child/edit_child_screen.dart';
import 'package:kidventory_flutter/feature/main/join%20event/join_event_screen_viewmodel.dart';
import 'package:kidventory_flutter/main.dart';
import 'package:provider/provider.dart';
import 'package:rounded_loading_button_plus/rounded_loading_button.dart';

class JoinEventScreen extends StatefulWidget {
  final InvitedEventDto invitedEventDto;
  const JoinEventScreen({super.key, required this.invitedEventDto});

  @override
  State<StatefulWidget> createState() {
    return _JoinEventScreenState();
  }
}

class _JoinEventScreenState extends State<JoinEventScreen>
    with MessageMixin, NavigationMixin, RouteAware {
  late final JoinEventScreenViewModel _viewModel;
  final RoundedLoadingButtonController _loadingButtonController =
      RoundedLoadingButtonController();

  List<String> selectedMembers = [];
  bool includeMeAsAdult = false;
  bool isPrivate() => widget.invitedEventDto.isPrivate;

  @override
  void initState() {
    super.initState();
    _viewModel = JoinEventScreenViewModel(
        getIt<UserApiService>(), getIt<EventApiService>());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context) as PageRoute<dynamic>);
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  @override
  void didPopNext() {
    _viewModel.getProfile();
    super.didPopNext();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<JoinEventScreenViewModel>.value(
      value: _viewModel,
      child: Scaffold(
        appBar: const SheetHeader(title: Text("Join Event")),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                header(context),
                mainContent(context),
                joinButton(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget header(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.invitedEventDto.eventDto.name,
                  style: Theme.of(context).textTheme.titleMedium,
                  overflow: TextOverflow.ellipsis,
                ),
                Row(
                  children: [
                    Text(
                        "${DateFormat.jm().format(widget.invitedEventDto.eventDto.repeat.startDateTime)} - ${DateFormat.jm().format(widget.invitedEventDto.eventDto.repeat.endDateTime)}"),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  "Please select who you'd like to enroll",
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                ),
                const SizedBox(height: 8),
              ],
            ),
            const Spacer(),
            // CupertinoButton(
            //   padding: EdgeInsets.zero,
            //   child: const Icon(
            //     CupertinoIcons.info_circle,
            //     size: 28,
            //   ),
            //   onPressed: () => {},
            // ),
          ],
        ));
  }

  Widget mainContent(BuildContext context) {
    return Consumer<JoinEventScreenViewModel>(
      builder: (context, model, child) {
        if (model.state.loading) {
          return loadingView(context);
        } else {
          return scrollableList(context, model);
        }
      },
    );
  }

  Widget joinButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      child: AppButton(
        controller: _loadingButtonController,
        child: Text(
          isPrivate() ? "Request to Join" : "Join",
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                color: Theme.of(context).colorScheme.onPrimary,
              ),
        ),
        onPressed: () => {_onJoin()},
      ),
    );
  }

  Widget scrollableList(BuildContext context, JoinEventScreenViewModel model) {
    return Expanded(
      child: SizedBox(
          width: 800,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(8),
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: Column(
              children: [
                JoinMemberCard(
                  name:
                      "${model.state.profile!.firstName} ${model.state.profile!.lastName}",
                  onClick: () => {
                    setState(
                      () {
                        includeMeAsAdult = !includeMeAsAdult;
                      },
                    )
                  },
                  imageUrl: model.state.profile!.avatarUrl,
                  isSelected: includeMeAsAdult,
                ),
                Column(
                  children: List.generate(
                      model.state.profile!.children?.length ?? 0, (index) {
                    final ChildDto child =
                        model.state.profile!.children![index];
                    return JoinMemberCard(
                      name: "${child.firstName} ${child.lastName}",
                      onClick: () => {
                        setState(
                          () {
                            if (selectedMembers.contains(child.id)) {
                              selectedMembers.remove(child.id);
                            } else {
                              selectedMembers.add(child.id);
                            }
                          },
                        )
                      },
                      imageUrl: child.avatarUrl,
                      isSelected: selectedMembers.contains(child.id),
                    );
                  }),
                ),
                JoinMemberCard(
                  name: "Add New Child",
                  onClick: () => {
                    setState(
                      () {
                        push(const EditChildScreen(childInfo: null));
                      },
                    )
                  },
                  imageUrl: "plus",
                  isSelected: false,
                )
              ],
            ),
          )),
    );
  }

  Widget loadingView(BuildContext context) {
    return const Expanded(
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  void _onJoin() {
    final JoinFromInvitetDto request = JoinFromInvitetDto(
      includeMeAsAdult: includeMeAsAdult,
      memberIds: selectedMembers,
    );
    if (isPrivate()) {
      _viewModel
          .joinPrivateEvent(
            widget.invitedEventDto.eventDto.id,
            request,
          )
          .whenComplete(() => _loadingButtonController.reset())
          .then(
            (value) => pop(),
            onError: (error) => {
              snackbar(
                  (error as DioException).message ?? "Something went wrong"),
            },
          );
    } else {
      _viewModel
          .joinPublicEvent(
            widget.invitedEventDto.eventDto.id,
            request,
          )
          .whenComplete(() => _loadingButtonController.reset())
          .then(
            (value) => pop(),
            onError: (error) => {
              snackbar(
                  (error as DioException).message ?? "Something went wrong"),
            },
          );
    }
  }
}
